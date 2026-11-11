import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class TripGroupSize extends Equatable {
  const TripGroupSize({required this.min, required this.max});

  final int min;
  final int max;

  @override
  List<Object?> get props => [min, max];
}

class TripMeetingInfo extends Equatable {
  const TripMeetingInfo({
    required this.location,
    this.lat,
    this.lng,
    required this.time,
  });

  final String location;
  final double? lat;
  final double? lng;
  final String time;

  @override
  List<Object?> get props => [location, lat, lng, time];
}

class TripMeetingPoint extends Equatable {
  const TripMeetingPoint({
    required this.id,
    required this.name,
    this.address,
    this.lat,
    this.lng,
    this.date,
    this.time,
  });

  final int id;
  final String name;
  final String? address;
  final double? lat;
  final double? lng;
  final String? date;
  final String? time;

  @override
  List<Object?> get props => [id, name, address, lat, lng, date, time];
}

class TripDestinationSummary extends Equatable {
  const TripDestinationSummary({
    required this.id,
    required this.name,
    required this.slug,
    required this.country,
    this.image,
    required this.trendingRank,
  });

  final int id;
  final String name;
  final String slug;
  final String country;
  final String? image;
  final int trendingRank;

  @override
  List<Object?> get props => [id, name, slug, country, image, trendingRank];
}

class TripDestinationRef extends Equatable {
  const TripDestinationRef({
    required this.id,
    required this.name,
    this.coverImage,
    this.description = '',
  });

  final int id;
  final String name;
  final String? coverImage;
  final String description;

  @override
  List<Object?> get props => [id, name, coverImage, description];
}

class TripJourneyHighlight extends Equatable {
  const TripJourneyHighlight({
    required this.name,
    required this.description,
    this.imageUrl,
  });

  final String name;
  final String description;
  final String? imageUrl;

  @override
  List<Object?> get props => [name, description, imageUrl];
}

/// Trip taxonomy tags from API [`categories`].
class TripDetailsCategory extends Equatable {
  const TripDetailsCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  final int id;
  final String name;
  final String slug;

  @override
  List<Object?> get props => [id, name, slug];
}

class TripVendor extends Equatable {
  const TripVendor({
    required this.id,
    required this.name,
    this.avatar,
    this.company,
    this.rating,
    this.reviewsCount,
    this.followersCount,
    this.isFollowing,
  });

  final int id;
  final String name;
  final String? avatar;
  final String? company;
  final double? rating;
  final int? reviewsCount;
  final int? followersCount;
  final bool? isFollowing;

  @override
  List<Object?> get props => [
    id,
    name,
    avatar,
    company,
    rating,
    reviewsCount,
    followersCount,
    isFollowing,
  ];
}

class TripInclusion extends Equatable {
  const TripInclusion({required this.label, required this.icon});

  final String label;
  final String icon;

  @override
  List<Object?> get props => [label, icon];
}

