import 'activity.dart';
import 'traveler_contact.dart';

class BookingActivities {
  const BookingActivities({
    required this.traveler,
    required this.activities,
  });

  final TravelerContact traveler;
  final List<Activity> activities;
}
