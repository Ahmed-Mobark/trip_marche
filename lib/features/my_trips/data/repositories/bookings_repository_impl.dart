import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/methods/download_file.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import 'package:trip_marche/features/my_trips/domain/repositories/bookings_repository.dart';
import 'package:path_provider/path_provider.dart';
import '../datasources/bookings_remote_data_source.dart';

class BookingsRepositoryImpl
    with RepositoryHelper
    implements BookingsRepository {
  BookingsRepositoryImpl(this._remote);

  final BookingsRemoteDataSource _remote;

  @override
  Future<Either<Failure, BookingsPage>> fetchBookings({
    required int page,
    required String status,
    String search = '',
    int perPage = 10,
  }) {
    return handleEither(() async {
      final model = await _remote.fetchBookings(
        page: page,
        status: status,
        search: search,
        perPage: perPage,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, String>> fetchBookingPdf(int bookingId) {
    return handleEither(() async {
      final bytes = await _remote.fetchBookingPdf(bookingId);

      String? localPath;

      try {
        final decoded = const Utf8Decoder().convert(bytes);
        final json = jsonDecode(decoded) as Map<String, dynamic>;
        final url = json['pdf_url'] ?? json['url'] ?? json['data'];
        if (url is String && url.isNotEmpty) {
          localPath = await _downloadToCache(bookingId, url);
        }
      } on FormatException catch (_) {
        localPath = await _saveBytesToCache(bookingId, bytes);
      } on TypeError catch (_) {
        localPath = await _saveBytesToCache(bookingId, bytes);
      }

      if (localPath == null || !await File(localPath).exists()) {
        throw const CacheFailure(message: 'Failed to save booking PDF');
      }

      return localPath;
    });
  }

  Future<String?> _downloadToCache(int bookingId, String url) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/booking_$bookingId.pdf';

    if (await File(filePath).exists()) {
      return filePath;
    }

    return DownloadFile.downloadPdfAuthenticated(url: url, filePath: filePath);
  }

  Future<String?> _saveBytesToCache(int bookingId, Uint8List bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/booking_$bookingId.pdf';

    if (await File(filePath).exists()) {
      return filePath;
    }

    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }
}
