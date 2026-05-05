import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

/// API wrapper: `{ "success", "message", "data": { ...trip } }`.
/// See [TripDetailsModel.fromApiResponse].
class TripDetailsApiEnvelope {
  const TripDetailsApiEnvelope({
    required this.success,
    required this.message,
    required this.model,
  });

  final bool success;
  final String message;
  final TripDetailsModel model;

  factory TripDetailsApiEnvelope.fromJson(Map<String, dynamic> json) {
    return TripDetailsApiEnvelope(
      success: _JsonParse.asBool(json['success']),
      message: _JsonParse.asString(json['message']),
      model: TripDetailsModel.fromApiResponse(json),
    );
  }
}

class TripDetailsModel {
  const TripDetailsModel({required this.details});

  final TripDetails details;

  factory TripDetailsModel.fromApiResponse(Map<String, dynamic> json) {
    final data = _JsonParse.unwrapTripData(json);
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
    final flags = json['flags'];

    return TripDetails(
      id: _JsonParse.asInt(json['id']),
      title: _JsonParse.asString(json['title']),
      slug: _JsonParse.asString(json['slug']),
      country: _JsonParse.asString(json['country']),
      description: _JsonParse.asString(json['description']),
      overview: _JsonParse.asString(json['overview']),
      coverImage: _JsonParse.asNullableString(json['cover_image']),
      images: _stringList(json['images']),
      fromLocation: _JsonParse.asString(json['from_location']),
      startDate: _JsonParse.asString(json['start_date']),
      endDate: _JsonParse.asString(json['end_date']),
      durationDays: _JsonParse.asInt(json['duration_days']),
      groupSize: group is Map<String, dynamic>
          ? TripGroupSize(
              min: _JsonParse.asInt(group['min']),
              max: _JsonParse.asInt(group['max']),
            )
          : const TripGroupSize(min: 0, max: 0),
      citiesCount: _JsonParse.asInt(json['cities_count']),
      meeting: meeting is Map<String, dynamic>
          ? TripMeetingInfo(
              location: _JsonParse.asString(meeting['location']),
              lat: _JsonParse.asNullableDouble(meeting['lat']),
              lng: _JsonParse.asNullableDouble(meeting['lng']),
              time: _JsonParse.asString(meeting['time']),
            )
          : const TripMeetingInfo(location: '', time: ''),
      returnPoint: ret is Map<String, dynamic>
          ? TripMeetingInfo(
              location: _JsonParse.asString(ret['location']),
              lat: _JsonParse.asNullableDouble(ret['lat']),
              lng: _JsonParse.asNullableDouble(ret['lng']),
              time: _JsonParse.asString(ret['time']),
            )
          : const TripMeetingInfo(location: '', time: ''),
      price: _JsonParse.asDouble(json['price']),
      discountPrice: _JsonParse.asNullableDouble(json['discount_price']),
      depositAmount: _JsonParse.asNullableDouble(json['deposit_amount']),
      payOnArrivalAmount:
          _JsonParse.asNullableDouble(json['pay_on_arrival_amount']),
      rating: _JsonParse.asDouble(json['rating']),
      reviewsCount: _JsonParse.asInt(json['reviews_count']),
      badge: _JsonParse.asNullableString(json['badge']),
      flags: WishlistTripFlags(
        popular: _JsonParse.asBool(flags is Map ? flags['popular'] : null),
        sponsored:
            _JsonParse.asBool(flags is Map ? flags['sponsored'] : null),
        recommended:
            _JsonParse.asBool(flags is Map ? flags['recommended'] : null),
        topRated: _JsonParse.asBool(flags is Map ? flags['top_rated'] : null),
        special: _JsonParse.asBool(flags is Map ? flags['special'] : null),
        international:
            _JsonParse.asBool(flags is Map ? flags['international'] : null),
      ),
      destination: dest is Map<String, dynamic>
          ? TripDestinationSummary(
              id: _JsonParse.asInt(dest['id']),
              name: _JsonParse.asString(dest['name']),
              slug: _JsonParse.asString(dest['slug']),
              country: _JsonParse.asString(dest['country']),
              image: _JsonParse.asNullableString(dest['image']),
              trendingRank: _JsonParse.asInt(dest['trending_rank']),
            )
          : null,
      destinations: _parseDestinations(json['destinations']),
      categories: _parseCategories(json['categories']),
      vendor: vendor is Map<String, dynamic>
          ? TripVendor(
              id: _JsonParse.asInt(vendor['id']),
              name: _JsonParse.asString(vendor['name']),
              avatar: _JsonParse.asNullableString(vendor['avatar']),
              company: _JsonParse.asNullableString(vendor['company']),
            )
          : const TripVendor(id: 0, name: ''),
      inclusions: _parseInclusions(json['inclusions']),
      days: _parseDays(json['days']),
      flights: _parseFlights(json['flights']),
      transports: _parseTransports(json['transports']),
      accommodations: _parseAccommodations(json['accommodations']),
      activityRates: _parseActivityRates(json['activity_rates']),
      visaDetails: _normalizeMultiline(
        _JsonParse.asNullableString(json['visa_details']),
      ),
      tripInstructions: _normalizeMultiline(
        _JsonParse.asNullableString(json['trip_instructions']),
      ),
      safetyProcedures: _normalizeMultiline(
        _JsonParse.asNullableString(json['safety_procedures']),
      ),
      termsConditions: _normalizeMultiline(
        _JsonParse.asNullableString(json['terms_conditions']),
      ),
      cancellationPolicy: _normalizeMultiline(
        _JsonParse.asNullableString(json['cancellation_policy']),
      ),
      isWishlisted: _JsonParse.asBool(json['is_wishlisted']),
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
            id: _JsonParse.asInt(e['id']),
            name: _JsonParse.asString(e['name']),
            slug: _JsonParse.asString(e['slug']),
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
            id: _JsonParse.asInt(e['id']),
            name: _JsonParse.asString(e['name']),
            coverImage: _JsonParse.asNullableString(e['cover_image']),
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
            label: _JsonParse.asString(e['label']),
            icon: _JsonParse.asString(e['icon']),
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
          breakfast: _JsonParse.asBool(mealsRaw['breakfast']),
          lunch: _JsonParse.asBool(mealsRaw['lunch']),
          dinner: _JsonParse.asBool(mealsRaw['dinner']),
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
          ? itemsRaw
              .map((x) => x?.toString() ?? '')
              .where((s) => s.isNotEmpty)
              .toList()
          : <String>[];
      return TripDayItinerary(
        dayNumber: _JsonParse.asInt(e['day_number']),
        title: _JsonParse.asString(e['title']),
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
      id: _JsonParse.asInt(json['id']),
      name: _JsonParse.asString(json['name']),
      code: _JsonParse.asString(json['code']),
      logo: _JsonParse.asNullableString(json['logo']),
    );
  }

  static List<TripFlightLeg> _parseFlights(dynamic raw) {
    if (raw is! List) {
      return [];
    }
    return raw.whereType<Map<String, dynamic>>().map((e) {
      final airline = e['airline'];
      return TripFlightLeg(
        direction: _JsonParse.asString(e['direction']),
        airline: airline is Map<String, dynamic>
            ? _parseAirline(airline)
            : const TripAirline(id: 0, name: '', code: ''),
        fromCity: _JsonParse.asString(e['from_city']),
        toCity: _JsonParse.asString(e['to_city']),
        departAt: DateTime.tryParse(_JsonParse.asString(e['depart_at'])) ??
            DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        arriveAt: DateTime.tryParse(_JsonParse.asString(e['arrive_at'])) ??
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
        type: _JsonParse.asString(e['type']),
        company: company is Map<String, dynamic>
            ? TripTransportCompany(
                id: _JsonParse.asInt(company['id']),
                name: _JsonParse.asString(company['name']),
                logo: _JsonParse.asNullableString(company['logo']),
              )
            : const TripTransportCompany(id: 0, name: ''),
        fromCity: _JsonParse.asString(e['from_city']),
        toCity: _JsonParse.asString(e['to_city']),
        departAt: DateTime.tryParse(_JsonParse.asString(e['depart_at'])) ??
            DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        arriveAt: DateTime.tryParse(_JsonParse.asString(e['arrive_at'])) ??
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
        name: _JsonParse.asString(e['name']),
        address: _JsonParse.asString(e['address']),
        lat: _JsonParse.asNullableDouble(e['lat']),
        lng: _JsonParse.asNullableDouble(e['lng']),
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
            key: _JsonParse.asString(e['key']),
            label: _JsonParse.asString(e['label']),
            value: _JsonParse.asInt(e['value']),
          ),
        )
        .toList();
  }
}

/// Loose JSON helpers so API int/string/double variants still map cleanly.
abstract final class _JsonParse {
  static Map<String, dynamic> unwrapTripData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (json.containsKey('id') &&
        (json.containsKey('title') || json.containsKey('slug'))) {
      return json;
    }
    throw const FormatException('Trip details: missing data object');
  }

  static int asInt(dynamic v, [int fallback = 0]) {
    if (v == null) {
      return fallback;
    }
    if (v is int) {
      return v;
    }
    if (v is double) {
      return v.round();
    }
    if (v is String) {
      return int.tryParse(v) ?? fallback;
    }
    return fallback;
  }

  static double asDouble(dynamic v, [double fallback = 0]) {
    if (v == null) {
      return fallback;
    }
    if (v is num) {
      return v.toDouble();
    }
    if (v is String) {
      return double.tryParse(v) ?? fallback;
    }
    return fallback;
  }

  static double? asNullableDouble(dynamic v) {
    if (v == null) {
      return null;
    }
    if (v is num) {
      return v.toDouble();
    }
    if (v is String) {
      return double.tryParse(v);
    }
    return null;
  }

  static bool asBool(dynamic v, [bool fallback = false]) {
    if (v is bool) {
      return v;
    }
    if (v is num) {
      return v != 0;
    }
    if (v is String) {
      final s = v.toLowerCase();
      return s == '1' || s == 'true' || s == 'yes';
    }
    return fallback;
  }

  static String asString(dynamic v, [String fallback = '']) {
    if (v == null) {
      return fallback;
    }
    return v.toString();
  }

  static String? asNullableString(dynamic v) {
    if (v == null) {
      return null;
    }
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }
}
