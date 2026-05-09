import 'package:equatable/equatable.dart';

import '../../data/models/home_section_response.dart';
import '../../data/models/sponsored_trips_items_response.dart';

enum SponsoredTripsItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class SponsoredTripsItemsState extends Equatable {
  const SponsoredTripsItemsState({
    this.status = SponsoredTripsItemsStatus.initial,
    this.trips = const [],
    this.meta,
    this.appliedSearchQuery = '',
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final SponsoredTripsItemsStatus status;
  final List<TripModel> trips;
  final SponsoredTripsItemsMeta? meta;
  final String appliedSearchQuery;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;

  int get nextPage => (meta?.currentPage ?? 0) + 1;

  SponsoredTripsItemsState copyWith({
    SponsoredTripsItemsStatus? status,
    List<TripModel>? trips,
    SponsoredTripsItemsMeta? meta,
    String? appliedSearchQuery,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return SponsoredTripsItemsState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      meta: meta ?? this.meta,
      appliedSearchQuery: appliedSearchQuery ?? this.appliedSearchQuery,
      errorMessage: errorMessage,
      wishlistErrorMessage: clearWishlistError
          ? null
          : (wishlistErrorMessage ?? this.wishlistErrorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        trips,
        meta,
        appliedSearchQuery,
        errorMessage,
        wishlistErrorMessage,
      ];
}
