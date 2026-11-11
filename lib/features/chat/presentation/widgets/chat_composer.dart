import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/extensions/localization.dart';
import '../../domain/entities/chat.dart';
import 'chat_voice_player.dart';

class ChatComposer extends StatefulWidget {
  const ChatComposer({super.key, required this.sending, required this.onSend});
  final bool sending;
  final Future<bool> Function(String body, ChatUpload? upload) onSend;
  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer>
    with WidgetsBindingObserver {
  final _text = TextEditingController();
  AudioRecorder? _recorder;
  ChatUpload? _upload;
  Timer? _timer;
  bool _recording = false, _busy = false;
  int _seconds = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _text.addListener(_changed);
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_recording && state != AppLifecycleState.resumed) {
      unawaited(_finishRecording(cancel: true));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    final recorder = _recorder;
    if (recorder != null) {
      unawaited(() async {
        if (_recording) await recorder.cancel();
        await recorder.dispose();
      }());
    }
    _text.removeListener(_changed);
    _text.dispose();
    super.dispose();
  }

  void _error(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<void> _photo() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,

      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Iconsax.gallery),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(context.tr.chatPhotoLibrary),
              onTap: () => Navigator.pop(sheet, ImageSource.gallery),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Iconsax.camera),
              ),
              title: Text(context.tr.chatCamera),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),

              onTap: () => Navigator.pop(sheet, ImageSource.camera),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
    if (source == null || !mounted) return;
    setState(() => _busy = true);
    try {
      final photo = await ImagePicker().pickImage(
        source: source,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 85,
      );
      if (photo == null || !mounted) return;
      if (await photo.length() > 10 * 1024 * 1024) {
        if (mounted) _error(context.tr.chatMediaLimit);
        return;
      }
      final bytes = await photo.readAsBytes();
      final mime = lookupMimeType(photo.name, headerBytes: bytes) ?? '';
      if (![
        'image/jpeg',
        'image/png',
        'image/gif',
        'image/webp',
      ].contains(mime)) {
        if (mounted) _error(context.tr.chatMediaError);
        return;
      }
      if (mounted) {
        setState(
          () => _upload = ChatUpload(
            bytes: bytes,
            name: photo.name,
            mime: mime,
            kind: 'image',
          ),
        );
      }
    } catch (_) {
      if (mounted) _error(context.tr.chatMediaError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _record() async {
    if (_busy || widget.sending) return;
    if (_recording) {
      await _finishRecording();
      return;
    }
    setState(() => _busy = true);
    try {
      final recorder = _recorder ??= AudioRecorder();
      if (!await recorder.hasPermission()) {
        if (mounted) _error(context.tr.chatMicrophonePermission);
        return;
      }
      if (!mounted) return;
      final directory = kIsWeb ? '' : (await getTemporaryDirectory()).path;
      if (!mounted) return;
      await ChatVoicePlayer.pauseAll();
      await recorder.start(
        const RecordConfig(
          encoder: kIsWeb ? AudioEncoder.opus : AudioEncoder.aacLc,
          bitRate: 64000,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: '$directory/chat-record-${const Uuid().v4()}.m4a',
      );
      if (!mounted) {
        await recorder.cancel();
        return;
      }
      setState(() {
        _recording = true;
        _seconds = 0;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() => _seconds++);
        if (_seconds >= 120) unawaited(_finishRecording());
      });
    } catch (_) {
      if (mounted) _error(context.tr.chatMediaError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _finishRecording({bool cancel = false}) async {
    if (_busy || !_recording) return;
    _timer?.cancel();
    setState(() => _busy = true);
    try {
      if (cancel) {
        await _recorder!.cancel();
        return;
      }
      final path = await _recorder!.stop();
      if (path == null) return;
      final file = XFile(path);
      final bytes = await file.readAsBytes();
      if (!kIsWeb) await File(path).delete();
      if (!mounted) return;
      if (bytes.length > 10 * 1024 * 1024) {
        _error(context.tr.chatMediaLimit);
        return;
      }
      final mime = kIsWeb ? 'audio/webm' : 'audio/mp4';
      setState(
        () => _upload = ChatUpload(
          bytes: bytes,
          name: kIsWeb ? 'voice.webm' : 'voice.m4a',
          mime: mime,
          kind: 'audio',
        ),
      );
    } catch (_) {
      if (mounted) _error(context.tr.chatMediaError);
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _recording = false;
        });
      }
    }
  }

  Future<void> _send() async {
    final text = _text.text, upload = _upload;
    final sent = await widget.onSend(text, upload);
    if (mounted && sent) {
      if (_text.text == text) _text.clear();
      setState(() {
        if (identical(_upload, upload)) _upload = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.sending || _busy;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: .1),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_upload != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .06),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      if (_upload!.kind == 'image')
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            _upload!.bytes,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Expanded(
                          child: ChatVoicePlayer(
                            key: ObjectKey(_upload),
                            load: () async => _upload!.bytes,
                            mime: _upload!.mime,
                          ),
                        ),
                      if (_upload!.kind == 'image') ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            context.tr.chatPhoto,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      IconButton(
                        tooltip: context.tr.chatRemove,
                        onPressed: disabled
                            ? null
                            : () => setState(() => _upload = null),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
              if (_recording)
                Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.red, size: 10),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${context.tr.chatRecording}  ${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    TextButton(
                      onPressed: disabled
                          ? null
                          : () => _finishRecording(cancel: true),
                      child: Text(context.tr.chatCancel),
                    ),
                    IconButton(
                      tooltip: context.tr.chatStop,
                      onPressed: disabled ? null : _finishRecording,
                      color: AppColors.primary,
                      icon: const Icon(Icons.stop_circle_outlined),
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background(context),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).dividerColor.withValues(alpha: .12),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              tooltip: context.tr.chatPhoto,
                              onPressed: disabled ? null : _photo,
                              color: AppColors.primary,
                              icon: const Icon(Iconsax.gallery, size: 21),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _text,
                                enabled: !disabled,
                                minLines: 1,
                                maxLines: 4,
                                maxLength: 5000,
                                buildCounter:
                                    (
                                      _, {
                                      required currentLength,
                                      required isFocused,
                                      maxLength,
                                    }) => null,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: context.tr.chatMessage,
                                  hintStyle: const TextStyle(fontSize: 13),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: false,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              tooltip: context.tr.chatRecord,
                              onPressed: disabled ? null : _record,
                              color: AppColors.primary,
                              icon: const Icon(Iconsax.microphone_2, size: 21),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: IconButton.filled(
                        tooltip: context.tr.chatSend,
                        onPressed:
                            disabled ||
                                (_text.text.trim().isEmpty && _upload == null)
                            ? null
                            : _send,
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        icon: widget.sending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Iconsax.send_2, size: 22),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
