abstract class AppConstants {
  /// When true, GET `/trips` from My Trips includes `destination_id`.
  static const bool myTripsCatalogSendDestinationId = true;

  /// Sent as `destination_id` when [myTripsCatalogSendDestinationId] is true.
  static const int myTripsCatalogDestinationId = 1;
}
