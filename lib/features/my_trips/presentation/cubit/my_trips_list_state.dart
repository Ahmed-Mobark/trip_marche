import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

enum MyTripsListStatus { initial, loading, loadingMore, success, failure }

class MyTripsListState extends Equatable {
  const MyTripsListState({
    this.status = MyTripsListStatus.initial,
    this.trips = const [],
    this.meta,
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final MyTripsListStatus status;
  final List<WishlistTripItem> trips;
  final WishlistPaginationMeta? meta;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;
  int get nextPage => (meta?.currentPage ?? 0) + 1;

  MyTripsListState copyWith({
    MyTripsListStatus? status,
    List<WishlistTripItem>? trips,
    WishlistPaginationMeta? meta,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearErrorMessage = false,
    bool clearWishlistError = false,
  }) {
    return MyTripsListState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      meta: meta ?? this.meta,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      wishlistErrorMessage: clearWishlistError
          ? null
          : (wishlistErrorMessage ?? this.wishlistErrorMessage),
    );
  }

  @override
  List<Object?> get props =>
      [status, trips, meta, errorMessage, wishlistErrorMessage];
}
