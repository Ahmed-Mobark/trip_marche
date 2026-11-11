import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/extensions/localization.dart';

class ChatVoicePlayer extends StatefulWidget {
  static Future<void> pauseAll() async {
    await _ChatVoicePlayerState._active?.pause();
  }

  const ChatVoicePlayer({
    super.key,
    required this.load,
    required this.mime,
    this.mine = false,
  });
  final Future<Uint8List> Function() load;
  final String mime;
  final bool mine;
  @override
  State<ChatVoicePlayer> createState() => _ChatVoicePlayerState();
}

class _ChatVoicePlayerState extends State<ChatVoicePlayer>
    with WidgetsBindingObserver {
  static AudioPlayer? _active;
  AudioPlayer? _player;
  StreamSubscription<PlayerState>? _state;
  StreamSubscription<Duration>? _position;
  File? _file;
  bool _loading = false, _playing = false;
  Duration _duration = Duration.zero, _elapsed = Duration.zero;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) _player?.pause();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _state?.cancel();
    _position?.cancel();
    if (identical(_active, _player)) _active = null;
    _player?.dispose();
    final file = _file;
    if (file != null) unawaited(file.delete().catchError((_) => file));
    super.dispose();
  }

  String _clock(Duration value) =>
      '${value.inMinutes}:${(value.inSeconds % 60).toString().padLeft(2, '0')}';
  Future<void> _toggle() async {
    if (_loading) return;
    if (_playing) {
      await _player?.pause();
      return;
    }
    setState(() => _loading = true);
    try {
      if (_player == null) {
        final bytes = await widget.load();
        if (!mounted) return;
        final player = AudioPlayer();
        _player = player;
        _state = player.playerStateStream.listen((state) {
          if (mounted) {
            setState(
              () => _playing =
                  state.playing &&
                  state.processingState != ProcessingState.completed,
            );
          }
        });
        _position = player.positionStream.listen((position) {
          if (mounted) setState(() => _elapsed = position);
        });
        if (kIsWeb) {
          _duration =
              await player.setUrl(
                Uri.dataFromBytes(bytes, mimeType: widget.mime).toString(),
              ) ??
              Duration.zero;
        } else {
          final ext = widget.mime.contains('wav')
              ? 'wav'
              : widget.mime.contains('ogg')
              ? 'ogg'
              : widget.mime.contains('webm')
              ? 'webm'
              : widget.mime.contains('mpeg')
              ? 'mp3'
              : 'm4a';
          final directory = await getTemporaryDirectory();
          final file = File(
            '${directory.path}/chat-play-${const Uuid().v4()}.$ext',
          );
          _file = file;
          await file.writeAsBytes(bytes, flush: true);
          if (!mounted) {
            await file.delete();
            return;
          }
          _duration = await player.setFilePath(file.path) ?? Duration.zero;
        }
      }
      if (!mounted) return;
      if (_active != null && !identical(_active, _player)) {
        await _active!.pause();
      }
      _active = _player;
      if (_player!.processingState == ProcessingState.completed) {
        await _player!.seek(Duration.zero);
      }
      unawaited(
        _player!.play().catchError((Object _) {
          if (mounted) _error();
        }),
      );
    } catch (_) {
      if (mounted) _error();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _error() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr.chatMediaError)));
  }

  @override
  Widget build(BuildContext context) {
    final ink = widget.mine ? Colors.white : AppColors.primary;
    return SizedBox(
      width: 230,
      child: Row(
        children: [
          IconButton(
            onPressed: _loading ? null : _toggle,
            tooltip: _playing ? context.tr.chatPause : context.tr.chatPlay,
            style: IconButton.styleFrom(
              backgroundColor: ink.withValues(alpha: .12),
              foregroundColor: ink,
            ),
            icon: _loading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ink,
                    ),
                  )
                : Icon(
                    _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.chatVoice,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 7),
                LinearProgressIndicator(
                  value: _duration.inMilliseconds > 0
                      ? (_elapsed.inMilliseconds / _duration.inMilliseconds)
                            .clamp(0, 1)
                      : 0,
                  color: ink,
                  backgroundColor: ink.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 3,
                ),
                const SizedBox(height: 5),
                Text(
                  _clock(_elapsed > Duration.zero ? _elapsed : _duration),
                  style: TextStyle(fontSize: 11, color: ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
