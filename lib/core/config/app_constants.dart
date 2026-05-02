abstract class AppConstants {
  /// When true, the bottom-nav My Trips tab adds a global `destination_id` to
  /// GET `/trips`. Prefer `false` so the tab lists all trips; use
  /// [MyTripsView.catalogDestinationId] for a specific destination (e.g. Home).
  static const bool myTripsCatalogSendDestinationId = false;

  /// Sent as `destination_id` when [myTripsCatalogSendDestinationId] is true.
  static const int myTripsCatalogDestinationId = 1;
}
