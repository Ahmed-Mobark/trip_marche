import 'package:equatable/equatable.dart';

import '../../data/models/home_section_response.dart';
import '../../data/models/popular_trips_items_response.dart';

enum PopularTripsItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class PopularTripsItemsState extends Equatable {
  const PopularTripsItemsState({
    this.status = PopularTripsItemsStatus.initial,
    this.trips = const [],
    this.meta,
    this.appliedSearchQuery = '',
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final PopularTripsItemsStatus status;
  final List<TripModel> trips;
  final PopularTripsItemsMeta? meta;
  final String appliedSearchQuery;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;

  int get nextPage => (meta?.currentPage ?? 0) + 1;

  PopularTripsItemsState copyWith({
    PopularTripsItemsStatus? status,
    List<TripModel>? trips,
    PopularTripsItemsMeta? meta,
    String? appliedSearchQuery,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return PopularTripsItemsState(
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
