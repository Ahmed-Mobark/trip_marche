import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../../domain/entities/chat.dart';
import '../../domain/usecases/chat_usecases.dart';
import 'chat_voice_player.dart';

class ChatMessageBubble extends StatefulWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.conversationId,
  });
  final ChatMessage message;
  final int conversationId;
  @override
  State<ChatMessageBubble> createState() => _ChatMessageBubbleState();
}

class _ChatMessageBubbleState extends State<ChatMessageBubble> {
  Future<Uint8List>? _image;
  Future<Uint8List> _load() async => (await sl<ChatUseCases>().attachment(
    widget.conversationId,
    widget.message.id,
  )).fold((_) => throw StateError('Attachment unavailable'), (bytes) => bytes);
  @override
  Widget build(BuildContext context) {
    final message = widget.message, mine = widget.message.isMine;
    final ink = mine ? Colors.white : Theme.of(context).colorScheme.onSurface;
    final time = message.createdAt?.toLocal();
    return Align(
      alignment: mine
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .8,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mine ? AppColors.primary : AppColors.cardBg(context),
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(18),
            topEnd: const Radius.circular(18),
            bottomStart: Radius.circular(mine ? 18 : 5),
            bottomEnd: Radius.circular(mine ? 5 : 18),
          ),
          border: mine
              ? null
              : Border.all(color: AppColors.primary.withValues(alpha: .07)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!mine) ...[
              Text(
                message.senderName,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 5),
            ],
            if (message.attachment?.kind == 'image')
              FutureBuilder<Uint8List>(
                future: _image ??= _load(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return TextButton(
                      onPressed: () => setState(() => _image = _load()),
                      child: Text(
                        context.tr.chatRetry,
                        style: TextStyle(color: ink),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return SizedBox(
                      width: 200,
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ink,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return Semantics(
                    label: context.tr.chatPhoto,
                    button: true,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => Scaffold(
                            backgroundColor: Colors.black,
                            appBar: AppBar(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            body: Center(
                              child: InteractiveViewer(
                                child: Image.memory(snapshot.data!),
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          snapshot.data!,
                          width: 230,
                          height: 190,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Text(
                            context.tr.chatMediaError,
                            style: TextStyle(color: ink),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            if (message.attachment?.kind == 'audio')
              ChatVoicePlayer(
                load: _load,
                mime: message.attachment!.mime,
                mine: mine,
              ),
            if (message.body.isNotEmpty) ...[
              if (message.attachment != null) const SizedBox(height: 8),
              SelectableText(
                message.body,
                style: TextStyle(color: ink, fontSize: 14, height: 1.5),
              ),
            ],
            if (time != null) ...[
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TimeOfDay.fromDateTime(time).format(context),
                    style: TextStyle(
                      fontSize: 10,
                      color: ink.withValues(alpha: .7),
                    ),
                  ),
                  if (mine) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.check_rounded,
                      size: 13,
                      color: ink.withValues(alpha: .8),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
