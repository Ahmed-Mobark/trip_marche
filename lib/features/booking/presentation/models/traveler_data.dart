import 'package:flutter/widgets.dart';

/// Editable form state for a single traveler on the Contact Information
/// screen. Each traveler owns independent controllers so editing one
/// traveler never affects another.
class TravelerData {
  TravelerData({this.selectedCountry = '+20'});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedCountry;

  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
  }
}
