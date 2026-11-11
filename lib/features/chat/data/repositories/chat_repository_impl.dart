import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../../../core/network/network_service/repository_helper.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl with RepositoryHelper implements ChatRepository {
  ChatRepositoryImpl(this._remote);
  final ChatRemoteDataSource _remote;
  @override
  Future<Either<Failure, ChatThreadPage>> threads(int page) =>
      handleEither(() => _remote.threads(page));
  @override
  Future<Either<Failure, ChatThread>> start({int? vendorId}) =>
      handleEither(() => _remote.start(vendorId: vendorId));
  @override
  Future<Either<Failure, ChatPage>> messages(
    int id, {
    int? beforeId,
    int? afterId,
  }) => handleEither(
    () => _remote.messages(id, beforeId: beforeId, afterId: afterId),
  );
  @override
  Future<Either<Failure, ChatMessage>> send(
    int id,
    String body,
    String clientId, {
    ChatUpload? attachment,
  }) => handleEither(
    () => _remote.send(id, body, clientId, attachment: attachment),
  );
  @override
  Future<Either<Failure, Unit>> read(int id, int lastId) =>
      handleEither(() async {
        await _remote.read(id, lastId);
        return unit;
      });
  @override
  Future<Either<Failure, Uint8List>> attachment(int id, int messageId) =>
      handleEither(() => _remote.attachment(id, messageId));
}