class TripDayMeals extends Equatable {
  const TripDayMeals({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  final bool breakfast;
  final bool lunch;
  final bool dinner;

  @override
  List<Object?> get props => [breakfast, lunch, dinner];
}

class TripDayItinerary extends Equatable {
  const TripDayItinerary({
    required this.dayNumber,
    required this.title,
    this.stayCity = '',
    required this.meals,
    required this.items,
  });

  final int dayNumber;
  final String title;
  final String stayCity;
  final TripDayMeals meals;
  final List<String> items;

  @override
  List<Object?> get props => [dayNumber, title, stayCity, meals, items];
}

class TripAirline extends Equatable {
  const TripAirline({
    required this.id,
    required this.name,
    required this.code,
    this.logo,
  });

  final int id;
  final String name;
  final String code;
  final String? logo;

  @override
  List<Object?> get props => [id, name, code, logo];
}

class TripFlightLeg extends Equatable {
  const TripFlightLeg({
    required this.direction,
    required this.airline,
    required this.fromCity,
    required this.toCity,
    required this.departAt,
    required this.arriveAt,
    this.travelDate,
    this.departureTime,
    this.arrivalTime,
    this.arrivalDayOffset = 0,
  });

  final String direction;
  final TripAirline airline;
  final String fromCity;
  final String toCity;
  final DateTime? departAt;
  final DateTime? arriveAt;
  final DateTime? travelDate;
  final String? departureTime, arrivalTime;
  final int arrivalDayOffset;

  @override
  List<Object?> get props => [
    direction,
    airline,
    fromCity,
    toCity,
    departAt,
    arriveAt,
    travelDate,
    departureTime,
    arrivalTime,
    arrivalDayOffset,
  ];
}

class TripTransportCompany extends Equatable {
  const TripTransportCompany({required this.id, required this.name, this.logo});

  final int id;
  final String name;
  final String? logo;

  @override
  List<Object?> get props => [id, name, logo];
}

class TripTransportLeg extends Equatable {
  const TripTransportLeg({
    required this.type,
    required this.company,
    required this.fromCity,
    required this.toCity,
    required this.departAt,
    required this.arriveAt,
    this.travelDate,
    this.departureTime,
    this.arrivalTime,
    this.arrivalDayOffset = 0,
  });

  final String type;
  final TripTransportCompany company;
  final String fromCity;
  final String toCity;
  final DateTime? departAt;
  final DateTime? arriveAt;
  final DateTime? travelDate;
  final String? departureTime, arrivalTime;
  final int arrivalDayOffset;

  @override
  List<Object?> get props => [
    type,
    company,
    fromCity,
    toCity,
    departAt,
    arriveAt,
    travelDate,
    departureTime,
    arrivalTime,
    arrivalDayOffset,
  ];
}

class TripAccommodation extends Equatable {
  const TripAccommodation({
    required this.name,
    required this.address,
    this.city = '',
    this.lat,
    this.lng,
    required this.images,
  });

  final String name;
  final String address;
  final String city;
  final double? lat;
  final double? lng;
  final List<String> images;

  @override
  List<Object?> get props => [name, address, city, lat, lng, images];
}

class TripActivityRate extends Equatable {
  const TripActivityRate({
    required this.key,
    required this.label,
    required this.value,
  });

  final String key;
  final String label;
  final int value;

  @override
  List<Object?> get props => [key, label, value];
}

class TripPriceOption extends Equatable {
  const TripPriceOption({
    required this.id,
    required this.travelerType,
    required this.label,
    required this.price,
  });
  final int id;
  final String travelerType, label;
  final double price;
  @override
  List<Object?> get props => [id, travelerType, label, price];
}

class TripDeparture extends Equatable {
  const TripDeparture({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.price,
    this.priceOptions = const [],
    required this.seatsLeft,
  });

  final int id;
  final String startDate;
  final String endDate;
  final double price;
  final List<TripPriceOption> priceOptions;
  final int seatsLeft;

  bool get isFull => seatsLeft <= 0;

  @override
  List<Object?> get props => [
    id,
    startDate,
    endDate,
    price,
    seatsLeft,
    priceOptions,
  ];
}

class TripRoomType extends Equatable {
  const TripRoomType({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    required this.capacity,
    required this.price,
  });

  final int id;
  final String key;
  final String name;
  final String description;
  final int capacity;
  final double price;

  @override
  List<Object?> get props => [id, key, name, description, capacity, price];
}

class TripDetailsActivity extends Equatable {
  const TripDetailsActivity({
    required this.id,
    required this.key,
    required this.label,
    this.icon,
    required this.price,
  });

  final int id;
  final String key;
  final String label;
  final String? icon;
  final double price;

  @override
  List<Object?> get props => [id, key, label, icon, price];
}

class TripReviewer extends Equatable {
  const TripReviewer({
    required this.name,
    this.avatar,
    required this.country,
    required this.countryCode,
  });

  final String name;
  final String? avatar;
  final String country;
  final String countryCode;

  @override
  List<Object?> get props => [name, avatar, country, countryCode];
}

class TripReview extends Equatable {
  const TripReview({
    required this.id,
    required this.reviewer,
    required this.rating,
    required this.comment,
    required this.images,
    required this.createdAt,
  });

  final int id;
  final TripReviewer reviewer;
  final double rating;
  final String comment;
  final List<String> images;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, reviewer, rating, comment, images, createdAt];
}

/// A vendor-configured, quantity-based optional booking item.
class TripOptionalExtra extends Equatable {
  const TripOptionalExtra({
    required this.id,
    required this.name,
    this.nameEn = '',
    this.nameAr = '',
    required this.unitPrice,
    required this.currency,
    this.isAvailable = true,
  });

