import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

enum WishlistPageStatus { initial, loading, loadingMore, success, failure }

class WishlistState extends Equatable {
  const WishlistState({
    this.status = WishlistPageStatus.initial,
    this.trips = const [],
    this.meta,
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final WishlistPageStatus status;
  final List<WishlistTripItem> trips;
  final WishlistPaginationMeta? meta;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;
  int get nextPage => (meta?.currentPage ?? 0) + 1;

  WishlistState copyWith({
    WishlistPageStatus? status,
    List<WishlistTripItem>? trips,
    WishlistPaginationMeta? meta,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearErrorMessage = false,
    bool clearWishlistError = false,
  }) {
    return WishlistState(
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
