import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import '../../data/models/home_section_response.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_sections_state.dart';

List<HomeSectionModel> _patchSectionsTripWishlisted(
  List<HomeSectionModel> sections,
  int tripId,
  bool isWishlisted,
) {
  return sections.map((section) {
    if (!section.trips.any((t) => t.id == tripId)) return section;
    return HomeSectionModel(
      key: section.key,
      title: section.title,
      itemType: section.itemType,
      destinations: section.destinations,
      trips: section.trips
          .map(
            (t) =>
                t.id == tripId ? t.copyWith(isWishlisted: isWishlisted) : t,
          )
          .toList(),
    );
  }).toList();
}

class HomeSectionsCubit extends Cubit<HomeSectionsState> {
  HomeSectionsCubit(this._homeRepository, this._wishlistRepository)
      : super(const HomeSectionsState());

  final HomeRepository _homeRepository;
  final TripWishlistRepository _wishlistRepository;
  final Set<int> _wishlistBusy = {};

  Future<void> loadSections() async {
    emit(state.copyWith(status: HomeSectionsStatus.loading));

    final result = await _homeRepository.getHomeSections();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeSectionsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final response = HomeSectionsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: HomeSectionsStatus.success,
            sections: response.sections,
          ),
        );
      },
    );
  }

  /// Reload sections without clearing the UI (pull-to-refresh). On failure, keeps prior data.
  Future<void> refreshSections() async {
    if (state.status != HomeSectionsStatus.success) {
      await loadSections();
      return;
    }
    final result = await _homeRepository.getHomeSections();
    result.fold(
      (_) {},
      (data) {
        final response = HomeSectionsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: HomeSectionsStatus.success,
            sections: response.sections,
          ),
        );
      },
    );
  }

  /// Sync wishlist heart on section trip cards (API + optimistic UI).
  Future<void> toggleTripWishlist(int tripId) async {
    if (tripId <= 0 ||
        _wishlistBusy.contains(tripId) ||
        state.status != HomeSectionsStatus.success) {
      return;
    }
    TripModel? trip;
    for (final s in state.sections) {
      for (final t in s.trips) {
        if (t.id == tripId) {
          trip = t;
          break;
        }
      }
      if (trip != null) {
        break;
      }
    }
    if (trip == null) {
      return;
    }

    final previous = trip.isWishlisted;
    _wishlistBusy.add(tripId);
    emit(
      state.copyWith(
        sections: _patchSectionsTripWishlisted(state.sections, tripId, !previous),
        clearWishlistError: true,
      ),
    );

    final result = await _wishlistRepository.toggleWishlist(tripId);
    _wishlistBusy.remove(tripId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            sections: _patchSectionsTripWishlisted(
              state.sections,
              tripId,
              previous,
            ),
            wishlistErrorMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            sections: _patchSectionsTripWishlisted(
              state.sections,
              tripId,
              success.isWishlisted,
            ),
          ),
        );
      },
    );
  }

  void clearWishlistError() {
    emit(state.copyWith(clearWishlistError: true));
  }

  /// Keeps section hearts in sync when the same trip is favorited elsewhere (e.g. special trips).
  void syncWishlistFromOtherList(int tripId, bool isWishlisted) {
    if (state.status != HomeSectionsStatus.success) {
      return;
    }
    if (!state.sections.any((s) => s.trips.any((t) => t.id == tripId))) {
      return;
    }
    emit(
      state.copyWith(
        sections: _patchSectionsTripWishlisted(
          state.sections,
          tripId,
          isWishlisted,
        ),
      ),
    );
  }
}
