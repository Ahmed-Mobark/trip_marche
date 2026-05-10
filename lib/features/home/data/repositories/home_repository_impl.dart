import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../../../core/network/network_service/repository_helper.dart';
import '../datasources/home_remote_data_source.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl with RepositoryHelper implements HomeRepository {
  HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getHomeSections() {
    return handleEither(() => _remoteDataSource.getHomeSections());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getHomeBanners() {
    return handleEither(() => _remoteDataSource.getHomeBanners());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getHomeCategories() {
    return handleEither(() => _remoteDataSource.getHomeCategories());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getSpecialTrips({
    required int categoryId,
    int page = 1,
    int perPage = 5,
    String search = '',
  }) {
    return handleEither(
      () => _remoteDataSource.getSpecialTrips(
        categoryId: categoryId,
        page: page,
        perPage: perPage,
        search: search,
      ),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getTrendingDestinationsItems({
    int page = 1,
    int perPage = 15,
    String search = '',
  }) {
    return handleEither(
      () => _remoteDataSource.getTrendingDestinationsItems(
        page: page,
        perPage: perPage,
        search: search,
      ),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPopularTripsItems({
    int page = 1,
    int perPage = 15,
    String search = '',
  }) {
    return handleEither(
      () => _remoteDataSource.getPopularTripsItems(
        page: page,
        perPage: perPage,
        search: search,
      ),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getSponsoredTripsItems({
    int page = 1,
    int perPage = 15,
    String search = '',
  }) {
    return handleEither(
      () => _remoteDataSource.getSponsoredTripsItems(
        page: page,
        perPage: perPage,
        search: search,
      ),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDomesticTripsItems({
    int page = 1,
    int perPage = 15,
    String search = '',
  }) {
    return handleEither(
      () => _remoteDataSource.getDomesticTripsItems(
        page: page,
        perPage: perPage,
        search: search,
      ),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getInternationalTripsItems({
    int page = 1,
    int perPage = 15,
    String search = '',
  }) {
    return handleEither(
      () => _remoteDataSource.getInternationalTripsItems(
        page: page,
        perPage: perPage,
        search: search,
      ),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getRecommendedForYouItems({
    int page = 1,
    int perPage = 15,
    String search = '',
  }) {
    return handleEither(
      () => _remoteDataSource.getRecommendedForYouItems(
        page: page,
        perPage: perPage,
        search: search,
      ),
    );
  }
}
