// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorFieldRequired => 'This field is required';

  @override
  String get errorInvalidName => 'Invalid name format';

  @override
  String get errorInvalidUrl => 'Invalid URL';

  @override
  String get errorInvalidPhoneNumber => 'Invalid phone number';

  @override
  String get errorInvalidEmail => 'Invalid email address';

  @override
  String get errorInvalidPassword =>
      'Password must be at least 8 characters long with uppercase, lowercase, and special characters';

  @override
  String get errorPasswordMismatch => 'Passwords do not match';

  @override
  String get errorInvalidNumber => 'Invalid number';

  @override
  String get errorInvalidIban => 'Invalid IBAN format';

  @override
  String get errorInvalidMobileNumber => 'Invalid mobile number';

  @override
  String get errorInvalidStcPayId => 'Invalid STC Pay ID';

  @override
  String get errorInvalidNationalId => 'Invalid National ID';

  @override
  String get errorInvalidPassport => 'Invalid passport number';

  @override
  String get sorryMessage => 'We are sorry';

  @override
  String get nothingFound => 'Nothing Found';

  @override
  String errorPhoneValidation(Object length, Object start) {
    return 'The phone number must start with $start and be $length digits long.';
  }

  @override
  String get errorExperienceRequired => 'You must add at least one experience.';

  @override
  String get errorIdDocumentRequired =>
      'You must upload an ID document to verify your identity.';

  @override
  String get errorPhotoRequired =>
      'You must upload a photo with a white background';

  @override
  String get updateAvailableTitle => 'Update Available';

  @override
  String get updateMandatoryMessage =>
      'A new version of the app is available. Please update to continue using the app.';

  @override
  String get updateOptionalMessage =>
      'A new version of the app is available. We recommend updating for the best experience.';

  @override
  String get updateNow => 'Update Now';

  @override
  String get skip => 'Skip';

  @override
  String get chooseImage => 'Upload Choose Image';

  @override
  String get takePicture => 'Upload Take Picture';

  @override
  String get chooseFromFiles => 'Upload Choose From Files';

  @override
  String get updatePleaseUpdateToContinue =>
      'Please update the app to continue.';

  @override
  String get updateNewVersionAvailableShort => 'A new version is available.';

  @override
  String get authLoginTitle => 'Login To Your Account';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'Enter your email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordHint => 'Enter your password';

  @override
  String get authForgotPassword => 'Forget Your Password?';

  @override
  String get authLoginButton => 'Login';

  @override
  String get authNoAccountPrompt => 'Don\'t have an account? ';

  @override
  String get authCreateOne => 'Create One';

  @override
  String get authOrLoginWith => 'Or Login with';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authContinueWithApple => 'Continue with Apple';

  @override
  String get authTravelAgencyPrompt => 'Travel Agency? ';

  @override
  String get authJoinAsTripPartner => 'Join as a trip partner';

  @override
  String get authSignUpTitle => 'Create Your Account';

  @override
  String get authSignUpSubtitle => 'Sign Up To Get Started';

  @override
  String get authFullNameLabel => 'Full Name';

  @override
  String get authFullNameHint => 'Enter your full name';

  @override
  String get authPhoneLabel => 'Phone Number';

  @override
  String get authPhoneHint => 'Enter your phone number';

  @override
  String get authConfirmPasswordLabel => 'Confirm Password';

  @override
  String get authConfirmPasswordHint => 'Confirm your password';

  @override
  String get authSignUpButton => 'Sign Up';

  @override
  String get authOrSignUpWith => 'Or Sign Up with';

  @override
  String get authSocialGoogle => 'Google';

  @override
  String get authSocialApple => 'Apple';

  @override
  String get authHaveAccountPrompt => 'Already have an account? ';

  @override
  String get authLoginAction => 'Login';

  @override
  String get authForgotPasswordTitle => 'Forget Password';

  @override
  String get authForgotPasswordDescription =>
      'Enter your email address below and we will send you a link to reset your password.';

  @override
  String get authSendButton => 'Send';

  @override
  String get authVerifyTitle => 'Verify Your Number';

  @override
  String get authVerifyDescription =>
      'We have sent you an OTP code to your registered number. Please enter the code below.';

  @override
  String get authVerifyButton => 'Verify';

  @override
  String get authResendCode => 'Resend Code';

  @override
  String get wishlistTitle => 'Wishlist';

  @override
  String get wishlistEmptyTitle => 'No trips saved yet';

  @override
  String get wishlistEmptyDescription =>
      'Tap the heart icon on any trip to\nsave it to your wishlist.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotificationSetting => 'Notification Setting';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsArabic => 'Arabic';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String settingsAppVersion(Object version) {
    return 'App Version $version';
  }

  @override
  String get notificationSettingsTitle => 'Notification Setting';

  @override
  String get notificationSettingsPush => 'Push Notifications';

  @override
  String get notificationSettingsEmail => 'Email Notifications';

  @override
  String get notificationSettingsTripUpdates => 'Trip Updates';

  @override
  String get notificationSettingsPromotions => 'Promotions';

  @override
  String get notificationSettingsPriceAlerts => 'Price Alerts';

  @override
  String get profileTitleAccount => 'Account';

  @override
  String get profileTitleSupport => 'Support';

  @override
  String get profilePersonalInfo => 'Personal Info';

  @override
  String get profilePaymentMethod => 'Payment Method';

  @override
  String get profileMyReviews => 'My Reviews';

  @override
  String get profileFollowingCompanies => 'Following Companies';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileCustomerService => 'Customer Service';

  @override
  String get profileFaqs => 'FAQs';

  @override
  String get profileTermsAndConditions => 'Terms and conditions';

  @override
  String get profileDeleteAccount => 'Delete Account';

  @override
  String get profileLogout => 'Log Out';

  @override
  String get followingsTitle => 'My Followings';

  @override
  String get followingsEmptyTitle => 'No followings yet';

  @override
  String get followingsEmptyDescription =>
      'Start following companies to see\ntheir trips here.';

  @override
  String get myTripsTitle => 'My Trips';

  @override
  String get myTripsTabUpcoming => 'Upcoming';

  @override
  String get myTripsTabPast => 'Past';

  @override
  String get myTripsEmptyTitle => 'No trips yet';

  @override
  String get myTripsEmptyDescription =>
      'Start exploring and book your\nfirst adventure!';

  @override
  String get myTripsExploreTrips => 'Explore Trips';

  @override
  String get navHome => 'Home';

  @override
  String get navTrips => 'Trips';

  @override
  String get navWishlist => 'Wishlist';

  @override
  String get navAccount => 'Account';

  @override
  String get bookingContactInfoTitle => 'Contact Info';

  @override
  String get bookingContactFullNameLabel => 'Full Name';

  @override
  String get bookingContactFullNameHint => 'Enter your full name';

  @override
  String get bookingContactPhoneLabel => 'Phone Number';

  @override
  String get bookingContactPhoneHint => '+20 123 456 7890';

  @override
  String get bookingContactEmailLabel => 'Email';

  @override
  String get bookingContactEmailHint => 'email@example.com';

  @override
  String get bookingContactEmergencyLabel => 'Emergency Contact';

  @override
  String get bookingContactEmergencyHint => 'Emergency contact number';

  @override
  String get bookingContactIdPassportLabel => 'ID/Passport Number';

  @override
  String get bookingContactIdPassportHint => 'Enter your ID or Passport number';

  @override
  String get bookingContinue => 'Continue';

  @override
  String get bookingAddNewCardTitle => 'Add New Card';

  @override
  String get bookingCardNumberLabel => 'Card Number';

  @override
  String get bookingCardNumberHint => '0000 0000 0000 0000';

  @override
  String get bookingCardholderNameLabel => 'Cardholder Name';

  @override
  String get bookingCardholderNameHint => 'John Doe';

  @override
  String get bookingExpiryDateLabel => 'Expiry Date';

  @override
  String get bookingExpiryDateHint => 'MM/YY';

  @override
  String get bookingCvvLabel => 'CVV';

  @override
  String get bookingCvvHint => '***';

  @override
  String get bookingSaveCard => 'Save Card';

  @override
  String get bookingCardholderNamePlaceholder => 'CARDHOLDER NAME';

  @override
  String get bookingPaymentMethodTitle => 'Payment Method';

  @override
  String get bookingPaymentOptionCreditCard => 'Credit Card';

  @override
  String get bookingPaymentOptionCreditCardSubtitle =>
      'Pay with Visa, Mastercard';

  @override
  String get bookingPaymentOptionPaypal => 'PayPal';

  @override
  String get bookingPaymentOptionPaypalSubtitle =>
      'Pay with your PayPal account';

  @override
  String get bookingPaymentOptionApplePay => 'Apple Pay';

  @override
  String get bookingPaymentOptionApplePaySubtitle => 'Pay with Apple Pay';

  @override
  String get bookingSavedCards => 'Saved Cards';

  @override
  String get bookingAddNewCard => 'Add New Card';

  @override
  String bookingPayNow(Object amount) {
    return 'Pay Now - $amount';
  }

  @override
  String bookingCardExpires(Object expiry) {
    return 'Expires $expiry';
  }

  @override
  String get profilePersonalInfoTitle => 'Personal Info';

  @override
  String get profileGender => 'Gender';

  @override
  String get profileGenderMale => 'Male';

  @override
  String get profileGenderFemale => 'Female';

  @override
  String get profileDateOfBirth => 'Date of Birth';

  @override
  String get profileSaveChanges => 'Save Changes';

  @override
  String get companyProfileCompanyName => 'Travel Egypt Co.';

  @override
  String companyProfileReviewsCountShort(Object count) {
    return '($count reviews)';
  }

  @override
  String get companyProfileFollowing => 'Following';

  @override
  String get companyProfileFollow => 'Follow';

  @override
  String get companyProfileStatsTrips => 'Trips';

  @override
  String get companyProfileStatsReviews => 'Reviews';

  @override
  String get companyProfileStatsFollowers => 'Followers';

  @override
  String get companyProfileAbout => 'About';

  @override
  String get companyProfileAboutDescription =>
      'Travel Egypt Co. is a leading travel company specializing in Egyptian tours and adventures. We offer unique experiences across Egypt, from the ancient pyramids to the beautiful Red Sea resorts.';

  @override
  String get companyProfileTrips => 'Trips';

  @override
  String get companyProfileReviews => 'Reviews';

  @override
  String get companyProfileSeeAll => 'See All';

  @override
  String get companyProfileTripName => 'Trip Name';

  @override
  String get companyProfileReviewAuthor => 'John Doe';

  @override
  String get companyProfileReviewDate => '2 days ago';

  @override
  String get companyProfileReviewComment =>
      'Great experience! The trip was well organized and the guide was very knowledgeable.';

  @override
  String get filterTitle => 'Filter';

  @override
  String get filterReset => 'Reset';

  @override
  String get filterDuration => 'Duration';

  @override
  String get filterTripType => 'Trip Type';

  @override
  String get filterRating => 'Rating';

  @override
  String get filterDepartureCity => 'Departure City';

  @override
  String get filterSelectCity => 'Select city';

  @override
  String get filterApply => 'Apply';

  @override
  String get destinationTitle => 'Destination';

  @override
  String get destinationSearchHint => 'Search destinations...';

  @override
  String get destinationRecentSearches => 'Recent Searches';

  @override
  String get destinationClearAll => 'Clear all';

  @override
  String get destinationPopularDestinations => 'Popular Destinations';

  @override
  String searchTripsFound(Object count) {
    return '$count trips found';
  }

  @override
  String get searchQueryExample => 'Sharm El Sheikh';

  @override
  String get tripDetailsTitle => 'Dahab Trip';

  @override
  String get tripDetailsCompanyName => 'Travel Egypt Co.';

  @override
  String get tripDetailsCompanyTagline => 'Adventure Travel Agency';

  @override
  String get tripDetailsFollow => 'Follow';

  @override
  String get tripDetailsDurationValue => '7 Days';

  @override
  String get tripDetailsDurationLabel => 'Duration';

  @override
  String get tripDetailsGroupSizeValue => '20 Person';

  @override
  String get tripDetailsGroupSizeLabel => 'Group Size';

  @override
  String get tripDetailsTypeValue => 'Mixed';

  @override
  String get tripDetailsTypeLabel => 'Type';

  @override
  String get tripDetailsPerPerson => '/Person';

  @override
  String get tripDetailsDescriptionTitle => 'Description';

  @override
  String get tripDetailsReadMore => ' Read More';

  @override
  String get tripDetailsShowLess => ' Show Less';

  @override
  String get tripDetailsDescriptionBody =>
      'Experience the magic of Dahab, a beautiful coastal city on the southeast coast of the Sinai Peninsula in Egypt. This 7-day trip includes snorkeling in the Blue Hole, desert safaris, camel rides, and visits to ancient Bedouin villages. Enjoy the stunning coral reefs, crystal-clear waters, and breathtaking mountain landscapes. Our experienced guides will ensure you have an unforgettable adventure with comfortable accommodations and delicious local cuisine.';

  @override
  String get tripDetailsItineraryTitle => 'Trip Itinerary';

  @override
  String get tripDetailsIncludesTitle => 'Trip Includes';

  @override
  String get tripDetailsIncludesHotel => 'Hotel';

  @override
  String get tripDetailsIncludesTransportation => 'Transportation';

  @override
  String get tripDetailsIncludesMeals => 'Meals';

  @override
  String get tripDetailsIncludesActivities => 'Activities';

  @override
  String get tripDetailsIncludesTourGuide => 'Tour Guide';

  @override
  String get tripDetailsImagesTitle => 'Trip Images';

  @override
  String get tripDetailsReviewsTitle => 'Reviews';

  @override
  String tripDetailsReviewsCount(Object count) {
    return '$count Reviews';
  }

  @override
  String get tripDetailsRelatedTripsTitle => 'Related Trips';

  @override
  String get tripDetailsTotalPrice => 'Total Price';

  @override
  String get tripDetailsBookNow => 'Book Now';

  @override
  String tripDetailsPricePerPersonShort(Object price) {
    return '$price/Person';
  }

  @override
  String get tripDetailsDay1Title => 'Day 1 - Arrival & Check-in';

  @override
  String get tripDetailsDay1Desc =>
      'Arrive at Dahab, transfer to hotel, welcome dinner and orientation meeting with the group.';

  @override
  String get tripDetailsDay2Title => 'Day 2 - Blue Hole Snorkeling';

  @override
  String get tripDetailsDay2Desc =>
      'Full day snorkeling at the famous Blue Hole. Lunch at a beachside restaurant. Evening free time.';

  @override
  String get tripDetailsDay3Title => 'Day 3 - Desert Safari';

  @override
  String get tripDetailsDay3Desc =>
      'Jeep safari through the Sinai desert. Visit Bedouin village. Stargazing dinner in the desert.';

  @override
  String get tripDetailsDay4Title => 'Day 4 - Free Day & Activities';

  @override
  String get tripDetailsDay4Desc =>
      'Choose from optional activities: diving, camel rides, or explore the local markets.';

  @override
  String get tripDetailsDay5Title => 'Day 5 - Mount Sinai Hike';

  @override
  String get tripDetailsDay5Desc =>
      'Early morning hike to Mount Sinai for sunrise. Visit St. Catherine\'s Monastery.';

  @override
  String get tripDetailsDay6Title => 'Day 6 - Water Sports';

  @override
  String get tripDetailsDay6Desc =>
      'Windsurfing and kitesurfing lessons. Farewell dinner at a seaside restaurant.';

  @override
  String get tripDetailsDay7Title => 'Day 7 - Departure';

  @override
  String get tripDetailsDay7Desc =>
      'Breakfast at hotel. Check-out and transfer to airport.';

  @override
  String get tripDetailsRelatedNameSharm => 'Sharm El Sheikh';

  @override
  String get tripDetailsRelatedNameHurghada => 'Hurghada Trip';

  @override
  String get tripDetailsRelatedNameLuxorAswan => 'Luxor & Aswan';

  @override
  String get bookingTripTermsTitle => 'Terms & Conditions';

  @override
  String get bookingTripTermsHeader => 'Trip Terms & Conditions';

  @override
  String bookingTripTermsLastUpdated(Object date) {
    return 'Last updated: $date';
  }

  @override
  String get bookingTripTermsSection1Title => '1. Booking & Payment';

  @override
  String get bookingTripTermsSection1Body =>
      'By booking a trip through Trip Marche, you agree to the following terms. A deposit of 30% is required at the time of booking to secure your place. The remaining balance must be paid at least 14 days before the trip departure date. Failure to pay the remaining balance by the due date may result in cancellation of your booking. All payments are processed securely through our payment partners.';

  @override
  String get bookingTripTermsSection2Title => '2. Eligibility';

  @override
  String get bookingTripTermsSection2Body =>
      'Participants must be at least 18 years of age to book independently. Travelers under 18 must be accompanied by a parent or legal guardian. Certain activities may have additional age or health requirements. It is the responsibility of the traveler to ensure they meet all eligibility criteria and have the necessary travel documents.';

  @override
  String get bookingTripTermsSection3Title => '3. Trip Modifications';

  @override
  String get bookingTripTermsSection3Body =>
      'Trip Marche reserves the right to modify the trip itinerary due to weather conditions, safety concerns, or other unforeseen circumstances. We will make every effort to provide equivalent alternatives. In the event of significant changes, travelers will be notified as soon as possible and may be offered a partial refund or credit.';

  @override
  String get bookingTripTermsSection4Title => '4. Traveler Responsibilities';

  @override
  String get bookingTripTermsSection4Body =>
      'Travelers are responsible for ensuring they have valid travel documents, appropriate travel insurance, and any required vaccinations. Travelers must follow the instructions of trip guides and respect local laws and customs. Trip Marche is not liable for any consequences resulting from a traveler\'s failure to comply with entry requirements.';

  @override
  String get bookingTripTermsSection5Title => '5. Liability';

  @override
  String get bookingTripTermsSection5Body =>
      'Trip Marche acts as an organizer and intermediary. While we take every precaution to ensure safety, we are not liable for any loss, injury, or damage arising from activities during the trip, acts of nature, or the actions of third-party service providers. Travelers participate in all activities at their own risk. We strongly recommend purchasing comprehensive travel insurance.';

  @override
  String get bookingTripTermsSection6Title => '6. Privacy';

  @override
  String get bookingTripTermsSection6Body =>
      'Personal information collected during the booking process is used solely for trip organization and communication purposes. We do not share your information with third parties except as necessary to fulfill your booking. For more details, please refer to our Privacy Policy.';

  @override
  String get bookingTripTermsSection7Title => '7. Dispute Resolution';

  @override
  String get bookingTripTermsSection7Body =>
      'Any disputes arising from these terms shall be resolved through amicable negotiation. If a resolution cannot be reached, disputes shall be submitted to the competent courts. These terms are governed by the laws of the Arab Republic of Egypt.';

  @override
  String get bookingTripInstructionsTitle => 'Trip Instructions';

  @override
  String get bookingTripInstructionsHeader => 'Before You Go';

  @override
  String get bookingTripInstructionsIntro =>
      'Please read the following instructions carefully to ensure a smooth and enjoyable trip experience. Proper preparation will help you make the most of your Dahab adventure.';

  @override
  String get bookingTripInstructionsWhatToPack => 'What to Pack';

  @override
  String get bookingTripInstructionsMeetingPointTime => 'Meeting Point & Time';

  @override
  String get bookingTripInstructionsDocumentsToBring => 'Documents to Bring';

  @override
  String get bookingTripInstructionsImportantReminders => 'Important Reminders';

  @override
  String get bookingTripSafetyTitle => 'Trip Safety';

  @override
  String get bookingTripSafetyBanner =>
      'Your safety is our top priority. Please read the following guidelines carefully.';

  @override
  String get bookingTripSafetyHeader => 'Safety Procedures';

  @override
  String get bookingTripSafetyIntro =>
      'At Trip Marche, we are committed to ensuring the safety and well-being of all our travelers. Our trips are designed with comprehensive safety measures and all our guides are trained in first aid and emergency procedures.';

  @override
  String get bookingTripSafetyWaterTitle => 'Water Activities Safety';

  @override
  String get bookingTripSafetyDesertTitle => 'Desert Safety';

  @override
  String get bookingTripSafetyHealthTitle => 'Health & Medical';

  @override
  String get bookingTripSafetyEmergencyTitle => 'Emergency Contacts';

  @override
  String get bookingTripSafetyGeneralTipsTitle => 'General Safety Tips';
}
