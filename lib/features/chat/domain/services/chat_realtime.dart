class ChatLiveUpdate {
  const ChatLiveUpdate({
    this.conversationId,
    this.messageId,
    this.reason = 'message',
    this.connected = false,
  });
  final int? conversationId, messageId;
  final String reason;
  final bool connected;
}

abstract class ChatRealtime {
  Stream<ChatLiveUpdate> get updates;
  bool get connected;
  void acquire();
  void release();
}
