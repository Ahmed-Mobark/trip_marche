import 'package:equatable/equatable.dart';

class FilterPriceMetadata extends Equatable {
  const FilterPriceMetadata({
    required this.min,
    required this.max,
    required this.currency,
  });

  final double min;
  final double max;
  final String currency;

  @override
  List<Object?> get props => [min, max, currency];
}

class FilterMetadata extends Equatable {
  const FilterMetadata({
    required this.total,
    required this.tripType,
    required this.features,
    required this.visa,
    required this.season,
    required this.duration,
    required this.groupSize,
    required this.price,
  });

  final int total;
  final Map<String, int> tripType;
  final Map<String, int> features;
  final Map<String, int> visa;
  final Map<String, int> season;
  final Map<String, int> duration;
  final Map<String, int> groupSize;
  final FilterPriceMetadata price;

  @override
  List<Object?> get props => [
        total,
        tripType,
        features,
        visa,
        season,
        duration,
        groupSize,
        price,
      ];
}
