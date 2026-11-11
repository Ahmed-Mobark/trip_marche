import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class ChatUseCases {
  ChatUseCases(this._repository);
  final ChatRepository _repository;
  Future<Either<Failure, ChatThreadPage>> threads(int page) =>
      _repository.threads(page);
  Future<Either<Failure, ChatThread>> start({int? vendorId}) =>
      _repository.start(vendorId: vendorId);
  Future<Either<Failure, ChatPage>> messages(
    int id, {
    int? beforeId,
    int? afterId,
  }) => _repository.messages(id, beforeId: beforeId, afterId: afterId);
  Future<Either<Failure, ChatMessage>> send(
    int id,
    String body,
    String clientId, {
    ChatUpload? attachment,
  }) => _repository.send(id, body, clientId, attachment: attachment);
  Future<Either<Failure, Unit>> read(int id, int lastId) =>
      _repository.read(id, lastId);
  Future<Either<Failure, Uint8List>> attachment(int id, int messageId) =>
      _repository.attachment(id, messageId);
}
