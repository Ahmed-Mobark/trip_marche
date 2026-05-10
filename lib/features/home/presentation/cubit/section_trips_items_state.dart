import 'package:equatable/equatable.dart';

import '../../data/models/home_section_response.dart';
import '../../data/models/section_trips_items_response.dart';

enum SectionTripsItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class SectionTripsItemsState extends Equatable {
  const SectionTripsItemsState({
    this.status = SectionTripsItemsStatus.initial,
    this.trips = const [],
    this.meta,
    this.appliedSearchQuery = '',
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final SectionTripsItemsStatus status;
  final List<TripModel> trips;
  final SectionTripsItemsMeta? meta;
  final String appliedSearchQuery;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;

  int get nextPage => (meta?.currentPage ?? 0) + 1;

  SectionTripsItemsState copyWith({
    SectionTripsItemsStatus? status,
    List<TripModel>? trips,
    SectionTripsItemsMeta? meta,
    String? appliedSearchQuery,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return SectionTripsItemsState(
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
