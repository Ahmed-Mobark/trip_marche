import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/trending_destinations_items_response.dart';
import '../../domain/repositories/home_repository.dart';
import 'trending_destinations_items_state.dart';

class TrendingDestinationsItemsCubit extends Cubit<TrendingDestinationsItemsState> {
  TrendingDestinationsItemsCubit(this._homeRepository)
      : super(const TrendingDestinationsItemsState());

  final HomeRepository _homeRepository;
  Timer? _searchDebounce;

  static const Duration _searchDebounceDuration = Duration(milliseconds: 500);
  static const int _defaultPerPage = 15;

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  /// Debounced search — mirrors catalog search behaviour on My Trips.
  void onSearchTextChanged(String raw) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDuration, () {
      final q = raw.trim();
      if (isClosed || q == state.appliedSearchQuery) {
        return;
      }
      emit(state.copyWith(appliedSearchQuery: q));
      loadInitial();
    });
  }

  void flushSearchNow(String raw) {
    _searchDebounce?.cancel();
    final q = raw.trim();
    if (isClosed) {
      return;
    }
    if (q != state.appliedSearchQuery) {
      emit(state.copyWith(appliedSearchQuery: q));
    }
    loadInitial();
  }

  Future<void> loadInitial() async {
    emit(
      state.copyWith(
        status: TrendingDestinationsItemsStatus.loading,
        destinations: const [],
      ),
    );

    final result = await _homeRepository.getTrendingDestinationsItems(
      page: 1,
      perPage: _defaultPerPage,
      search: state.appliedSearchQuery,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TrendingDestinationsItemsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final response = TrendingDestinationsItemsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: TrendingDestinationsItemsStatus.success,
            destinations: response.destinations,
            meta: response.meta,
          ),
        );
      },
    );
  }

  /// Pull-to-refresh: keeps current list on failure.
  Future<void> refresh() async {
    if (state.status != TrendingDestinationsItemsStatus.success) {
      await loadInitial();
      return;
    }

    final perPage = state.meta?.perPage ?? _defaultPerPage;
    final result = await _homeRepository.getTrendingDestinationsItems(
      page: 1,
      perPage: perPage,
      search: state.appliedSearchQuery,
    );

    result.fold(
      (_) {},
      (data) {
        final response = TrendingDestinationsItemsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: TrendingDestinationsItemsStatus.success,
            destinations: response.destinations,
            meta: response.meta,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.status == TrendingDestinationsItemsStatus.loadingMore ||
        state.status == TrendingDestinationsItemsStatus.loading ||
        state.status != TrendingDestinationsItemsStatus.success) {
      return;
    }

    emit(state.copyWith(status: TrendingDestinationsItemsStatus.loadingMore));

    final perPage = state.meta?.perPage ?? _defaultPerPage;
    final result = await _homeRepository.getTrendingDestinationsItems(
      page: state.nextPage,
      perPage: perPage,
      search: state.appliedSearchQuery,
    );

    result.fold(
      (_) {
        emit(
          state.copyWith(status: TrendingDestinationsItemsStatus.success),
        );
      },
      (data) {
        final response = TrendingDestinationsItemsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: TrendingDestinationsItemsStatus.success,
            destinations: [...state.destinations, ...response.destinations],
            meta: response.meta,
          ),
        );
      },
    );
  }
}
