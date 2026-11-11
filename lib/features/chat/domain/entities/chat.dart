import 'dart:typed_data';

class ChatThread {
  const ChatThread({
    required this.id,
    required this.title,
    required this.unreadCount,
    required this.kind,
    this.lastMessage,
    this.lastMessageKind,
    this.lastMessageAt,
    this.avatarUrl,
  });
  final int id;
  final String title;
  final int unreadCount;
  final String kind;
  final String? lastMessage, lastMessageKind, avatarUrl;
  final DateTime? lastMessageAt;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.body,
    required this.isMine,
    required this.senderName,
    required this.createdAt,
    this.attachment,
  });
  final int id;
  final String body;
  final bool isMine;
  final String senderName;
  final DateTime? createdAt;
  final ChatAttachment? attachment;
}

class ChatPage {
  const ChatPage(this.items, this.hasMore);
  final List<ChatMessage> items;
  final bool hasMore;
}

class ChatThreadPage {
  const ChatThreadPage(this.items, this.hasMore);
  final List<ChatThread> items;
  final bool hasMore;
}

class ChatAttachment {
  const ChatAttachment({
    required this.kind,
    required this.mime,
    required this.size,
  });
  final String kind, mime;
  final int size;
}

class ChatUpload {
  const ChatUpload({
    required this.bytes,
    required this.name,
    required this.mime,
    required this.kind,
  });
  final Uint8List bytes;
  final String name, mime, kind;
}
