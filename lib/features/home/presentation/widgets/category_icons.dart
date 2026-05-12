import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Slug-based fallback icon for special-trip categories.
///
/// Used by the home special-trips tab bar when the API does not yet expose an
/// icon URL for a category. We match common travel taxonomy keywords against
/// the slug (case-insensitive) and fall back to a generic globe icon.
IconData categoryIconForSlug(String slug) {
  final s = slug.toLowerCase();
  if (s.contains('honeymoon') || s.contains('couple') || s.contains('romant')) {
    return Iconsax.heart;
  }
  if (s.contains('family')) {
    return Iconsax.profile_2user;
  }
  if (s.contains('adventure') || s.contains('hike') || s.contains('trek')) {
    return Iconsax.arrow_up_3;
  }
  if (s.contains('beach') || s.contains('island') || s.contains('sea') ||
      s.contains('coast')) {
    return Iconsax.sun_1;
  }
  if (s.contains('mountain') || s.contains('ski') || s.contains('snow')) {
    return Iconsax.arrow_up_2;
  }
  if (s.contains('cultur') || s.contains('herit') || s.contains('histor')) {
    return Iconsax.book_1;
  }
  if (s.contains('religi') || s.contains('umrah') || s.contains('hajj') ||
      s.contains('pilgrim')) {
    return Iconsax.building_3;
  }
  if (s.contains('city') || s.contains('urban')) {
    return Iconsax.building;
  }
  if (s.contains('safari') || s.contains('wild') || s.contains('desert')) {
    return Iconsax.tree;
  }
  if (s.contains('luxury') || s.contains('premium') || s.contains('vip')) {
    return Iconsax.crown_1;
  }
  if (s.contains('cruise') || s.contains('yacht') || s.contains('boat')) {
    return Iconsax.ship;
  }
  if (s.contains('flight') || s.contains('air')) {
    return Iconsax.airplane;
  }
  if (s.contains('summer')) {
    return Iconsax.sun_1;
  }
  if (s.contains('winter')) {
    return Iconsax.cloud_snow;
  }
  if (s.contains('weekend') || s.contains('short') || s.contains('quick')) {
    return Iconsax.timer_1;
  }
  if (s.contains('food') || s.contains('cuisine')) {
    return Iconsax.cake;
  }
  return Iconsax.global;
}
