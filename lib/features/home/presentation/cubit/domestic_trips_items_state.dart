import 'package:equatable/equatable.dart';

import '../../data/models/domestic_trips_items_response.dart';
import '../../data/models/home_section_response.dart';

enum DomesticTripsItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class DomesticTripsItemsState extends Equatable {
  const DomesticTripsItemsState({
    this.status = DomesticTripsItemsStatus.initial,
    this.trips = const [],
    this.meta,
    this.appliedSearchQuery = '',
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final DomesticTripsItemsStatus status;
  final List<TripModel> trips;
  final DomesticTripsItemsMeta? meta;
  final String appliedSearchQuery;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;

  int get nextPage => (meta?.currentPage ?? 0) + 1;

  DomesticTripsItemsState copyWith({
    DomesticTripsItemsStatus? status,
    List<TripModel>? trips,
    DomesticTripsItemsMeta? meta,
    String? appliedSearchQuery,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return DomesticTripsItemsState(
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
