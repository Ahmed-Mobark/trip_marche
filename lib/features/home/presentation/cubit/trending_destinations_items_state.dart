import 'package:equatable/equatable.dart';

import '../../data/models/home_section_response.dart';
import '../../data/models/trending_destinations_items_response.dart';

enum TrendingDestinationsItemsStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class TrendingDestinationsItemsState extends Equatable {
  const TrendingDestinationsItemsState({
    this.status = TrendingDestinationsItemsStatus.initial,
    this.destinations = const [],
    this.meta,
    this.appliedSearchQuery = '',
    this.errorMessage,
  });

  final TrendingDestinationsItemsStatus status;
  final List<DestinationModel> destinations;
  final TrendingDestinationsItemsMeta? meta;
  final String appliedSearchQuery;
  final String? errorMessage;

  bool get hasMore => meta?.hasMore ?? false;

  int get nextPage => (meta?.currentPage ?? 0) + 1;

  TrendingDestinationsItemsState copyWith({
    TrendingDestinationsItemsStatus? status,
    List<DestinationModel>? destinations,
    TrendingDestinationsItemsMeta? meta,
    String? appliedSearchQuery,
    String? errorMessage,
  }) {
    return TrendingDestinationsItemsState(
      status: status ?? this.status,
      destinations: destinations ?? this.destinations,
      meta: meta ?? this.meta,
      appliedSearchQuery: appliedSearchQuery ?? this.appliedSearchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, destinations, meta, appliedSearchQuery, errorMessage];
}
