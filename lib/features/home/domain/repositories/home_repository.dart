import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, Map<String, dynamic>>> getHomeSections();
  Future<Either<Failure, Map<String, dynamic>>> getHomeBanners();
  Future<Either<Failure, Map<String, dynamic>>> getHomeCategories();
  Future<Either<Failure, Map<String, dynamic>>> getSpecialTrips({
    required int categoryId,
    int page = 1,
    int perPage = 5,
  });
}
