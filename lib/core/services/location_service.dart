import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  String _currentLocation = '';

  String get currentLocation => _currentLocation;

  /// Resolves a display label with **city and country only**.
  static String formatCityCountry({Placemark? place, String? raw}) {
    if (place != null) {
      final fromPlace = _fromPlacemark(place);
      if (fromPlace.isNotEmpty) {
        return fromPlace;
      }
    }
    if (raw != null && raw.trim().isNotEmpty) {
      return _fromCommaSeparated(raw.trim());
    }
    return '';
  }

  static String _fromPlacemark(Placemark place) {
    final city = _pickCity(place);
    final country = place.country?.trim() ?? '';
    return _joinCityCountry(city, country);
  }

  /// Prefer true city fields; avoid street / neighborhood in the label.
  static String _pickCity(Placemark place) {
    for (final candidate in [place.locality, place.subAdministrativeArea]) {
      final value = candidate?.trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }
    return '';
  }

  static String _fromCommaSeparated(String raw) {
    final parts = raw
        .split(RegExp(r'[,،]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '';
    }
    if (parts.length == 1) {
      return parts.first;
    }
    if (parts.length == 2) {
      // Already "City, Country" (geocoder output).
      return '${parts[0]}, ${parts[1]}';
    }
    // Legacy "Country, City, District…" fallbacks → city + country only.
    return _joinCityCountry(parts[1], parts.first);
  }

  static String _joinCityCountry(String city, String country) {
    if (city.isEmpty && country.isEmpty) {
      return '';
    }
    if (city.isEmpty) {
      return country;
    }
    if (country.isEmpty) {
      return city;
    }
    return '$city, $country';
  }

  Future<void> fetchCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final formatted = formatCityCountry(place: placemarks.first);
        if (formatted.isNotEmpty) {
          _currentLocation = formatted;
        }
      }
    } catch (_) {
      // Silently fail — header will use fallback translation text
    }
  }
}
