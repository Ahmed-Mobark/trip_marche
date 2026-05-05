import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class TripDetailsModel {
  const TripDetailsModel({required this.details});

  final TripDetails details;

  factory TripDetailsModel.fromApiResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Map<String, dynamic>) {
      throw FormatException('Trip details: missing data object');
    }
    return TripDetailsModel(details: _parseDetails(data));
  }

  TripDetails toEntity() => details;

  /// Normalizes Windows-style newlines from API for cleaner in-app text.
  static String? _normalizeMultiline(String? raw) {
    if (raw == null) {
      return null;
    }
    final t = raw.replaceAll('\r\n', '\n').replaceAll('\r', '\n').trim();
    return t.isEmpty ? null : t;
  }

  static TripDetails _parseDetails(Map<String, dynamic> json) {
    final group = json['group_size'];
    final meeting = json['meeting'];
    final ret = json['return'];
    final dest = json['destination'];
    final vendor = json['vendor'];
    final flags = json['flags'] as Map<String, dynamic>? ?? {};

    return TripDetails(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      country: json['country'] as String? ?? '',
      description: json['description'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      coverImage: json['cover_image'] as String?,
      images: _stringList(json['images']),
      fromLocation: json['from_location'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
      endDate: json['end_date'] as String? ?? '',
      durationDays: json['duration_days'] as int? ?? 0,
      groupSize: group is Map<String, dynamic>
          ? TripGroupSize(
              min: group['min'] as int? ?? 0,
              max: group['max'] as int? ?? 0,
            )
          : const TripGroupSize(min: 0, max: 0),
      citiesCount: json['cities_count'] as int? ?? 0,
      meeting: meeting is Map<String, dynamic>
          ? TripMeetingInfo(
              location: meeting['location'] as String? ?? '',
              lat: (meeting['lat'] as num?)?.toDouble(),
              lng: (meeting['lng'] as num?)?.toDouble(),
              time: meeting['time'] as String? ?? '',
            )
          : const TripMeetingInfo(location: '', time: ''),
      returnPoint: ret is Map<String, dynamic>
          ? TripMeetingInfo(
              location: ret['location'] as String? ?? '',
              lat: (ret['lat'] as num?)?.toDouble(),
              lng: (ret['lng'] as num?)?.toDouble(),
              time: ret['time'] as String? ?? '',
            )
          : const TripMeetingInfo(location: '', time: ''),
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      depositAmount: (json['deposit_amount'] as num?)?.toDouble(),
      payOnArrivalAmount: (json['pay_on_arrival_amount'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewsCount: json['reviews_count'] as int? ?? 0,
      badge: json['badge'] as String?,
      flags: WishlistTripFlags(
        popular: flags['popular'] as bool? ?? false,
        sponsored: flags['sponsored'] as bool? ?? false,
        recommended: flags['recommended'] as bool? ?? false,
        topRated: flags['top_rated'] as bool? ?? false,
        special: flags['special'] as bool? ?? false,
        international: flags['international'] as bool? ?? false,
      ),
      destination: dest is Map<String, dynamic>
          ? TripDestinationSummary(
              id: dest['id'] as int? ?? 0,
              name: dest['name'] as String? ?? '',
              slug: dest['slug'] as String? ?? '',
              country: dest['country'] as String? ?? '',
              image: dest['image'] as String?,
              trendingRank: dest['trending_rank'] as int? ?? 0,
            )
          : null,
      destinations: _parseDestinations(json['destinations']),
      categories: _parseCategories(json['categories']),
      vendor: vendor is Map<String, dynamic>
          ? TripVendor(
              id: vendor['id'] as int? ?? 0,
              name: vendor['name'] as String? ?? '',
              avatar: vendor['avatar'] as String?,
              company: vendor['company'] as String?,
            )
          : const TripVendor(id: 0, name: ''),
      inclusions: _parseInclusions(json['inclusions']),
      days: _parseDays(json['days']),
      flights: _parseFlights(json['flights']),
      transports: _parseTransports(json['transports']),
      accommodations: _parseAccommodations(json['accommodations']),
      activityRates: _parseActivityRates(json['activity_rates']),
      visaDetails: _normalizeMultiline(json['visa_details'] as String?),
      tripInstructions: _normalizeMultiline(json['trip_instructions'] as String?),
      safetyProcedures: _normalizeMultiline(json['safety_procedures'] as String?),
      termsConditions: _normalizeMultiline(json['terms_conditions'] as String?),
      cancellationPolicy: _normalizeMultiline(json['cancellation_policy'] as String?),
      isWishlisted: json['is_wishlisted'] as bool? ?? false,
    );
  }

  static List<TripDetailsCategory> _parseCategories(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(
          (e) => TripDetailsCategory(
            id: e['id'] as int? ?? 0,
            name: e['name'] as String? ?? '',
            slug: e['slug'] as String? ?? '',
          ),
        )
        .toList();
  }

  static List<String> _stringList(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw
        .map((e) => e?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
  }

  static List<TripDestinationRef> _parseDestinations(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(
          (e) => TripDestinationRef(
            id: e['id'] as int? ?? 0,
            name: e['name'] as String? ?? '',
            coverImage: e['cover_image'] as String?,
          ),
        )
        .toList();
  }

  static List<TripInclusion> _parseInclusions(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(
          (e) => TripInclusion(
            label: e['label'] as String? ?? '',
            icon: e['icon'] as String? ?? '',
          ),
        )
        .toList();
  }

  static List<TripDayItinerary> _parseDays(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw.whereType<Map<String, dynamic>>().map((e) {
      final mealsRaw = e['meals'];
      TripDayMeals meals;
      if (mealsRaw is Map<String, dynamic>) {
        meals = TripDayMeals(
          breakfast: mealsRaw['breakfast'] as bool? ?? false,
          lunch: mealsRaw['lunch'] as bool? ?? false,
          dinner: mealsRaw['dinner'] as bool? ?? false,
        );
      } else {
        meals = const TripDayMeals(
          breakfast: false,
          lunch: false,
          dinner: false,
        );
      }
      final itemsRaw = e['items'];
      final items = itemsRaw is List
          ? itemsRaw.map((x) => x?.toString() ?? '').where((s) => s.isNotEmpty).toList()
          : <String>[];
      return TripDayItinerary(
        dayNumber: e['day_number'] as int? ?? 0,
        title: e['title'] as String? ?? '',
        meals: meals,
        items: items,
      );
    }).toList();
  }

  static TripAirline _parseAirline(Map<String, dynamic>? json) {
    if (json == null) {
      return const TripAirline(id: 0, name: '', code: '');
    }
    return TripAirline(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      logo: json['logo'] as String?,
    );
  }

  static List<TripFlightLeg> _parseFlights(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw.whereType<Map<String, dynamic>>().map((e) {
      final airline = e['airline'];
      return TripFlightLeg(
        direction: e['direction'] as String? ?? '',
        airline: airline is Map<String, dynamic>
            ? _parseAirline(airline)
            : const TripAirline(id: 0, name: '', code: ''),
        fromCity: e['from_city'] as String? ?? '',
        toCity: e['to_city'] as String? ?? '',
        departAt: DateTime.tryParse(e['depart_at'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        arriveAt: DateTime.tryParse(e['arrive_at'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      );
    }).toList();
  }

  static List<TripTransportLeg> _parseTransports(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw.whereType<Map<String, dynamic>>().map((e) {
      final company = e['company'];
      return TripTransportLeg(
        type: e['type'] as String? ?? '',
        company: company is Map<String, dynamic>
            ? TripTransportCompany(
                id: company['id'] as int? ?? 0,
                name: company['name'] as String? ?? '',
                logo: company['logo'] as String?,
              )
            : const TripTransportCompany(id: 0, name: ''),
        fromCity: e['from_city'] as String? ?? '',
        toCity: e['to_city'] as String? ?? '',
        departAt: DateTime.tryParse(e['depart_at'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        arriveAt: DateTime.tryParse(e['arrive_at'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      );
    }).toList();
  }

  static List<TripAccommodation> _parseAccommodations(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw.whereType<Map<String, dynamic>>().map((e) {
      return TripAccommodation(
        name: e['name'] as String? ?? '',
        address: e['address'] as String? ?? '',
        lat: (e['lat'] as num?)?.toDouble(),
        lng: (e['lng'] as num?)?.toDouble(),
        images: _stringList(e['images']),
      );
    }).toList();
  }

  static List<TripActivityRate> _parseActivityRates(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(
          (e) => TripActivityRate(
            key: e['key'] as String? ?? '',
            label: e['label'] as String? ?? '',
            value: e['value'] as int? ?? 0,
          ),
        )
        .toList();
  }
}
