import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../../../core/config/app_end_points.dart';
import '../../../../core/network/network_service/api_basehelper.dart';
import '../../domain/entities/chat.dart';
import '../models/chat_models.dart';

class ChatRemoteDataSource {
  ChatRemoteDataSource(this._api);
  final ApiBaseHelper _api;
  Future<ChatThreadPage> threads(int page) async {
    final json = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.conversations,
      queryParameters: {'page': page},
    );
    final rows = (json['data'] as List)
        .map((e) => ChatThreadModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    final meta = Map<String, dynamic>.from(json['meta'] as Map);
    return ChatThreadPage(
      rows,
      chatInt(meta['current_page']) < chatInt(meta['last_page']),
    );
  }

  Future<ChatThread> start({int? vendorId}) async {
    final json = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.conversations,
      body: {if (vendorId != null) 'vendor_id': vendorId},
    );
    return ChatThreadModel.fromJson(Map<String, dynamic>.from(json['data']));
  }

  Future<ChatPage> messages(int id, {int? beforeId, int? afterId}) async {
    final json = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.conversationMessages(id),
      queryParameters: {
        if (beforeId != null) 'before_id': beforeId,
        if (afterId != null) 'after_id': afterId,
      },
    );
    final data = Map<String, dynamic>.from(json['data']);
    return ChatPage(
      (data['items'] as List)
          .map((e) => ChatMessageModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      data['has_more'] == true,
    );
  }

  Future<ChatMessage> send(
    int id,
    String body,
    String clientId, {
    ChatUpload? attachment,
  }) async {
    final json = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.conversationMessages(id),
      body: attachment == null
          ? {'body': body, 'client_message_id': clientId}
          : null,
      formData: attachment == null
          ? null
          : FormData.fromMap({
              'body': body,
              'client_message_id': clientId,
              'attachment': MultipartFile.fromBytes(
                attachment.bytes,
                filename: attachment.name,
                contentType: DioMediaType.parse(attachment.mime),
              ),
            }),
    );
    return ChatMessageModel.fromJson(Map<String, dynamic>.from(json['data']));
  }

  Future<void> read(int id, int lastId) async {
    await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.conversationRead(id),
      body: {'last_read_message_id': lastId},
    );
  }

  Future<Uint8List> attachment(int id, int messageId) async {
    final bytes = await _api.get<List<int>>(
      url: '${AppEndpoints.conversationMessages(id)}/$messageId/attachment',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(bytes);
  }
}