  final int id;
  final String name;
  final String nameEn;
  final String nameAr;
  final double unitPrice;
  final String currency;
  final bool isAvailable;

  String nameForLanguage(String languageCode) {
    if (languageCode == 'ar') {
      return nameAr.isNotEmpty ? nameAr : (nameEn.isNotEmpty ? nameEn : name);
    }

    return nameEn.isNotEmpty ? nameEn : (nameAr.isNotEmpty ? nameAr : name);
  }

  @override
  List<Object?> get props => [
    id,
    name,
    nameEn,
    nameAr,
    unitPrice,
    currency,
    isAvailable,
  ];
}

class TripGeographicStop extends Equatable {
  const TripGeographicStop({
    required this.city,
    this.administrativeArea = '',
    this.country = '',
    this.region = '',
    this.continent = '',
    this.coverImage,
  });
  final String city, administrativeArea, country, region, continent;
  final String? coverImage;
  String get description => [
    city,
    administrativeArea,
    country,
    region,
    continent,
  ].where((s) => s.isNotEmpty).join(' / ');
  @override
  List<Object?> get props => [
    city,
    administrativeArea,
    country,
    region,
    continent,
    coverImage,
  ];
}

class TripDestinationInformation extends Equatable {
  const TripDestinationInformation({
    this.destination = '',
    this.country = '',
    this.city = '',
    this.visa = '',
    this.vaccinations = '',
    this.timeZone = '',
    this.currency = '',
    this.language = '',
    this.temperature = '',
    this.publicTransportation = '',
    this.taxiApps = '',
    this.notes = '',
  });
  final String destination,
      country,
      city,
      visa,
      vaccinations,
      timeZone,
      currency,
      language,
      temperature,
      publicTransportation,
      taxiApps,
      notes;
  @override
  List<Object?> get props => [
    destination,
    country,
    city,
    visa,
    vaccinations,
    timeZone,
    currency,
    language,
    temperature,
    publicTransportation,
    taxiApps,
    notes,
  ];
}

class TripDetails extends Equatable {
  const TripDetails({
    required this.id,
    required this.title,
    this.pricingMode = 'legacy',
    required this.slug,
    required this.country,
    required this.description,
    required this.overview,
    this.coverImage,
    required this.images,
    required this.fromLocation,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.groupSize,
    required this.citiesCount,
    required this.meeting,
    this.meetingPoints = const [],
    required this.returnPoint,
    required this.price,
    this.discountPrice,
    this.currency = 'EGP',
    this.depositAmount,
    this.payOnArrivalAmount,
    this.taxPercent,
    this.kidPrice,
    this.babyPrice,
    required this.rating,
    required this.reviewsCount,
    this.badge,
    required this.flags,
    this.destination,
    required this.destinations,
    this.primaryDestinationName = '',
    this.stops = const [],
    this.destinationInformation = const [],
    this.journeyHighlights = const [],
    required this.categories,
    required this.vendor,
    required this.inclusions,
    required this.days,
    required this.flights,
    required this.transports,
    required this.accommodations,
    required this.activityRates,
    required this.departures,
    required this.roomTypes,
    required this.activities,
    this.optionalExtras = const [],
    required this.reviews,
    this.visaDetails,
    this.tripInstructions,
    this.safetyProcedures,
    this.termsConditions,
    this.cancellationPolicy,
    required this.isWishlisted,
    required this.isFavorite,
  });

