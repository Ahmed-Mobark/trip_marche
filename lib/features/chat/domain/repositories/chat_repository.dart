import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatThreadPage>> threads(int page);
  Future<Either<Failure, ChatThread>> start({int? vendorId});
  Future<Either<Failure, ChatPage>> messages(
    int id, {
    int? beforeId,
    int? afterId,
  });
  Future<Either<Failure, ChatMessage>> send(
    int id,
    String body,
    String clientId, {
    ChatUpload? attachment,
  });
  Future<Either<Failure, Unit>> read(int id, int lastId);
  Future<Either<Failure, Uint8List>> attachment(int id, int messageId);
}
