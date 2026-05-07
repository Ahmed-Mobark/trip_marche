class TripsCatalogFilters {
  const TripsCatalogFilters({
    this.search,
    this.type,
    this.country,
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
  final String? country;
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

    putString('search', search);
    putString('type', type);
    putString('country', country);
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
}
