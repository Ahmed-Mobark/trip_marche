import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';

class MyTripRowUiModel extends Equatable {
  const MyTripRowUiModel({
    required this.id,
    required this.tripId,
    required this.title,
    required this.rating,
    required this.reviewCount,
    required this.locationLabel,
    required this.dateRange,
    this.imageUrl,
    this.isWishlisted = true,
    this.isFavorite = false,
    this.useDownloadPdfWhenActive = false,
  });

  final int id;
  final int tripId;
  final String title;
  final double rating;
  final int reviewCount;
  final String locationLabel;
  final String dateRange;
  final String? imageUrl;
  final bool isWishlisted;
  final bool isFavorite;

  final bool useDownloadPdfWhenActive;

  MyTripRowUiModel copyWith({
    int? id,
    int? tripId,
    String? title,
    double? rating,
    int? reviewCount,
    String? locationLabel,
    String? dateRange,
    String? imageUrl,
    bool? isWishlisted,
    bool? isFavorite,
    bool? useDownloadPdfWhenActive,
  }) {
    return MyTripRowUiModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      locationLabel: locationLabel ?? this.locationLabel,
      dateRange: dateRange ?? this.dateRange,
      imageUrl: imageUrl ?? this.imageUrl,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      isFavorite: isFavorite ?? this.isFavorite,
      useDownloadPdfWhenActive:
          useDownloadPdfWhenActive ?? this.useDownloadPdfWhenActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tripId,
        title,
        rating,
        reviewCount,
        locationLabel,
        dateRange,
        imageUrl,
        isWishlisted,
        isFavorite,
        useDownloadPdfWhenActive,
      ];
}

class MyTripsShellState extends Equatable {
  const MyTripsShellState({
    this.tab = MyTripsShellTab.active,
    this.searchQuery = '',
    this.trips = const [],
    this.favoriteStatus = const {},
    this.wishlistErrorMessage,
  });

  final MyTripsShellTab tab;
  final String searchQuery;
  final List<MyTripRowUiModel> trips;
  final Map<int, bool> favoriteStatus;
  final String? wishlistErrorMessage;

  MyTripsShellState copyWith({
    MyTripsShellTab? tab,
    String? searchQuery,
    List<MyTripRowUiModel>? trips,
    Map<int, bool>? favoriteStatus,
    String? wishlistErrorMessage,
    bool clearWishlistError = false,
  }) {
    return MyTripsShellState(
      tab: tab ?? this.tab,
      searchQuery: searchQuery ?? this.searchQuery,
      trips: trips ?? this.trips,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
      wishlistErrorMessage: clearWishlistError
          ? null
          : (wishlistErrorMessage ?? this.wishlistErrorMessage),
    );
  }

  @override
  List<Object?> get props =>
      [tab, searchQuery, trips, favoriteStatus, wishlistErrorMessage];
}
