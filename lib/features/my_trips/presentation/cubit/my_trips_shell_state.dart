import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';

class MyTripRowUiModel extends Equatable {
  const MyTripRowUiModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.reviewCount,
    required this.locationLabel,
    required this.dateRange,
    this.imageUrl,
    this.isWishlisted = true,
    this.useDownloadPdfWhenActive = false,
  });

  final int id;
  final String title;
  final double rating;
  final int reviewCount;
  final String locationLabel;
  final String dateRange;
  final String? imageUrl;
  final bool isWishlisted;

  /// Figma: on **Active**, third card shows "Download pdf" instead of "Booking Details".
  final bool useDownloadPdfWhenActive;

  MyTripRowUiModel copyWith({
    int? id,
    String? title,
    double? rating,
    int? reviewCount,
    String? locationLabel,
    String? dateRange,
    String? imageUrl,
    bool? isWishlisted,
    bool? useDownloadPdfWhenActive,
  }) {
    return MyTripRowUiModel(
      id: id ?? this.id,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      locationLabel: locationLabel ?? this.locationLabel,
      dateRange: dateRange ?? this.dateRange,
      imageUrl: imageUrl ?? this.imageUrl,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      useDownloadPdfWhenActive:
          useDownloadPdfWhenActive ?? this.useDownloadPdfWhenActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        rating,
        reviewCount,
        locationLabel,
        dateRange,
        imageUrl,
        isWishlisted,
        useDownloadPdfWhenActive,
      ];
}

class MyTripsShellState extends Equatable {
  const MyTripsShellState({
    this.tab = MyTripsShellTab.past,
    this.searchQuery = '',
    this.trips = const [],
  });

  final MyTripsShellTab tab;
  final String searchQuery;
  final List<MyTripRowUiModel> trips;

  MyTripsShellState copyWith({
    MyTripsShellTab? tab,
    String? searchQuery,
    List<MyTripRowUiModel>? trips,
  }) {
    return MyTripsShellState(
      tab: tab ?? this.tab,
      searchQuery: searchQuery ?? this.searchQuery,
      trips: trips ?? this.trips,
    );
  }

  @override
  List<Object?> get props => [tab, searchQuery, trips];
}