  final int id;
  final String pricingMode;
  bool get hasCustomPricing => pricingMode == 'options';
  bool get isSoldOut => departures.isNotEmpty && departures.every((d) => d.isFull);
  final String title;
  final String slug;
  final String country;
  final String description;
  final String overview;
  final String? coverImage;
  final List<String> images;
  final String fromLocation;
  final String startDate;
  final String endDate;
  final int durationDays;
  final TripGroupSize groupSize;
  final int citiesCount;
  final TripMeetingInfo meeting;
  final List<TripMeetingPoint> meetingPoints;
  final TripMeetingInfo returnPoint;
  final double price;
  final double? discountPrice;
  final String currency;
  final double? depositAmount;
  final double? payOnArrivalAmount;
  final double? taxPercent;
  final double? kidPrice;
  final double? babyPrice;
  final double rating;
  final int reviewsCount;
  final String? badge;
  final WishlistTripFlags flags;
  final TripDestinationSummary? destination;
  final List<TripDestinationRef> destinations;
  final String primaryDestinationName;
  final List<TripGeographicStop> stops;
  final List<TripDestinationInformation> destinationInformation;
  final List<TripJourneyHighlight> journeyHighlights;
  final List<TripDetailsCategory> categories;
  final TripVendor vendor;
  final List<TripInclusion> inclusions;
  final List<TripDayItinerary> days;
  final List<TripFlightLeg> flights;
  final List<TripTransportLeg> transports;
  final List<TripAccommodation> accommodations;
  final List<TripActivityRate> activityRates;
  final List<TripDeparture> departures;
  final List<TripRoomType> roomTypes;
  final List<TripDetailsActivity> activities;
  final List<TripOptionalExtra> optionalExtras;
  final List<TripReview> reviews;
  final String? visaDetails;
  final String? tripInstructions;
  final String? safetyProcedures;
  final String? termsConditions;
  final String? cancellationPolicy;
  final bool isWishlisted;
  final bool isFavorite;

  /// Hero + gallery: cover, then extra images (no duplicates).
  List<String> get galleryImageUrls {
    final urls = <String>[];
    void add(String? u) {
      if (u == null || u.isEmpty) {
        return;
      }
      if (!urls.contains(u)) {
        urls.add(u);
      }
    }

    add(coverImage);
    add(destination?.image);
    for (final d in destinations) {
      add(d.coverImage);
    }
    for (final u in images) {
      add(u);
    }
    return urls;
  }

  String get primaryHeroImageUrl {
    final g = galleryImageUrls;
    return g.isNotEmpty ? g.first : '';
  }

  @override
  List<Object?> get props => [
    id,
    pricingMode,
    title,
    slug,
    country,
    description,
    overview,
    coverImage,
    images,
    fromLocation,
    startDate,
    endDate,
    durationDays,
    groupSize,
    citiesCount,
    meeting,
    meetingPoints,
    returnPoint,
    price,
    discountPrice,
    currency,
    depositAmount,
    payOnArrivalAmount,
    taxPercent,
    kidPrice,
    babyPrice,
    rating,
    reviewsCount,
    badge,
    flags,
    destination,
    destinations,
    primaryDestinationName,
    stops,
    destinationInformation,
    journeyHighlights,
    categories,
    vendor,
    inclusions,
    days,
    flights,
    transports,
    accommodations,
    activityRates,
    departures,
    roomTypes,
    activities,
    optionalExtras,
    reviews,
    visaDetails,
    tripInstructions,
    safetyProcedures,
    termsConditions,
    cancellationPolicy,
    isWishlisted,
    isFavorite,
  ];
}
