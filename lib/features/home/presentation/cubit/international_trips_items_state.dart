import 'package:equatable/equatable.dart';

import '../../data/models/home_section_response.dart';
import '../../data/models/international_trips_items_response.dart';

enum InternationalTripsItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class InternationalTripsItemsState extends Equatable {
  const InternationalTripsItemsState({
    this.status = InternationalTripsItemsStatus.initial,
    this.trips = const [],
    this.meta,
    this.appliedSearchQuery = '',
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final InternationalTripsItemsStatus status;
  final List<TripModel> trips;
  final InternationalTripsItemsMeta? meta;
  final String appliedSearchQuery;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;

  int get nextPage => (meta?.currentPage ?? 0) + 1;

  InternationalTripsItemsState copyWith({
    InternationalTripsItemsStatus? status,
    List<TripModel>? trips,
    InternationalTripsItemsMeta? meta,
    String? appliedSearchQuery,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return InternationalTripsItemsState(
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
