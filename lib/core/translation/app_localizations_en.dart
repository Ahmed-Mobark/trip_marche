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
  String get authTravelAgencyPrompt => 'Travel vendor or agency? ';

  @override
  String get authJoinAsTripPartner => 'Join as a vendor';

  @override
  String get authPartnerPortalTitle => 'Partner portal';

  @override
  String get authWebViewLoadFailed =>
      'This page could not be loaded. Check your connection and try again.';

  @override
  String get authWebViewRetry => 'Retry';

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
  String get authForgotPasswordTitle => 'Forget Your Password';

  @override
  String get authForgotPasswordDescription =>
      'Enter your email address below and we will send you a link to reset your password.';

  @override
  String get authForgotPasswordSubtitle => 'Forgot it? Let’s fix it.';

  @override
  String get authSendButton => 'Send';

  @override
  String get authSendCodeButton => 'Send Code';

  @override
  String get authVerifyTitle => 'Verify Your Number';

  @override
  String get authVerifyDescription =>
      'We have sent you an OTP code to your registered number. Please enter the code below.';

  @override
  String get authVerifyButton => 'Verify';

  @override
  String get authBack => 'Back';

  @override
  String get authResendCode => 'Resend Code';

  @override
  String get authVerifyEmailTitle => 'Verify your email';

  @override
  String get authVerifyEmailSubtitle =>
      'We send you 6- digit code to verify your number';

  @override
  String get authVerificationCodeNotReceived =>
      'Verification code not received?';

  @override
  String get authResendNow => 'Resend Now';

  @override
  String get homeAppTitle => 'TripMarche';

  @override
  String get homeSearchHint => 'Search for a trip';

  @override
  String get homeLocationText => 'Egypt, Cairo, New Cairo';

  @override
  String get homeTrendingDestinations => 'Trending Destinations';

  @override
  String get homePopularTrips => 'Popular Trips';

  @override
  String get homeSponsoredTrips => 'Sponsored Trips';

  @override
  String get homeDomesticTripsInEgypt => 'Domestic Trips In Egypt';

  @override
  String get homeInternationalTripsFromEgypt =>
      'International Trips From Egypt';

  @override
  String get homeRecommendedForYou => 'Recommended For You';

  @override
  String get homeSpecialTrips => 'Special Trips';

  @override
  String get homeTopRated => 'Top Rated';

  @override
  String get homeFromCairoAlexandria => 'From Cairo & Alexandria';

  @override
  String get homeNewInTripMarche => 'New in TripMarche';

  @override
  String get homePerPerson => 'Person';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get wishlistTitle => 'Wishlist';

  @override
  String get wishlistSearchHint => 'Search for a trip';

  @override
  String get wishlistSortBy => 'Sort By';

  @override
  String get wishlistFilters => 'Filters';

  @override
  String get wishlistNewInTripMarche => 'New in TripMarche';

  @override
  String get wishlistRecommended => 'Recommended';

  @override
  String get wishlistBestPrice => 'Best Price';

  @override
  String get wishlistEmptyTitle => 'No trips saved yet';

  @override
  String get wishlistEmptyDescription =>
      'Tap the heart icon on any trip to\nsave it to your wishlist.';

  @override
  String get wishlistFiltersTitle => 'Filters';

  @override
  String get wishlistFiltersClearAll => 'Clear all';

  @override
  String get wishlistFiltersDestination => 'Destination';

  @override
  String get wishlistFiltersSelectDestination => 'Select';

  @override
  String get wishlistFiltersPriceRange => 'Price Range';

  @override
  String get wishlistFiltersTripType => 'Trip Type';

  @override
  String get wishlistFiltersDomestic => 'Domestic';

  @override
  String get wishlistFiltersInternational => 'International';

  @override
  String get wishlistFiltersDepartureCountry => 'Departure Country';

  @override
  String get wishlistFiltersDepartureCity => 'Departure City';

  @override
  String get wishlistFiltersSelectCountry => 'Select';

  @override
  String get wishlistFiltersSelectCity => 'Select';

  @override
  String get wishlistFiltersTripMonth => 'Trip Month';

  @override
  String get wishlistFiltersSelectMonth => 'Select';

  @override
  String get wishlistFiltersActions => 'Actions';

  @override
  String get wishlistFiltersSelectAction => 'Select';

  @override
  String get wishlistFiltersTravelAgency => 'Travel Agency';

  @override
  String get wishlistFiltersAgencyNameHint => 'Travel agency name';

  @override
  String get wishlistFiltersAgencyRating => 'Travel Agency Rating';

  @override
  String get wishlistFiltersOtherCountries => 'Other Countries';

  @override
  String get wishlistFiltersOtherCities => 'Other Cities';

  @override
  String get wishlistFiltersSelectCountries => 'Select';

  @override
  String get wishlistFiltersSelectCities => 'Select';

  @override
  String get wishlistFiltersNumberOfCities => 'Number of Cities';

  @override
  String get wishlistFiltersNumberOfCountries => 'Number of Countries';

  @override
  String get wishlistFiltersDuration => 'Duration';

  @override
  String get wishlistFiltersDurationUpTo3 => 'Up to 3 Days';

  @override
  String get wishlistFiltersDurationUpTo7 => 'Up to 7 Days';

  @override
  String get wishlistFiltersDuration7Plus => '+7 Days';

  @override
  String get wishlistFiltersGroupSize => 'Group Size';

  @override
  String get wishlistFiltersGroupSizeSmall => 'Up to 10';

  @override
  String get wishlistFiltersGroupSizeUpTo20 => 'Up to 20';

  @override
  String get wishlistFiltersGroupSize20Plus => '20+';

  @override
  String get wishlistFiltersTripSeason => 'Trip Season';

  @override
  String get wishlistFiltersSeasonSpring => 'Spring';

  @override
  String get wishlistFiltersSeasonHajj => 'Hajj';

  @override
  String get wishlistFiltersSeasonNewYear => 'New Year';

  @override
  String get wishlistFiltersTripFeatures => 'Trip Features';

  @override
  String get wishlistFiltersFeatureIncludeFlight => 'Include flight';

  @override
  String get wishlistFiltersFeatureIncludeHotel => 'Include hotel';

  @override
  String get wishlistFiltersFeatureFreeMeal => 'Free meal';

  @override
  String get wishlistFiltersFeatureVisaOnArrival => 'Visa on arrival';

  @override
  String get wishlistFiltersTripRating => 'Trip Rating';

  @override
  String get wishlistFiltersDiscountCode => 'Trip applies discount code';

  @override
  String get wishlistFiltersFreeCancellation => 'Free cancellation';

  @override
  String get filterSeeResults => 'See Results';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotificationSetting => 'Notification Setting';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsCurrency => 'Currency';

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
  String get notificationSettingsIntro =>
      'Manage your notification preferences to stay updated on new trips, offers, and booking updates.';

  @override
  String get notificationSettingsBookingUpdatesTitle => 'Booking Updates';

  @override
  String get notificationSettingsBookingUpdatesSubtitle =>
      'Receive real-time updates about trip confirmations, cancellations, and changes to your bookings.';

  @override
  String get notificationSettingsToursTitle => 'Tours';

  @override
  String get notificationSettingsToursSubtitle =>
      'Get notified when new trips or tours are added that match your interests.';

  @override
  String get notificationSettingsReviewsTitle => 'Reviews';

  @override
  String get notificationSettingsReviewsSubtitle =>
      'Be alerted when someone responds to your review or when you\'re invited to review a trip you’ve taken.';

  @override
  String get notificationSettingsPromotionsSubtitle =>
      'Get access to special discounts, limited-time offers, and seasonal promotions.';

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
  String get profileAddReview => 'Add Review';

  @override
  String get profileReviewLabel => 'Review';

  @override
  String get profileProductRatingLabel => 'Product Rating';

  @override
  String get profileMyReviewsRoute => 'Cairo → Dahab';

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
  String profileTripsBooked(Object count) {
    return '$count Trips booked';
  }

  @override
  String get profileDeleteAccountTitle => 'Delete Account';

  @override
  String get profileDeleteAccountMessage =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get profileLogoutConfirmTitle => 'Log Out';

  @override
  String get profileLogoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get followingsTitle => 'My Followings';

  @override
  String followingsCountTitle(Object count) {
    return '$count Following';
  }

  @override
  String get followingsUnfollow => 'Unfollow';

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
  String get myTripsSearchHint => 'Search for a trip';

  @override
  String get myTripsCatalogTripsOf => 'Trips Of';

  @override
  String myTripsCatalogReviewCountInline(int count) {
    return '($count)';
  }

  @override
  String get myTripsCatalogSaveWishlist => 'Save to wishlist';

  @override
  String get myTripsCatalogRemoveWishlist => 'Remove from wishlist';

  @override
  String get myTripsTabActive => 'Active';

  @override
  String get myTripsTabPastNew => 'Past';

  @override
  String get myTripsTabCanceled => 'Canceled';

  @override
  String get myTripsStatusActive => 'Active';

  @override
  String get myTripsStatusPast => 'Past';

  @override
  String get myTripsStatusCanceled => 'Canceled';

  @override
  String get myTripsBookAgain => 'Book Again';

  @override
  String get myTripsFromPrefix => 'From';

  @override
  String get myTripsViewDetails => 'View Details';

  @override
  String get myTripsViewReceipt => 'View Receipt';

  @override
  String get myTripsBookingDetails => 'Booking Details';

  @override
  String get myTripsDownloadPdf => 'Download pdf';

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
  String get profileFullNameLabel => 'Full Name';

  @override
  String get profileEmailLabel => 'Email';

  @override
  String get profilePhoneNumberLabel => 'Phone Number';

  @override
  String get profilePasswordLabel => 'Password';

  @override
  String get profileCountryLabel => 'Country';

  @override
  String get profileCityLabel => 'City';

  @override
  String get profileEditAction => 'Edit';

  @override
  String get profileChangePasswordAction => 'Change Password';

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
  String get searchResultTitle => 'Search Result';

  @override
  String get searchResultSearchHint => 'Search for a trip';

  @override
  String get searchResultSortBy => 'Sort By';

  @override
  String get searchResultFilters => 'Filters';

  @override
  String get searchResultRating => '4.9';

  @override
  String get searchResultReviews => '(112)';

  @override
  String get searchResultFromCity => 'From Cairo';

  @override
  String get searchResultDateFrom => '27 Nov';

  @override
  String get searchResultDateTo => '4 Dec';

  @override
  String get searchResultLabelNew => 'New in TripMarche';

  @override
  String get searchResultLabelRecommended => 'Recommended';

  @override
  String get searchResultLabelBestPrice => 'Best Price';

  @override
  String get searchResultOldPrice => '\$1000';

  @override
  String get searchResultDiscountPrice => '\$699';

  @override
  String get searchResultPerPerson => '/Person';

  @override
  String get tripDetailsTitle => 'Dahab Trip';

  @override
  String get tripDetailsHeroCountryTag => 'Indonesia';

  @override
  String get tripDetailsHeroByCompany => 'By Travel Company';

  @override
  String get tripDetailsHeroFromLocation => 'From Cairo & Alexandria';

  @override
  String get tripDetailsHeroDateRange => '27 Nov → 4 Dec';

  @override
  String get tripDetailsHeroFromPrefix => 'From ';

  @override
  String tripDetailsHeroByCompanyLine(String company) {
    return 'By $company';
  }

  @override
  String tripDetailsGalleryMoreCount(Object count) {
    return '+$count';
  }

  @override
  String imageGalleryPosition(int current, int total) {
    return '$current of $total';
  }

  @override
  String get tripDetailsOverviewTitle => 'Trip Overview';

  @override
  String get tripDetailsOverviewBody =>
      'Experience the breathtaking beauty of the Swiss Alps on this 7-day adventure. Visit iconic destinations, enjoy scenic train rides, and immerse yourself in Swiss culture. Perfect for nature lovers and photography enthusiasts.';

  @override
  String get tripDetailsWhatsIncludedTitle => 'What\'s Included';

  @override
  String get tripDetailsIncludedFlightTickets => 'Flight Tickets';

  @override
  String get tripDetailsIncludedHotelStay => 'Hotel Stay';

  @override
  String get tripDetailsIncludedBreakfast => 'Breakfast';

  @override
  String get tripDetailsIncludedAirportTransfer => 'Airport Transfer';

  @override
  String get tripDetailsDepartureDetailsTitle => 'Departure Details';

  @override
  String get tripDetailsMeetingLocationLabel => 'Meeting Location';

  @override
  String get tripDetailsMeetingLocationValue =>
      '18 El Tesen Road, New Cairo, Egypt';

  @override
  String get tripDetailsReturnLocationLabel => 'Return Location';

  @override
  String get tripDetailsReturnLocationValue => '54 Ramses, Downtown, Egypt';

  @override
  String get tripDetailsMeetingTimeLabel => 'Meeting Time';

  @override
  String get tripDetailsMeetingTimeValue => '5:00 PM';

  @override
  String get tripDetailsReturnTimeLabel => 'Return Time';

  @override
  String get tripDetailsReturnTimeValue => '9:30 PM';

  @override
  String get tripDetailsProgramTitle => 'Trip Program';

  @override
  String get tripDetailsProgramMealsLabel => 'Meals';

  @override
  String get tripDetailsProgramDay1 => 'Day 1';

  @override
  String get tripDetailsProgramDay2 => 'Day 2';

  @override
  String get tripDetailsProgramCity1 => 'Beijing';

  @override
  String get tripDetailsProgramCity2 => 'Hangzhou';

  @override
  String get tripDetailsProgramDay1Item1 => 'Arrival at Changdu Airport';

  @override
  String get tripDetailsProgramDay1Item2 => 'Domestic flight to Beijing';

  @override
  String get tripDetailsProgramDay1Item3 => 'Hotel check-in';

  @override
  String get tripDetailsProgramDay1Item4 => 'Free tour in Wangfujing Street';

  @override
  String get tripDetailsProgramDay2Item1 => 'City tour in Hangzhou';

  @override
  String get tripDetailsProgramDay2Item2 => 'Hotel check-in and evening tour';

  @override
  String get tripDetailsProgramDay2Item3 => 'Visit West Lake by Cruise';

  @override
  String get tripDetailsProgramSeeAll => 'See All Program';

  @override
  String get tripDetailsAirlineLabel => 'Airline';

  @override
  String get tripDetailsAirlineName => 'Egyptair';

  @override
  String get tripDetailsFlightLeg1FromCity => 'Cairo';

  @override
  String get tripDetailsFlightLeg1FromTime => '5:00 AM';

  @override
  String get tripDetailsFlightLeg1ToCity => 'Paris';

  @override
  String get tripDetailsFlightLeg1ToTime => '7:20 AM';

  @override
  String get tripDetailsFlightLeg1Date => '28 April';

  @override
  String get tripDetailsFlightLeg2FromCity => 'Paris';

  @override
  String get tripDetailsFlightLeg2FromTime => '8:00 AM';

  @override
  String get tripDetailsFlightLeg2ToCity => 'Cairo';

  @override
  String get tripDetailsFlightLeg2ToTime => '5:20 AM';

  @override
  String get tripDetailsFlightLeg2Date => '4 May';

  @override
  String get tripDetailsTransportLeg1FromCity => 'Cairo';

  @override
  String get tripDetailsTransportLeg1FromTime => '8:00 AM';

  @override
  String get tripDetailsTransportLeg1ToCity => 'Paris';

  @override
  String get tripDetailsTransportLeg1ToTime => '5:20 AM';

  @override
  String get tripDetailsTransportLeg1CenterLabel => 'Bus';

  @override
  String get tripDetailsTransportLeg1Date => '29 May';

  @override
  String get tripDetailsTransportLeg2FromCity => 'Cairo';

  @override
  String get tripDetailsTransportLeg2FromTime => '8:00 AM';

  @override
  String get tripDetailsTransportLeg2ToCity => 'Paris';

  @override
  String get tripDetailsTransportLeg2ToTime => '5:20 AM';

  @override
  String get tripDetailsTransportLeg2CenterLabel => 'Boat';

  @override
  String get tripDetailsTransportLeg2Date => '29 May';

  @override
  String get tripDetailsDestinationHurghada => 'Hurghada';

  @override
  String get tripDetailsDestinationParis => 'Paris';

  @override
  String get tripDetailsStatCitiesLabel => 'Number of Cities';

  @override
  String get tripDetailsStatCitiesValue => '7 Cities';

  @override
  String tripDetailsStatCitiesCount(int count) {
    return '$count Cities';
  }

  @override
  String get tripDetailsPriceLabel => 'Price';

  @override
  String get tripDetailsPerPersonSmall => 'per person';

  @override
  String get tripDetailsBookingPriceDisplay => '1000.00';

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
  String get tripDetailsGroupSizeValue => '20-25';

  @override
  String get tripDetailsGroupSizeLabel => 'Group Size';

  @override
  String get tripDetailsTypeValue => 'International';

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
  String get tripDetailsHeroRatingLine => '4.5 (120 reviews)';

  @override
  String get tripDetailsHeroLocationShort => 'Dahab, Egypt';

  @override
  String get tripDetailsHeroDaysBadge => '7 Days';

  @override
  String get tripDetailsOut => 'Out';

  @override
  String get tripDetailsIn => 'In';

  @override
  String get tripDetailsOutSummaryLine1 => '21 May, Friday';

  @override
  String get tripDetailsOutSummaryLine2 => 'Cairo International Airport (CAI)';

  @override
  String get tripDetailsInSummaryLine1 => '27 May, Thursday';

  @override
  String get tripDetailsInSummaryLine2 => 'Dahab, South Sinai';

  @override
  String get tripDetailsTripDescriptionTitle => 'Trip description';

  @override
  String get tripDetailsAmenitiesTitle => 'Amenities';

  @override
  String get tripDetailsAmenityHotelStars => 'Hotel 4 stars';

  @override
  String get tripDetailsAmenityFoodBar => 'Food bar';

  @override
  String get tripDetailsAmenityBusTrip => 'Bus trip';

  @override
  String get tripDetailsAmenityTourGuide => 'Tour guide';

  @override
  String get tripDetailsAccommodationTitle => 'Accommodation';

  @override
  String get tripDetailsAccommodationHotelNameLabel => 'Hotel Name';

  @override
  String get tripDetailsHotelName => 'Le Meridien Dahab Resort';

  @override
  String get tripDetailsHotelRatingStars => '5.0';

  @override
  String get tripDetailsAccommodationHotelLocationLabel => 'Hotel Location';

  @override
  String get tripDetailsHotelAddress => 'Blue Hole Road, Dahab, Egypt';

  @override
  String get tripDetailsCheckInOut => 'Check-in 2:00 PM · Check-out 11:00 AM';

  @override
  String get tripDetailsViewMap => 'View map';

  @override
  String get tripDetailsSeeAllAccommodation => 'See All Accommodation';

  @override
  String get tripDetailsViewFullItinerary => 'View full itinerary';

  @override
  String get tripDetailsFlightDetailsTitle => 'Flight details';

  @override
  String get tripDetailsTransportationTitle => 'Transportation';

  @override
  String get tripDetailsFlightLegSummary => 'CAI → SSH · EgyptAir · 1h 10m';

  @override
  String get tripDetailsTrainLegSummary => 'Return · Cairo · 8h 30m';

  @override
  String get tripDetailsDestinationsTitle => 'Destinations';

  @override
  String get tripDetailsDestinationDahab => 'Dahab';

  @override
  String get tripDetailsDestinationNuweiba => 'Nuweiba';

  @override
  String get tripDetailsDestinationDetailsTitle => 'Destination Details';

  @override
  String get tripDetailsDestinationVisaLabel => 'Visa';

  @override
  String get tripDetailsDestinationVisaValue => 'Visa required';

  @override
  String get tripDetailsDestinationRequiredVaccinesLabel => 'Required Vaccines';

  @override
  String get tripDetailsDestinationRequiredVaccinesValue => '+201026329736';

  @override
  String get tripDetailsDestinationTimeLabel => 'Time';

  @override
  String get tripDetailsDestinationTimeValue => 'GMT+1';

  @override
  String get tripDetailsDestinationLanguageLabel => 'Language';

  @override
  String get tripDetailsDestinationLanguageValue => 'English';

  @override
  String get tripDetailsDestinationCurrencyLabel => 'Currency';

  @override
  String get tripDetailsDestinationCurrencyValue => 'Euro (EUR)';

  @override
  String get tripDetailsDestinationTemperatureLabel => 'Temperature';

  @override
  String get tripDetailsDestinationTemperatureValue => '25°C';

  @override
  String get tripDetailsDestinationPublicTransportationLabel =>
      'Public Transportation';

  @override
  String get tripDetailsDestinationPublicTransportationValue => 'Bus';

  @override
  String get tripDetailsDestinationTaxiAppsLabel => 'Taxi Apps';

  @override
  String get tripDetailsDestinationTaxiAppsValue => 'Uber, InDrive';

  @override
  String get tripDetailsIncludesExcludesTitle => 'Trip includes & excludes';

  @override
  String get tripDetailsExcludesTitle => 'Excludes';

  @override
  String get tripDetailsExcludeVisa => 'Visa fees';

  @override
  String get tripDetailsExcludeAlcohol => 'Alcoholic beverages';

  @override
  String get tripDetailsSeeAllPhotos => 'See all photos';

  @override
  String get tripDetailsActivityPlansTitle => 'Activity plans';

  @override
  String get tripDetailsActivitySnorkel => 'Blue Hole snorkeling';

  @override
  String get tripDetailsActivitySnorkelPrice => 'EGP 500';

  @override
  String get tripDetailsActivitySafari => 'Desert safari';

  @override
  String get tripDetailsActivitySafariPrice => 'EGP 350';

  @override
  String get tripDetailsActivityDiving => 'Intro diving session';

  @override
  String get tripDetailsActivityDivingPrice => 'EGP 800';

  @override
  String get tripDetailsAdd => 'Add';

  @override
  String get tripDetailsAdded => 'Added';

  @override
  String get tripDetailsViewAllActivities => 'View all activities';

  @override
  String get tripDetailsActivityRateTitle => 'Activity Rate';

  @override
  String get tripDetailsActivityRateLuxury => 'level of luxury';

  @override
  String get tripDetailsActivityRateShopping => 'Shopping';

  @override
  String get tripDetailsActivityRateNightOutings => 'Night outings';

  @override
  String get tripDetailsSeeAllActivities => 'See All Activities';

  @override
  String get tripDetailsVisaDetailsTitle => 'Visa Details';

  @override
  String get tripDetailsTripInstructionsTitle => 'Trip Instructions';

  @override
  String get tripDetailsSafetyProceduresTitle => 'Safety Procedures';

  @override
  String get tripDetailsCompanySectionTitle => 'Company';

  @override
  String get tripDetailsViewAll => 'View All';

  @override
  String get tripDetailsReviewCountry => 'Spain';

  @override
  String get tripDetailsCompanyRatingValue => '4.9';

  @override
  String get tripDetailsCompanyRatingCount => '112';

  @override
  String get tripDetailsPolicyCancellation => 'Cancellation policy';

  @override
  String get tripDetailsPolicyInsurance => 'Travel insurance';

  @override
  String get tripDetailsPolicyTerms => 'Terms and conditions';

  @override
  String get tripDetailsPolicyFaqs => 'Frequently asked questions';

  @override
  String get tripDetailsSeeAllReviews => 'See all';

  @override
  String get tripDetailsOrganizerTitle => 'Organizer';

  @override
  String get tripDetailsOrganizerSubtitle => 'Trusted partner on Trip Marche';

  @override
  String get tripDetailsStartingFrom => 'Starting from';

  @override
  String get tripDetailsBookingFromPrice => 'EGP 5,000';

  @override
  String get tripDetailsItineraryLoc1 => 'Beijing';

  @override
  String get tripDetailsItineraryActs1 =>
      '• Check-in at hotel\n• City orientation walk\n• Welcome dinner';

  @override
  String get tripDetailsItineraryLoc2 => 'Hangzhou';

  @override
  String get tripDetailsItineraryActs2 =>
      '• West Lake cruise\n• Tea plantation visit\n• Evening free time';

  @override
  String get tripDetailsReviewSampleName => 'Ahmed Hassan';

  @override
  String get tripDetailsReviewSampleDate => 'Dec 2025';

  @override
  String get tripDetailsReviewSampleBody =>
      'Amazing trip! Great organization and friendly guides. The snorkeling day was unforgettable.';

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

  @override
  String get authResetPasswordTitle => 'Reset Password';

  @override
  String get authResetPasswordSubtitle => 'Enter your new password below';

  @override
  String get authNewPasswordLabel => 'New Password';

  @override
  String get authNewPasswordHint => 'Enter new password';

  @override
  String get authConfirmNewPasswordLabel => 'Confirm New Password';

  @override
  String get authConfirmNewPasswordHint => 'Confirm new password';

  @override
  String get authResetPasswordButton => 'Reset Password';

  @override
  String get tripDetailsDurationUnit => 'Days';

  @override
  String get tripDetailsProgramDayPrefix => 'Day';

  @override
  String get tripDetailsTypeDomestic => 'Domestic';

  @override
  String get tripDetailsPayOnArrival => 'Pay on arrival';

  @override
  String get tripDetailsFailedToLoad => 'Could not load trip details.';

  @override
  String get tripDetailsTryAgain => 'Try again';

  @override
  String get tripDetailsNoFlights =>
      'Flight details will appear here when available.';

  @override
  String get tripDetailsNoTransport =>
      'Ground or sea transport details will appear here when available.';

  @override
  String get tripDetailsVisaAndEntryTitle => 'Visa and entry';
}
