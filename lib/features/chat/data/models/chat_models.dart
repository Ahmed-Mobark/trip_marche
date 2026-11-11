import '../../domain/entities/chat.dart';

int chatInt(Object? value) => int.tryParse('$value') ?? 0;

class ChatThreadModel extends ChatThread {
  ChatThreadModel.fromJson(Map<String, dynamic> json)
    : super(
        id: chatInt(json['id']),
        title: '${json['title'] ?? ''}',
        unreadCount: chatInt(json['unread_count']),
        kind: '${json['kind'] ?? ''}',
        lastMessage: json['last_message'] as String?,
        lastMessageKind: json['last_message_kind'] as String?,
        lastMessageAt: DateTime.tryParse('${json['last_message_at'] ?? ''}'),
        avatarUrl: json['avatar_url'] as String?,
      );
}

class ChatMessageModel extends ChatMessage {
  ChatMessageModel.fromJson(Map<String, dynamic> json)
    : super(
        id: chatInt(json['id']),
        body: '${json['body'] ?? ''}',
        isMine: json['is_mine'] == true,
        senderName: '${json['sender_name'] ?? ''}',
        createdAt: DateTime.tryParse('${json['created_at'] ?? ''}'),
        attachment: json['attachment'] is Map
            ? ChatAttachment(
                kind: '${json['attachment']['kind']}',
                mime: '${json['attachment']['mime']}',
                size: chatInt(json['attachment']['size']),
              )
            : null,
      );
}
