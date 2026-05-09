import 'package:equatable/equatable.dart';

import '../../data/models/home_section_response.dart';
import '../../data/models/recommended_for_you_items_response.dart';

enum RecommendedForYouItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class RecommendedForYouItemsState extends Equatable {
  const RecommendedForYouItemsState({
    this.status = RecommendedForYouItemsStatus.initial,
    this.trips = const [],
    this.meta,
    this.appliedSearchQuery = '',
    this.errorMessage,
    this.wishlistErrorMessage,
  });

  final RecommendedForYouItemsStatus status;
  final List<TripModel> trips;
  final RecommendedForYouItemsMeta? meta;
  final String appliedSearchQuery;
  final String? errorMessage;
  final String? wishlistErrorMessage;

  bool get hasMore => meta?.hasMore ?? false;

  int get nextPage => (meta?.currentPage ?? 0) + 1;

  RecommendedForYouItemsState copyWith({
    RecommendedForYouItemsStatus? status,
    List<TripModel>? trips,
    RecommendedForYouItemsMeta? meta,
    String? appliedSearchQuery,
    String? errorMessage,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return RecommendedForYouItemsState(
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
