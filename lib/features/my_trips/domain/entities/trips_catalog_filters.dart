class TripsCatalogFilters {
  const TripsCatalogFilters({
    this.search,
    this.type,
    this.departureCountry,
    this.departureCity,
    this.destinationId,
    this.destinations,
    this.destinationCountry,
    this.categoryId,
    this.categories,
    this.airlineId,
    this.airlines,
    this.vendorId,
    this.agencyId,
    this.minVendorRating,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.duration,
    this.minDuration,
    this.maxDuration,
    this.groupSize,
    this.citiesCount,
    this.countriesCount,
    this.season,
    this.tripMonth,
    this.tripYear,
    this.visaType,
    this.includeFlight,
    this.hotelsOnly,
    this.fiveStarOnly,
    this.acceptsCoupons,
    this.freeCancellation,
    this.flag,
    this.sort,
  });

  final String? search;
  final String? type;
  final String? departureCountry;
  final String? departureCity;
  final int? destinationId;
  final List<int>? destinations;
  final String? destinationCountry;
  final int? categoryId;
  final List<int>? categories;
  final int? airlineId;
  final List<int>? airlines;
  final int? vendorId;
  final int? agencyId;
  final int? minVendorRating;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final String? duration;
  final int? minDuration;
  final int? maxDuration;
  final String? groupSize;
  final int? citiesCount;
  final int? countriesCount;
  final String? season;
  final int? tripMonth;
  final int? tripYear;
  final String? visaType;
  final int? includeFlight;
  final int? hotelsOnly;
  final int? fiveStarOnly;
  final int? acceptsCoupons;
  final int? freeCancellation;
  final String? flag;
  final String? sort;

  /// Destination search entry (typed query or picked destination id).
  factory TripsCatalogFilters.forDestinationSearch(String raw) {
    final trimmed = raw.trim();
    return TripsCatalogFilters(
      search: trimmed.isEmpty ? null : trimmed,
    );
  }

  /// Same filters with an updated search query. Whitespace clears it.
  TripsCatalogFilters withSearch(String? raw) {
    final trimmed = raw?.trim();
    final newSearch = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    return TripsCatalogFilters(
      search: newSearch,
      type: type,
      departureCountry: departureCountry,
      departureCity: departureCity,
      destinationId: destinationId,
      destinations: destinations,
      destinationCountry: destinationCountry,
      categoryId: categoryId,
      categories: categories,
      airlineId: airlineId,
      airlines: airlines,
      vendorId: vendorId,
      agencyId: agencyId,
      minVendorRating: minVendorRating,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      duration: duration,
      minDuration: minDuration,
      maxDuration: maxDuration,
      groupSize: groupSize,
      citiesCount: citiesCount,
      countriesCount: countriesCount,
      season: season,
      tripMonth: tripMonth,
      tripYear: tripYear,
      visaType: visaType,
      includeFlight: includeFlight,
      hotelsOnly: hotelsOnly,
      fiveStarOnly: fiveStarOnly,
      acceptsCoupons: acceptsCoupons,
      freeCancellation: freeCancellation,
      flag: flag,
      sort: sort,
    );
  }

  Map<String, dynamic> toRequestBody() {
    final map = <String, dynamic>{};

    void putString(String key, String? value) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        map[key] = trimmed;
      }
    }

    void putInt(String key, int? value) {
      if (value != null) {
        map[key] = value;
      }
    }

    void putDouble(String key, double? value) {
      if (value != null) {
        map[key] = value;
      }
    }

    void putIntList(String key, List<int>? values) {
      if (values != null && values.isNotEmpty) {
        map[key] = values;
      }
    }

    if (destinationId == null) {
      putString('search', search);
    }
    putString('type', type);
    putString('departure_country', departureCountry);
    putString('departure_city', departureCity);
    putInt('destination_id', destinationId);
    putIntList('destinations', destinations);
    putString('destination_country', destinationCountry);
    putInt('category_id', categoryId);
    putIntList('categories', categories);
    putInt('airline_id', airlineId);
    putIntList('airlines', airlines);
    putInt('vendor_id', vendorId);
    putInt('agency_id', agencyId);
    putInt('min_vendor_rating', minVendorRating);
    putDouble('min_price', minPrice);
    putDouble('max_price', maxPrice);
    putDouble('min_rating', minRating);
    putString('duration', duration);
    putInt('min_duration', minDuration);
    putInt('max_duration', maxDuration);
    putString('group_size', groupSize);
    putInt('cities_count', citiesCount);
    putInt('countries_count', countriesCount);
    putString('season', season);
    putInt('trip_month', tripMonth);
    putInt('trip_year', tripYear);
    putString('visa_type', visaType);
    putInt('include_flight', includeFlight);
    putInt('hotels_only', hotelsOnly);
    putInt('five_star_only', fiveStarOnly);
    putInt('accepts_coupons', acceptsCoupons);
    putInt('free_cancellation', freeCancellation);
    putString('flag', flag);
    putString('sort', sort);

    return map;
  }

  TripsCatalogFilters copyWith({
    String? search,
    String? type,
    String? departureCountry,
    String? departureCity,
    int? destinationId,
    List<int>? destinations,
    String? destinationCountry,
    int? categoryId,
    List<int>? categories,
    int? airlineId,
    List<int>? airlines,
    int? vendorId,
    int? agencyId,
    int? minVendorRating,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? duration,
    int? minDuration,
    int? maxDuration,
    String? groupSize,
    int? citiesCount,
    int? countriesCount,
    String? season,
    int? tripMonth,
    int? tripYear,
    String? visaType,
    int? includeFlight,
    int? hotelsOnly,
    int? fiveStarOnly,
    int? acceptsCoupons,
    int? freeCancellation,
    String? flag,
    String? sort,
  }) {
    return TripsCatalogFilters(
      search: search ?? this.search,
      type: type ?? this.type,
      departureCountry: departureCountry ?? this.departureCountry,
      departureCity: departureCity ?? this.departureCity,
      destinationId: destinationId ?? this.destinationId,
      destinations: destinations ?? this.destinations,
      destinationCountry: destinationCountry ?? this.destinationCountry,
      categoryId: categoryId ?? this.categoryId,
      categories: categories ?? this.categories,
      airlineId: airlineId ?? this.airlineId,
      airlines: airlines ?? this.airlines,
      vendorId: vendorId ?? this.vendorId,
      agencyId: agencyId ?? this.agencyId,
      minVendorRating: minVendorRating ?? this.minVendorRating,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      duration: duration ?? this.duration,
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      groupSize: groupSize ?? this.groupSize,
      citiesCount: citiesCount ?? this.citiesCount,
      countriesCount: countriesCount ?? this.countriesCount,
      season: season ?? this.season,
      tripMonth: tripMonth ?? this.tripMonth,
      tripYear: tripYear ?? this.tripYear,
      visaType: visaType ?? this.visaType,
      includeFlight: includeFlight ?? this.includeFlight,
      hotelsOnly: hotelsOnly ?? this.hotelsOnly,
      fiveStarOnly: fiveStarOnly ?? this.fiveStarOnly,
      acceptsCoupons: acceptsCoupons ?? this.acceptsCoupons,
      freeCancellation: freeCancellation ?? this.freeCancellation,
      flag: flag ?? this.flag,
      sort: sort ?? this.sort,
    );
  }
}
