import 'package:equatable/equatable.dart';
import '../../data/models/home_section_response.dart';
import '../../data/models/special_trips_response.dart';

enum SpecialTripsStatus { initial, loading, loadingMore, success, failure }

class SpecialTripsState extends Equatable {
  const SpecialTripsState({
    this.status = SpecialTripsStatus.initial,
    this.trips = const [],
    this.meta,
    this.categoryId,
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final SpecialTripsStatus status;
  final List<TripModel> trips;
  final PaginationMeta? meta;
  final int? categoryId;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;
  int get nextPage => (meta?.currentPage ?? 0) + 1;

  SpecialTripsState copyWith({
    SpecialTripsStatus? status,
    List<TripModel>? trips,
    PaginationMeta? meta,
    int? categoryId,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return SpecialTripsState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      meta: meta ?? this.meta,
      categoryId: categoryId ?? this.categoryId,
      errorMessage: errorMessage,
      wishlistErrorMessage: clearWishlistError
          ? null
          : (wishlistErrorMessage ?? this.wishlistErrorMessage),
    );
  }

  @override
  List<Object?> get props =>
      [status, trips, meta, categoryId, errorMessage, wishlistErrorMessage];
}
