import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translation/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
  ];

  /// No description provided for @errorFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorFieldRequired;

  /// No description provided for @errorInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Invalid name format'**
  String get errorInvalidName;

  /// No description provided for @errorInvalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get errorInvalidUrl;

  /// No description provided for @errorInvalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get errorInvalidPhoneNumber;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get errorInvalidEmail;

  /// No description provided for @errorInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long with uppercase, lowercase, and special characters'**
  String get errorInvalidPassword;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordMismatch;

  /// No description provided for @errorInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get errorInvalidNumber;

  /// No description provided for @errorInvalidIban.
  ///
  /// In en, this message translates to:
  /// **'Invalid IBAN format'**
  String get errorInvalidIban;

  /// No description provided for @errorInvalidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number'**
  String get errorInvalidMobileNumber;

  /// No description provided for @errorInvalidStcPayId.
  ///
  /// In en, this message translates to:
  /// **'Invalid STC Pay ID'**
  String get errorInvalidStcPayId;

  /// No description provided for @errorInvalidNationalId.
  ///
  /// In en, this message translates to:
  /// **'Invalid National ID'**
  String get errorInvalidNationalId;

  /// No description provided for @errorInvalidPassport.
  ///
  /// In en, this message translates to:
  /// **'Invalid passport number'**
  String get errorInvalidPassport;

  /// No description provided for @sorryMessage.
  ///
  /// In en, this message translates to:
  /// **'We are sorry'**
  String get sorryMessage;

  /// No description provided for @nothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing Found'**
  String get nothingFound;

  /// No description provided for @errorPhoneValidation.
  ///
  /// In en, this message translates to:
  /// **'The phone number must start with {start} and be {length} digits long.'**
  String errorPhoneValidation(Object length, Object start);

  /// No description provided for @errorExperienceRequired.
  ///
  /// In en, this message translates to:
  /// **'You must add at least one experience.'**
  String get errorExperienceRequired;

  /// No description provided for @errorIdDocumentRequired.
  ///
  /// In en, this message translates to:
  /// **'You must upload an ID document to verify your identity.'**
  String get errorIdDocumentRequired;

  /// No description provided for @errorPhotoRequired.
  ///
  /// In en, this message translates to:
  /// **'You must upload a photo with a white background'**
  String get errorPhotoRequired;

  /// No description provided for @updateAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get updateAvailableTitle;

  /// No description provided for @updateMandatoryMessage.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available. Please update to continue using the app.'**
  String get updateMandatoryMessage;

  /// No description provided for @updateOptionalMessage.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available. We recommend updating for the best experience.'**
  String get updateOptionalMessage;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get updateNow;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Choose Image'**
  String get chooseImage;

  /// No description provided for @takePicture.
  ///
  /// In en, this message translates to:
  /// **'Upload Take Picture'**
  String get takePicture;

  /// No description provided for @chooseFromFiles.
  ///
  /// In en, this message translates to:
  /// **'Upload Choose From Files'**
  String get chooseFromFiles;

  /// No description provided for @updatePleaseUpdateToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please update the app to continue.'**
  String get updatePleaseUpdateToContinue;

  /// No description provided for @updateNewVersionAvailableShort.
  ///
  /// In en, this message translates to:
  /// **'A new version is available.'**
  String get updateNewVersionAvailableShort;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login To Your Account'**
  String get authLoginTitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get authEmailHint;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authPasswordHint;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Your Password?'**
  String get authForgotPassword;

  /// No description provided for @authLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginButton;

  /// No description provided for @authNoAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get authNoAccountPrompt;

  /// No description provided for @authCreateOne.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get authCreateOne;

  /// No description provided for @authOrLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or Login with'**
  String get authOrLoginWith;

  /// No description provided for @authContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueWithGoogle;

  /// No description provided for @authContinueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authContinueWithApple;

  /// No description provided for @authTravelAgencyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Travel vendor or agency? '**
  String get authTravelAgencyPrompt;

  /// No description provided for @authJoinAsTripPartner.
  ///
  /// In en, this message translates to:
  /// **'Join as a vendor'**
  String get authJoinAsTripPartner;

  /// No description provided for @authPartnerPortalTitle.
  ///
  /// In en, this message translates to:
  /// **'Partner portal'**
  String get authPartnerPortalTitle;

  /// No description provided for @authWebViewLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'This page could not be loaded. Check your connection and try again.'**
  String get authWebViewLoadFailed;

  /// No description provided for @authWebViewRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get authWebViewRetry;

  /// No description provided for @authSignUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get authSignUpTitle;

  /// No description provided for @authSignUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up To Get Started'**
  String get authSignUpSubtitle;

  /// No description provided for @authFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get authFullNameLabel;

  /// No description provided for @authFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get authFullNameHint;

  /// No description provided for @authPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get authPhoneLabel;

  /// No description provided for @authPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get authPhoneHint;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get authConfirmPasswordHint;

  /// No description provided for @authSignUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUpButton;

  /// No description provided for @authOrSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'Or Sign Up with'**
  String get authOrSignUpWith;

  /// No description provided for @authSocialGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get authSocialGoogle;

  /// No description provided for @authSocialApple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get authSocialApple;

  /// No description provided for @authHaveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authHaveAccountPrompt;

  /// No description provided for @authLoginAction.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginAction;

  /// No description provided for @authForgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Your Password'**
  String get authForgotPasswordTitle;

  /// No description provided for @authForgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address below and we will send you a link to reset your password.'**
  String get authForgotPasswordDescription;

  /// No description provided for @authForgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot it? Let’s fix it.'**
  String get authForgotPasswordSubtitle;

  /// No description provided for @authSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get authSendButton;

  /// No description provided for @authSendCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get authSendCodeButton;

  /// No description provided for @authVerifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Number'**
  String get authVerifyTitle;

  /// No description provided for @authVerifyDescription.
  ///
  /// In en, this message translates to:
  /// **'We have sent you an OTP code to your registered number. Please enter the code below.'**
  String get authVerifyDescription;

  /// No description provided for @authVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get authVerifyButton;

  /// No description provided for @authBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get authBack;

  /// No description provided for @authResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get authResendCode;

  /// No description provided for @authVerifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get authVerifyEmailTitle;

  /// No description provided for @authVerifyEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We send you 6- digit code to verify your number'**
  String get authVerifyEmailSubtitle;

  /// No description provided for @authVerificationCodeNotReceived.
  ///
  /// In en, this message translates to:
  /// **'Verification code not received?'**
  String get authVerificationCodeNotReceived;

  /// No description provided for @authResendNow.
  ///
  /// In en, this message translates to:
  /// **'Resend Now'**
  String get authResendNow;

  /// No description provided for @homeAppTitle.
  ///
  /// In en, this message translates to:
  /// **'TripMarche'**
  String get homeAppTitle;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a trip'**
  String get homeSearchHint;

  /// No description provided for @homeLocationText.
  ///
  /// In en, this message translates to:
  /// **'Egypt, Cairo, New Cairo'**
  String get homeLocationText;

  /// No description provided for @homeTrendingDestinations.
  ///
  /// In en, this message translates to:
  /// **'Trending Destinations'**
  String get homeTrendingDestinations;

  /// No description provided for @homePopularTrips.
  ///
  /// In en, this message translates to:
  /// **'Popular Trips'**
  String get homePopularTrips;

  /// No description provided for @homeSponsoredTrips.
  ///
  /// In en, this message translates to:
  /// **'Sponsored Trips'**
  String get homeSponsoredTrips;

  /// No description provided for @homeDomesticTripsInEgypt.
  ///
  /// In en, this message translates to:
  /// **'Domestic Trips In Egypt'**
  String get homeDomesticTripsInEgypt;

  /// No description provided for @homeInternationalTripsFromEgypt.
  ///
  /// In en, this message translates to:
  /// **'International Trips From Egypt'**
  String get homeInternationalTripsFromEgypt;

  /// No description provided for @homeRecommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended For You'**
  String get homeRecommendedForYou;

  /// No description provided for @homeSpecialTrips.
  ///
  /// In en, this message translates to:
  /// **'Special Trips'**
  String get homeSpecialTrips;

  /// No description provided for @homeTopRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get homeTopRated;

  /// No description provided for @homeFromCairoAlexandria.
  ///
  /// In en, this message translates to:
  /// **'From Cairo & Alexandria'**
  String get homeFromCairoAlexandria;

  /// No description provided for @homeNewInTripMarche.
  ///
  /// In en, this message translates to:
  /// **'New in TripMarche'**
  String get homeNewInTripMarche;

  /// No description provided for @homePerPerson.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get homePerPerson;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// No description provided for @wishlistTitle.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlistTitle;

  /// No description provided for @wishlistSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a trip'**
  String get wishlistSearchHint;

  /// No description provided for @wishlistSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get wishlistSortBy;

  /// No description provided for @wishlistFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get wishlistFilters;

  /// No description provided for @wishlistNewInTripMarche.
  ///
  /// In en, this message translates to:
  /// **'New in TripMarche'**
  String get wishlistNewInTripMarche;

  /// No description provided for @wishlistRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get wishlistRecommended;

  /// No description provided for @wishlistBestPrice.
  ///
  /// In en, this message translates to:
  /// **'Best Price'**
  String get wishlistBestPrice;

  /// No description provided for @wishlistEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No trips saved yet'**
  String get wishlistEmptyTitle;

  /// No description provided for @wishlistEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on any trip to\nsave it to your wishlist.'**
  String get wishlistEmptyDescription;

  /// No description provided for @wishlistFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get wishlistFiltersTitle;

  /// No description provided for @wishlistFiltersClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get wishlistFiltersClearAll;

  /// No description provided for @wishlistFiltersDestination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get wishlistFiltersDestination;

  /// No description provided for @wishlistFiltersSelectDestination.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get wishlistFiltersSelectDestination;

  /// No description provided for @wishlistFiltersPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get wishlistFiltersPriceRange;

  /// No description provided for @wishlistFiltersTripType.
  ///
  /// In en, this message translates to:
  /// **'Trip Type'**
  String get wishlistFiltersTripType;

  /// No description provided for @wishlistFiltersDomestic.
  ///
  /// In en, this message translates to:
  /// **'Domestic'**
  String get wishlistFiltersDomestic;

  /// No description provided for @wishlistFiltersInternational.
  ///
  /// In en, this message translates to:
  /// **'International'**
  String get wishlistFiltersInternational;

  /// No description provided for @wishlistFiltersDepartureCountry.
  ///
  /// In en, this message translates to:
  /// **'Departure Country'**
  String get wishlistFiltersDepartureCountry;

  /// No description provided for @wishlistFiltersDepartureCity.
  ///
  /// In en, this message translates to:
  /// **'Departure City'**
  String get wishlistFiltersDepartureCity;

  /// No description provided for @wishlistFiltersSelectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get wishlistFiltersSelectCountry;

  /// No description provided for @wishlistFiltersSelectCity.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get wishlistFiltersSelectCity;

  /// No description provided for @wishlistFiltersTripMonth.
  ///
  /// In en, this message translates to:
  /// **'Trip Month'**
  String get wishlistFiltersTripMonth;

  /// No description provided for @wishlistFiltersSelectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get wishlistFiltersSelectMonth;

  /// No description provided for @wishlistFiltersActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get wishlistFiltersActions;

  /// No description provided for @wishlistFiltersSelectAction.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get wishlistFiltersSelectAction;

  /// No description provided for @wishlistFiltersTravelAgency.
  ///
  /// In en, this message translates to:
  /// **'Travel Agency'**
  String get wishlistFiltersTravelAgency;

  /// No description provided for @wishlistFiltersAgencyNameHint.
  ///
  /// In en, this message translates to:
  /// **'Travel agency name'**
  String get wishlistFiltersAgencyNameHint;

  /// No description provided for @wishlistFiltersAgencyRating.
  ///
  /// In en, this message translates to:
  /// **'Travel Agency Rating'**
  String get wishlistFiltersAgencyRating;

  /// No description provided for @wishlistFiltersOtherCountries.
  ///
  /// In en, this message translates to:
  /// **'Other Countries'**
  String get wishlistFiltersOtherCountries;

  /// No description provided for @wishlistFiltersOtherCities.
  ///
  /// In en, this message translates to:
  /// **'Other Cities'**
  String get wishlistFiltersOtherCities;

  /// No description provided for @wishlistFiltersSelectCountries.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get wishlistFiltersSelectCountries;

  /// No description provided for @wishlistFiltersSelectCities.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get wishlistFiltersSelectCities;

  /// No description provided for @wishlistFiltersNumberOfCities.
  ///
  /// In en, this message translates to:
  /// **'Number of Cities'**
  String get wishlistFiltersNumberOfCities;

  /// No description provided for @wishlistFiltersNumberOfCountries.
  ///
  /// In en, this message translates to:
  /// **'Number of Countries'**
  String get wishlistFiltersNumberOfCountries;

  /// No description provided for @wishlistFiltersDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get wishlistFiltersDuration;

  /// No description provided for @wishlistFiltersDurationUpTo3.
  ///
  /// In en, this message translates to:
  /// **'Up to 3 Days'**
  String get wishlistFiltersDurationUpTo3;

  /// No description provided for @wishlistFiltersDurationUpTo7.
  ///
  /// In en, this message translates to:
  /// **'Up to 7 Days'**
  String get wishlistFiltersDurationUpTo7;

  /// No description provided for @wishlistFiltersDuration7Plus.
  ///
  /// In en, this message translates to:
  /// **'+7 Days'**
  String get wishlistFiltersDuration7Plus;

  /// No description provided for @wishlistFiltersGroupSize.
  ///
  /// In en, this message translates to:
  /// **'Group Size'**
  String get wishlistFiltersGroupSize;

  /// No description provided for @wishlistFiltersGroupSizeSmall.
  ///
  /// In en, this message translates to:
  /// **'Up to 10'**
  String get wishlistFiltersGroupSizeSmall;

  /// No description provided for @wishlistFiltersGroupSizeUpTo20.
  ///
  /// In en, this message translates to:
  /// **'Up to 20'**
  String get wishlistFiltersGroupSizeUpTo20;

  /// No description provided for @wishlistFiltersGroupSize20Plus.
  ///
  /// In en, this message translates to:
  /// **'20+'**
  String get wishlistFiltersGroupSize20Plus;

  /// No description provided for @wishlistFiltersTripSeason.
  ///
  /// In en, this message translates to:
  /// **'Trip Season'**
  String get wishlistFiltersTripSeason;

  /// No description provided for @wishlistFiltersSeasonSpring.
  ///
  /// In en, this message translates to:
  /// **'Spring'**
  String get wishlistFiltersSeasonSpring;

  /// No description provided for @wishlistFiltersSeasonHajj.
  ///
  /// In en, this message translates to:
  /// **'Hajj'**
  String get wishlistFiltersSeasonHajj;

  /// No description provided for @wishlistFiltersSeasonNewYear.
  ///
  /// In en, this message translates to:
  /// **'New Year'**
  String get wishlistFiltersSeasonNewYear;

  /// No description provided for @wishlistFiltersTripFeatures.
  ///
  /// In en, this message translates to:
  /// **'Trip Features'**
  String get wishlistFiltersTripFeatures;

  /// No description provided for @wishlistFiltersFeatureIncludeFlight.
  ///
  /// In en, this message translates to:
  /// **'Include flight'**
  String get wishlistFiltersFeatureIncludeFlight;

  /// No description provided for @wishlistFiltersFeatureIncludeHotel.
  ///
  /// In en, this message translates to:
  /// **'Include hotel'**
  String get wishlistFiltersFeatureIncludeHotel;

  /// No description provided for @wishlistFiltersFeatureFreeMeal.
  ///
  /// In en, this message translates to:
  /// **'Free meal'**
  String get wishlistFiltersFeatureFreeMeal;

  /// No description provided for @wishlistFiltersFeatureVisaOnArrival.
  ///
  /// In en, this message translates to:
  /// **'Visa on arrival'**
  String get wishlistFiltersFeatureVisaOnArrival;

  /// No description provided for @wishlistFiltersTripRating.
  ///
  /// In en, this message translates to:
  /// **'Trip Rating'**
  String get wishlistFiltersTripRating;

  /// No description provided for @wishlistFiltersDiscountCode.
  ///
  /// In en, this message translates to:
  /// **'Trip applies discount code'**
  String get wishlistFiltersDiscountCode;

  /// No description provided for @wishlistFiltersFreeCancellation.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation'**
  String get wishlistFiltersFreeCancellation;

  /// No description provided for @wishlistFiltersSeeResults.
  ///
  /// In en, this message translates to:
  /// **'See +500 Results'**
  String get wishlistFiltersSeeResults;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNotificationSetting.
  ///
  /// In en, this message translates to:
  /// **'Notification Setting'**
  String get settingsNotificationSetting;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settingsCurrency;

  /// No description provided for @settingsEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsEnglish;

  /// No description provided for @settingsArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settingsArabic;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version {version}'**
  String settingsAppVersion(Object version);

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Setting'**
  String get notificationSettingsTitle;

  /// No description provided for @notificationSettingsIntro.
  ///
  /// In en, this message translates to:
  /// **'Manage your notification preferences to stay updated on new trips, offers, and booking updates.'**
  String get notificationSettingsIntro;

  /// No description provided for @notificationSettingsBookingUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Updates'**
  String get notificationSettingsBookingUpdatesTitle;

  /// No description provided for @notificationSettingsBookingUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive real-time updates about trip confirmations, cancellations, and changes to your bookings.'**
  String get notificationSettingsBookingUpdatesSubtitle;

  /// No description provided for @notificationSettingsToursTitle.
  ///
  /// In en, this message translates to:
  /// **'Tours'**
  String get notificationSettingsToursTitle;

  /// No description provided for @notificationSettingsToursSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get notified when new trips or tours are added that match your interests.'**
  String get notificationSettingsToursSubtitle;

  /// No description provided for @notificationSettingsReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get notificationSettingsReviewsTitle;

  /// No description provided for @notificationSettingsReviewsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Be alerted when someone responds to your review or when you\'re invited to review a trip you’ve taken.'**
  String get notificationSettingsReviewsSubtitle;

  /// No description provided for @notificationSettingsPromotionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get access to special discounts, limited-time offers, and seasonal promotions.'**
  String get notificationSettingsPromotionsSubtitle;

  /// No description provided for @notificationSettingsPush.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get notificationSettingsPush;

  /// No description provided for @notificationSettingsEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get notificationSettingsEmail;

  /// No description provided for @notificationSettingsTripUpdates.
  ///
  /// In en, this message translates to:
  /// **'Trip Updates'**
  String get notificationSettingsTripUpdates;

  /// No description provided for @notificationSettingsPromotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get notificationSettingsPromotions;

  /// No description provided for @notificationSettingsPriceAlerts.
  ///
  /// In en, this message translates to:
  /// **'Price Alerts'**
  String get notificationSettingsPriceAlerts;

  /// No description provided for @profileTitleAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileTitleAccount;

  /// No description provided for @profileTitleSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get profileTitleSupport;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get profilePersonalInfo;

  /// No description provided for @profilePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get profilePaymentMethod;

  /// No description provided for @profileMyReviews.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get profileMyReviews;

  /// No description provided for @profileAddReview.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get profileAddReview;

  /// No description provided for @profileReviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get profileReviewLabel;

  /// No description provided for @profileProductRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Rating'**
  String get profileProductRatingLabel;

  /// No description provided for @profileMyReviewsRoute.
  ///
  /// In en, this message translates to:
  /// **'Cairo → Dahab'**
  String get profileMyReviewsRoute;

  /// No description provided for @profileFollowingCompanies.
  ///
  /// In en, this message translates to:
  /// **'Following Companies'**
  String get profileFollowingCompanies;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileCustomerService.
  ///
  /// In en, this message translates to:
  /// **'Customer Service'**
  String get profileCustomerService;

  /// No description provided for @profileFaqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get profileFaqs;

  /// No description provided for @profileTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get profileTermsAndConditions;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccount;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileLogout;

  /// No description provided for @profileTripsBooked.
  ///
  /// In en, this message translates to:
  /// **'{count} Trips booked'**
  String profileTripsBooked(Object count);

  /// No description provided for @profileDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccountTitle;

  /// No description provided for @profileDeleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get profileDeleteAccountMessage;

  /// No description provided for @profileLogoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileLogoutConfirmTitle;

  /// No description provided for @profileLogoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get profileLogoutConfirmMessage;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @followingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Followings'**
  String get followingsTitle;

  /// No description provided for @followingsCountTitle.
  ///
  /// In en, this message translates to:
  /// **'{count} Following'**
  String followingsCountTitle(Object count);

  /// No description provided for @followingsUnfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get followingsUnfollow;

  /// No description provided for @followingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No followings yet'**
  String get followingsEmptyTitle;

  /// No description provided for @followingsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Start following companies to see\ntheir trips here.'**
  String get followingsEmptyDescription;

  /// No description provided for @myTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get myTripsTitle;

  /// No description provided for @myTripsTabUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get myTripsTabUpcoming;

  /// No description provided for @myTripsTabPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get myTripsTabPast;

  /// No description provided for @myTripsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a trip'**
  String get myTripsSearchHint;

  /// No description provided for @myTripsCatalogTripsOf.
  ///
  /// In en, this message translates to:
  /// **'Trips Of'**
  String get myTripsCatalogTripsOf;

  /// No description provided for @myTripsCatalogReviewCountInline.
  ///
  /// In en, this message translates to:
  /// **'({count})'**
  String myTripsCatalogReviewCountInline(int count);

  /// No description provided for @myTripsCatalogSaveWishlist.
  ///
  /// In en, this message translates to:
  /// **'Save to wishlist'**
  String get myTripsCatalogSaveWishlist;

  /// No description provided for @myTripsCatalogRemoveWishlist.
  ///
  /// In en, this message translates to:
  /// **'Remove from wishlist'**
  String get myTripsCatalogRemoveWishlist;

  /// No description provided for @myTripsTabActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get myTripsTabActive;

  /// No description provided for @myTripsTabPastNew.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get myTripsTabPastNew;

  /// No description provided for @myTripsTabCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get myTripsTabCanceled;

  /// No description provided for @myTripsStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get myTripsStatusActive;

  /// No description provided for @myTripsStatusPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get myTripsStatusPast;

  /// No description provided for @myTripsStatusCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get myTripsStatusCanceled;

  /// No description provided for @myTripsBookAgain.
  ///
  /// In en, this message translates to:
  /// **'Book Again'**
  String get myTripsBookAgain;

  /// No description provided for @myTripsFromPrefix.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get myTripsFromPrefix;

  /// No description provided for @myTripsViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get myTripsViewDetails;

  /// No description provided for @myTripsViewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View Receipt'**
  String get myTripsViewReceipt;

  /// No description provided for @myTripsBookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get myTripsBookingDetails;

  /// No description provided for @myTripsDownloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download pdf'**
  String get myTripsDownloadPdf;

  /// No description provided for @myTripsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get myTripsEmptyTitle;

  /// No description provided for @myTripsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Start exploring and book your\nfirst adventure!'**
  String get myTripsEmptyDescription;

  /// No description provided for @myTripsExploreTrips.
  ///
  /// In en, this message translates to:
  /// **'Explore Trips'**
  String get myTripsExploreTrips;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get navTrips;

  /// No description provided for @navWishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get navWishlist;

  /// No description provided for @navAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get navAccount;

  /// No description provided for @bookingContactInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get bookingContactInfoTitle;

  /// No description provided for @bookingContactFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get bookingContactFullNameLabel;

  /// No description provided for @bookingContactFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get bookingContactFullNameHint;

  /// No description provided for @bookingContactPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get bookingContactPhoneLabel;

  /// No description provided for @bookingContactPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+20 123 456 7890'**
  String get bookingContactPhoneHint;

  /// No description provided for @bookingContactEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get bookingContactEmailLabel;

  /// No description provided for @bookingContactEmailHint.
  ///
  /// In en, this message translates to:
  /// **'email@example.com'**
  String get bookingContactEmailHint;

  /// No description provided for @bookingContactEmergencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get bookingContactEmergencyLabel;

  /// No description provided for @bookingContactEmergencyHint.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact number'**
  String get bookingContactEmergencyHint;

  /// No description provided for @bookingContactIdPassportLabel.
  ///
  /// In en, this message translates to:
  /// **'ID/Passport Number'**
  String get bookingContactIdPassportLabel;

  /// No description provided for @bookingContactIdPassportHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your ID or Passport number'**
  String get bookingContactIdPassportHint;

  /// No description provided for @bookingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get bookingContinue;

  /// No description provided for @bookingAddNewCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get bookingAddNewCardTitle;

  /// No description provided for @bookingCardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get bookingCardNumberLabel;

  /// No description provided for @bookingCardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'0000 0000 0000 0000'**
  String get bookingCardNumberHint;

  /// No description provided for @bookingCardholderNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get bookingCardholderNameLabel;

  /// No description provided for @bookingCardholderNameHint.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get bookingCardholderNameHint;

  /// No description provided for @bookingExpiryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get bookingExpiryDateLabel;

  /// No description provided for @bookingExpiryDateHint.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get bookingExpiryDateHint;

  /// No description provided for @bookingCvvLabel.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get bookingCvvLabel;

  /// No description provided for @bookingCvvHint.
  ///
  /// In en, this message translates to:
  /// **'***'**
  String get bookingCvvHint;

  /// No description provided for @bookingSaveCard.
  ///
  /// In en, this message translates to:
  /// **'Save Card'**
  String get bookingSaveCard;

  /// No description provided for @bookingCardholderNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'CARDHOLDER NAME'**
  String get bookingCardholderNamePlaceholder;

  /// No description provided for @bookingPaymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get bookingPaymentMethodTitle;

  /// No description provided for @bookingPaymentOptionCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get bookingPaymentOptionCreditCard;

  /// No description provided for @bookingPaymentOptionCreditCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay with Visa, Mastercard'**
  String get bookingPaymentOptionCreditCardSubtitle;

  /// No description provided for @bookingPaymentOptionPaypal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get bookingPaymentOptionPaypal;

  /// No description provided for @bookingPaymentOptionPaypalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay with your PayPal account'**
  String get bookingPaymentOptionPaypalSubtitle;

  /// No description provided for @bookingPaymentOptionApplePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get bookingPaymentOptionApplePay;

  /// No description provided for @bookingPaymentOptionApplePaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay with Apple Pay'**
  String get bookingPaymentOptionApplePaySubtitle;

  /// No description provided for @bookingSavedCards.
  ///
  /// In en, this message translates to:
  /// **'Saved Cards'**
  String get bookingSavedCards;

  /// No description provided for @bookingAddNewCard.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get bookingAddNewCard;

  /// No description provided for @bookingPayNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now - {amount}'**
  String bookingPayNow(Object amount);

  /// No description provided for @bookingCardExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires {expiry}'**
  String bookingCardExpires(Object expiry);

  /// No description provided for @profilePersonalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get profilePersonalInfoTitle;

  /// No description provided for @profileFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileFullNameLabel;

  /// No description provided for @profileEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmailLabel;

  /// No description provided for @profilePhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profilePhoneNumberLabel;

  /// No description provided for @profilePasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get profilePasswordLabel;

  /// No description provided for @profileCountryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get profileCountryLabel;

  /// No description provided for @profileCityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get profileCityLabel;

  /// No description provided for @profileEditAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileEditAction;

  /// No description provided for @profileChangePasswordAction.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileChangePasswordAction;

  /// No description provided for @profileGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileGender;

  /// No description provided for @profileGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get profileGenderMale;

  /// No description provided for @profileGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get profileGenderFemale;

  /// No description provided for @profileDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profileDateOfBirth;

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileSaveChanges;

  /// No description provided for @companyProfileCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Travel Egypt Co.'**
  String get companyProfileCompanyName;

  /// No description provided for @companyProfileReviewsCountShort.
  ///
  /// In en, this message translates to:
  /// **'({count} reviews)'**
  String companyProfileReviewsCountShort(Object count);

  /// No description provided for @companyProfileFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get companyProfileFollowing;

  /// No description provided for @companyProfileFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get companyProfileFollow;

  /// No description provided for @companyProfileStatsTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get companyProfileStatsTrips;

  /// No description provided for @companyProfileStatsReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get companyProfileStatsReviews;

  /// No description provided for @companyProfileStatsFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get companyProfileStatsFollowers;

  /// No description provided for @companyProfileAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get companyProfileAbout;

  /// No description provided for @companyProfileAboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Travel Egypt Co. is a leading travel company specializing in Egyptian tours and adventures. We offer unique experiences across Egypt, from the ancient pyramids to the beautiful Red Sea resorts.'**
  String get companyProfileAboutDescription;

  /// No description provided for @companyProfileTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get companyProfileTrips;

  /// No description provided for @companyProfileReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get companyProfileReviews;

  /// No description provided for @companyProfileSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get companyProfileSeeAll;

  /// No description provided for @companyProfileTripName.
  ///
  /// In en, this message translates to:
  /// **'Trip Name'**
  String get companyProfileTripName;

  /// No description provided for @companyProfileReviewAuthor.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get companyProfileReviewAuthor;

  /// No description provided for @companyProfileReviewDate.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get companyProfileReviewDate;

  /// No description provided for @companyProfileReviewComment.
  ///
  /// In en, this message translates to:
  /// **'Great experience! The trip was well organized and the guide was very knowledgeable.'**
  String get companyProfileReviewComment;

  /// No description provided for @filterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterTitle;

  /// No description provided for @filterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filterReset;

  /// No description provided for @filterDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get filterDuration;

  /// No description provided for @filterTripType.
  ///
  /// In en, this message translates to:
  /// **'Trip Type'**
  String get filterTripType;

  /// No description provided for @filterRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get filterRating;

  /// No description provided for @filterDepartureCity.
  ///
  /// In en, this message translates to:
  /// **'Departure City'**
  String get filterDepartureCity;

  /// No description provided for @filterSelectCity.
  ///
  /// In en, this message translates to:
  /// **'Select city'**
  String get filterSelectCity;

  /// No description provided for @filterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get filterApply;

  /// No description provided for @destinationTitle.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destinationTitle;

  /// No description provided for @destinationSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search destinations...'**
  String get destinationSearchHint;

  /// No description provided for @destinationRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get destinationRecentSearches;

  /// No description provided for @destinationClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get destinationClearAll;

  /// No description provided for @destinationPopularDestinations.
  ///
  /// In en, this message translates to:
  /// **'Popular Destinations'**
  String get destinationPopularDestinations;

  /// No description provided for @searchTripsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} trips found'**
  String searchTripsFound(Object count);

  /// No description provided for @searchQueryExample.
  ///
  /// In en, this message translates to:
  /// **'Sharm El Sheikh'**
  String get searchQueryExample;

  /// No description provided for @searchResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Result'**
  String get searchResultTitle;

  /// No description provided for @searchResultSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a trip'**
  String get searchResultSearchHint;

  /// No description provided for @searchResultSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get searchResultSortBy;

  /// No description provided for @searchResultFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get searchResultFilters;

  /// No description provided for @searchResultRating.
  ///
  /// In en, this message translates to:
  /// **'4.9'**
  String get searchResultRating;

  /// No description provided for @searchResultReviews.
  ///
  /// In en, this message translates to:
  /// **'(112)'**
  String get searchResultReviews;

  /// No description provided for @searchResultFromCity.
  ///
  /// In en, this message translates to:
  /// **'From Cairo'**
  String get searchResultFromCity;

  /// No description provided for @searchResultDateFrom.
  ///
  /// In en, this message translates to:
  /// **'27 Nov'**
  String get searchResultDateFrom;

  /// No description provided for @searchResultDateTo.
  ///
  /// In en, this message translates to:
  /// **'4 Dec'**
  String get searchResultDateTo;

  /// No description provided for @searchResultLabelNew.
  ///
  /// In en, this message translates to:
  /// **'New in TripMarche'**
  String get searchResultLabelNew;

  /// No description provided for @searchResultLabelRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get searchResultLabelRecommended;

  /// No description provided for @searchResultLabelBestPrice.
  ///
  /// In en, this message translates to:
  /// **'Best Price'**
  String get searchResultLabelBestPrice;

  /// No description provided for @searchResultOldPrice.
  ///
  /// In en, this message translates to:
  /// **'\$1000'**
  String get searchResultOldPrice;

  /// No description provided for @searchResultDiscountPrice.
  ///
  /// In en, this message translates to:
  /// **'\$699'**
  String get searchResultDiscountPrice;

  /// No description provided for @searchResultPerPerson.
  ///
  /// In en, this message translates to:
  /// **'/Person'**
  String get searchResultPerPerson;

  /// No description provided for @tripDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Dahab Trip'**
  String get tripDetailsTitle;

  /// No description provided for @tripDetailsHeroCountryTag.
  ///
  /// In en, this message translates to:
  /// **'Indonesia'**
  String get tripDetailsHeroCountryTag;

  /// No description provided for @tripDetailsHeroByCompany.
  ///
  /// In en, this message translates to:
  /// **'By Travel Company'**
  String get tripDetailsHeroByCompany;

  /// No description provided for @tripDetailsHeroFromLocation.
  ///
  /// In en, this message translates to:
  /// **'From Cairo & Alexandria'**
  String get tripDetailsHeroFromLocation;

  /// No description provided for @tripDetailsHeroDateRange.
  ///
  /// In en, this message translates to:
  /// **'27 Nov → 4 Dec'**
  String get tripDetailsHeroDateRange;

  /// Prefix before pickup cities on trip details hero; cities follow in bold.
  ///
  /// In en, this message translates to:
  /// **'From '**
  String get tripDetailsHeroFromPrefix;

  /// Travel vendor line on trip details hero.
  ///
  /// In en, this message translates to:
  /// **'By {company}'**
  String tripDetailsHeroByCompanyLine(String company);

  /// No description provided for @tripDetailsGalleryMoreCount.
  ///
  /// In en, this message translates to:
  /// **'+{count}'**
  String tripDetailsGalleryMoreCount(Object count);

  /// Full-screen photo viewer counter
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String imageGalleryPosition(int current, int total);

  /// No description provided for @tripDetailsOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Overview'**
  String get tripDetailsOverviewTitle;

  /// No description provided for @tripDetailsOverviewBody.
  ///
  /// In en, this message translates to:
  /// **'Experience the breathtaking beauty of the Swiss Alps on this 7-day adventure. Visit iconic destinations, enjoy scenic train rides, and immerse yourself in Swiss culture. Perfect for nature lovers and photography enthusiasts.'**
  String get tripDetailsOverviewBody;

  /// No description provided for @tripDetailsWhatsIncludedTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s Included'**
  String get tripDetailsWhatsIncludedTitle;

  /// No description provided for @tripDetailsIncludedFlightTickets.
  ///
  /// In en, this message translates to:
  /// **'Flight Tickets'**
  String get tripDetailsIncludedFlightTickets;

  /// No description provided for @tripDetailsIncludedHotelStay.
  ///
  /// In en, this message translates to:
  /// **'Hotel Stay'**
  String get tripDetailsIncludedHotelStay;

  /// No description provided for @tripDetailsIncludedBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get tripDetailsIncludedBreakfast;

  /// No description provided for @tripDetailsIncludedAirportTransfer.
  ///
  /// In en, this message translates to:
  /// **'Airport Transfer'**
  String get tripDetailsIncludedAirportTransfer;

  /// No description provided for @tripDetailsDepartureDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Departure Details'**
  String get tripDetailsDepartureDetailsTitle;

  /// No description provided for @tripDetailsMeetingLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Meeting Location'**
  String get tripDetailsMeetingLocationLabel;

  /// No description provided for @tripDetailsMeetingLocationValue.
  ///
  /// In en, this message translates to:
  /// **'18 El Tesen Road, New Cairo, Egypt'**
  String get tripDetailsMeetingLocationValue;

  /// No description provided for @tripDetailsReturnLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Return Location'**
  String get tripDetailsReturnLocationLabel;

  /// No description provided for @tripDetailsReturnLocationValue.
  ///
  /// In en, this message translates to:
  /// **'54 Ramses, Downtown, Egypt'**
  String get tripDetailsReturnLocationValue;

  /// No description provided for @tripDetailsMeetingTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Meeting Time'**
  String get tripDetailsMeetingTimeLabel;

  /// No description provided for @tripDetailsMeetingTimeValue.
  ///
  /// In en, this message translates to:
  /// **'5:00 PM'**
  String get tripDetailsMeetingTimeValue;

  /// No description provided for @tripDetailsReturnTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Return Time'**
  String get tripDetailsReturnTimeLabel;

  /// No description provided for @tripDetailsReturnTimeValue.
  ///
  /// In en, this message translates to:
  /// **'9:30 PM'**
  String get tripDetailsReturnTimeValue;

  /// No description provided for @tripDetailsProgramTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Program'**
  String get tripDetailsProgramTitle;

  /// No description provided for @tripDetailsProgramMealsLabel.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get tripDetailsProgramMealsLabel;

  /// No description provided for @tripDetailsProgramDay1.
  ///
  /// In en, this message translates to:
  /// **'Day 1'**
  String get tripDetailsProgramDay1;

  /// No description provided for @tripDetailsProgramDay2.
  ///
  /// In en, this message translates to:
  /// **'Day 2'**
  String get tripDetailsProgramDay2;

  /// No description provided for @tripDetailsProgramCity1.
  ///
  /// In en, this message translates to:
  /// **'Beijing'**
  String get tripDetailsProgramCity1;

  /// No description provided for @tripDetailsProgramCity2.
  ///
  /// In en, this message translates to:
  /// **'Hangzhou'**
  String get tripDetailsProgramCity2;

  /// No description provided for @tripDetailsProgramDay1Item1.
  ///
  /// In en, this message translates to:
  /// **'Arrival at Changdu Airport'**
  String get tripDetailsProgramDay1Item1;

  /// No description provided for @tripDetailsProgramDay1Item2.
  ///
  /// In en, this message translates to:
  /// **'Domestic flight to Beijing'**
  String get tripDetailsProgramDay1Item2;

  /// No description provided for @tripDetailsProgramDay1Item3.
  ///
  /// In en, this message translates to:
  /// **'Hotel check-in'**
  String get tripDetailsProgramDay1Item3;

  /// No description provided for @tripDetailsProgramDay1Item4.
  ///
  /// In en, this message translates to:
  /// **'Free tour in Wangfujing Street'**
  String get tripDetailsProgramDay1Item4;

  /// No description provided for @tripDetailsProgramDay2Item1.
  ///
  /// In en, this message translates to:
  /// **'City tour in Hangzhou'**
  String get tripDetailsProgramDay2Item1;

  /// No description provided for @tripDetailsProgramDay2Item2.
  ///
  /// In en, this message translates to:
  /// **'Hotel check-in and evening tour'**
  String get tripDetailsProgramDay2Item2;

  /// No description provided for @tripDetailsProgramDay2Item3.
  ///
  /// In en, this message translates to:
  /// **'Visit West Lake by Cruise'**
  String get tripDetailsProgramDay2Item3;

  /// No description provided for @tripDetailsProgramSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All Program'**
  String get tripDetailsProgramSeeAll;

  /// No description provided for @tripDetailsAirlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Airline'**
  String get tripDetailsAirlineLabel;

  /// No description provided for @tripDetailsAirlineName.
  ///
  /// In en, this message translates to:
  /// **'Egyptair'**
  String get tripDetailsAirlineName;

  /// No description provided for @tripDetailsFlightLeg1FromCity.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get tripDetailsFlightLeg1FromCity;

  /// No description provided for @tripDetailsFlightLeg1FromTime.
  ///
  /// In en, this message translates to:
  /// **'5:00 AM'**
  String get tripDetailsFlightLeg1FromTime;

  /// No description provided for @tripDetailsFlightLeg1ToCity.
  ///
  /// In en, this message translates to:
  /// **'Paris'**
  String get tripDetailsFlightLeg1ToCity;

  /// No description provided for @tripDetailsFlightLeg1ToTime.
  ///
  /// In en, this message translates to:
  /// **'7:20 AM'**
  String get tripDetailsFlightLeg1ToTime;

  /// No description provided for @tripDetailsFlightLeg1Date.
  ///
  /// In en, this message translates to:
  /// **'28 April'**
  String get tripDetailsFlightLeg1Date;

  /// No description provided for @tripDetailsFlightLeg2FromCity.
  ///
  /// In en, this message translates to:
  /// **'Paris'**
  String get tripDetailsFlightLeg2FromCity;

  /// No description provided for @tripDetailsFlightLeg2FromTime.
  ///
  /// In en, this message translates to:
  /// **'8:00 AM'**
  String get tripDetailsFlightLeg2FromTime;

  /// No description provided for @tripDetailsFlightLeg2ToCity.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get tripDetailsFlightLeg2ToCity;

  /// No description provided for @tripDetailsFlightLeg2ToTime.
  ///
  /// In en, this message translates to:
  /// **'5:20 AM'**
  String get tripDetailsFlightLeg2ToTime;

  /// No description provided for @tripDetailsFlightLeg2Date.
  ///
  /// In en, this message translates to:
  /// **'4 May'**
  String get tripDetailsFlightLeg2Date;

  /// No description provided for @tripDetailsTransportLeg1FromCity.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get tripDetailsTransportLeg1FromCity;

  /// No description provided for @tripDetailsTransportLeg1FromTime.
  ///
  /// In en, this message translates to:
  /// **'8:00 AM'**
  String get tripDetailsTransportLeg1FromTime;

  /// No description provided for @tripDetailsTransportLeg1ToCity.
  ///
  /// In en, this message translates to:
  /// **'Paris'**
  String get tripDetailsTransportLeg1ToCity;

  /// No description provided for @tripDetailsTransportLeg1ToTime.
  ///
  /// In en, this message translates to:
  /// **'5:20 AM'**
  String get tripDetailsTransportLeg1ToTime;

  /// No description provided for @tripDetailsTransportLeg1CenterLabel.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get tripDetailsTransportLeg1CenterLabel;

  /// No description provided for @tripDetailsTransportLeg1Date.
  ///
  /// In en, this message translates to:
  /// **'29 May'**
  String get tripDetailsTransportLeg1Date;

  /// No description provided for @tripDetailsTransportLeg2FromCity.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get tripDetailsTransportLeg2FromCity;

  /// No description provided for @tripDetailsTransportLeg2FromTime.
  ///
  /// In en, this message translates to:
  /// **'8:00 AM'**
  String get tripDetailsTransportLeg2FromTime;

  /// No description provided for @tripDetailsTransportLeg2ToCity.
  ///
  /// In en, this message translates to:
  /// **'Paris'**
  String get tripDetailsTransportLeg2ToCity;

  /// No description provided for @tripDetailsTransportLeg2ToTime.
  ///
  /// In en, this message translates to:
  /// **'5:20 AM'**
  String get tripDetailsTransportLeg2ToTime;

  /// No description provided for @tripDetailsTransportLeg2CenterLabel.
  ///
  /// In en, this message translates to:
  /// **'Boat'**
  String get tripDetailsTransportLeg2CenterLabel;

  /// No description provided for @tripDetailsTransportLeg2Date.
  ///
  /// In en, this message translates to:
  /// **'29 May'**
  String get tripDetailsTransportLeg2Date;

  /// No description provided for @tripDetailsDestinationHurghada.
  ///
  /// In en, this message translates to:
  /// **'Hurghada'**
  String get tripDetailsDestinationHurghada;

  /// No description provided for @tripDetailsDestinationParis.
  ///
  /// In en, this message translates to:
  /// **'Paris'**
  String get tripDetailsDestinationParis;

  /// No description provided for @tripDetailsStatCitiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of Cities'**
  String get tripDetailsStatCitiesLabel;

  /// No description provided for @tripDetailsStatCitiesValue.
  ///
  /// In en, this message translates to:
  /// **'7 Cities'**
  String get tripDetailsStatCitiesValue;

  /// Stat grid value for how many cities the trip visits.
  ///
  /// In en, this message translates to:
  /// **'{count} Cities'**
  String tripDetailsStatCitiesCount(int count);

  /// No description provided for @tripDetailsPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get tripDetailsPriceLabel;

  /// No description provided for @tripDetailsPerPersonSmall.
  ///
  /// In en, this message translates to:
  /// **'per person'**
  String get tripDetailsPerPersonSmall;

  /// No description provided for @tripDetailsBookingPriceDisplay.
  ///
  /// In en, this message translates to:
  /// **'1000.00'**
  String get tripDetailsBookingPriceDisplay;

  /// No description provided for @tripDetailsCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Travel Egypt Co.'**
  String get tripDetailsCompanyName;

  /// No description provided for @tripDetailsCompanyTagline.
  ///
  /// In en, this message translates to:
  /// **'Adventure Travel Agency'**
  String get tripDetailsCompanyTagline;

  /// No description provided for @tripDetailsFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get tripDetailsFollow;

  /// No description provided for @tripDetailsDurationValue.
  ///
  /// In en, this message translates to:
  /// **'7 Days'**
  String get tripDetailsDurationValue;

  /// No description provided for @tripDetailsDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get tripDetailsDurationLabel;

  /// No description provided for @tripDetailsGroupSizeValue.
  ///
  /// In en, this message translates to:
  /// **'20-25'**
  String get tripDetailsGroupSizeValue;

  /// No description provided for @tripDetailsGroupSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Group Size'**
  String get tripDetailsGroupSizeLabel;

  /// No description provided for @tripDetailsTypeValue.
  ///
  /// In en, this message translates to:
  /// **'International'**
  String get tripDetailsTypeValue;

  /// No description provided for @tripDetailsTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get tripDetailsTypeLabel;

  /// No description provided for @tripDetailsPerPerson.
  ///
  /// In en, this message translates to:
  /// **'/Person'**
  String get tripDetailsPerPerson;

  /// No description provided for @tripDetailsDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get tripDetailsDescriptionTitle;

  /// No description provided for @tripDetailsReadMore.
  ///
  /// In en, this message translates to:
  /// **' Read More'**
  String get tripDetailsReadMore;

  /// No description provided for @tripDetailsShowLess.
  ///
  /// In en, this message translates to:
  /// **' Show Less'**
  String get tripDetailsShowLess;

  /// No description provided for @tripDetailsDescriptionBody.
  ///
  /// In en, this message translates to:
  /// **'Experience the magic of Dahab, a beautiful coastal city on the southeast coast of the Sinai Peninsula in Egypt. This 7-day trip includes snorkeling in the Blue Hole, desert safaris, camel rides, and visits to ancient Bedouin villages. Enjoy the stunning coral reefs, crystal-clear waters, and breathtaking mountain landscapes. Our experienced guides will ensure you have an unforgettable adventure with comfortable accommodations and delicious local cuisine.'**
  String get tripDetailsDescriptionBody;

  /// No description provided for @tripDetailsItineraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Itinerary'**
  String get tripDetailsItineraryTitle;

  /// No description provided for @tripDetailsIncludesTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Includes'**
  String get tripDetailsIncludesTitle;

  /// No description provided for @tripDetailsIncludesHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get tripDetailsIncludesHotel;

  /// No description provided for @tripDetailsIncludesTransportation.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get tripDetailsIncludesTransportation;

  /// No description provided for @tripDetailsIncludesMeals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get tripDetailsIncludesMeals;

  /// No description provided for @tripDetailsIncludesActivities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get tripDetailsIncludesActivities;

  /// No description provided for @tripDetailsIncludesTourGuide.
  ///
  /// In en, this message translates to:
  /// **'Tour Guide'**
  String get tripDetailsIncludesTourGuide;

  /// No description provided for @tripDetailsImagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Images'**
  String get tripDetailsImagesTitle;

  /// No description provided for @tripDetailsReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get tripDetailsReviewsTitle;

  /// No description provided for @tripDetailsReviewsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Reviews'**
  String tripDetailsReviewsCount(Object count);

  /// No description provided for @tripDetailsRelatedTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'Related Trips'**
  String get tripDetailsRelatedTripsTitle;

  /// No description provided for @tripDetailsTotalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get tripDetailsTotalPrice;

  /// No description provided for @tripDetailsBookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get tripDetailsBookNow;

  /// No description provided for @tripDetailsPricePerPersonShort.
  ///
  /// In en, this message translates to:
  /// **'{price}/Person'**
  String tripDetailsPricePerPersonShort(Object price);

  /// No description provided for @tripDetailsDay1Title.
  ///
  /// In en, this message translates to:
  /// **'Day 1 - Arrival & Check-in'**
  String get tripDetailsDay1Title;

  /// No description provided for @tripDetailsDay1Desc.
  ///
  /// In en, this message translates to:
  /// **'Arrive at Dahab, transfer to hotel, welcome dinner and orientation meeting with the group.'**
  String get tripDetailsDay1Desc;

  /// No description provided for @tripDetailsDay2Title.
  ///
  /// In en, this message translates to:
  /// **'Day 2 - Blue Hole Snorkeling'**
  String get tripDetailsDay2Title;

  /// No description provided for @tripDetailsDay2Desc.
  ///
  /// In en, this message translates to:
  /// **'Full day snorkeling at the famous Blue Hole. Lunch at a beachside restaurant. Evening free time.'**
  String get tripDetailsDay2Desc;

  /// No description provided for @tripDetailsDay3Title.
  ///
  /// In en, this message translates to:
  /// **'Day 3 - Desert Safari'**
  String get tripDetailsDay3Title;

  /// No description provided for @tripDetailsDay3Desc.
  ///
  /// In en, this message translates to:
  /// **'Jeep safari through the Sinai desert. Visit Bedouin village. Stargazing dinner in the desert.'**
  String get tripDetailsDay3Desc;

  /// No description provided for @tripDetailsDay4Title.
  ///
  /// In en, this message translates to:
  /// **'Day 4 - Free Day & Activities'**
  String get tripDetailsDay4Title;

  /// No description provided for @tripDetailsDay4Desc.
  ///
  /// In en, this message translates to:
  /// **'Choose from optional activities: diving, camel rides, or explore the local markets.'**
  String get tripDetailsDay4Desc;

  /// No description provided for @tripDetailsDay5Title.
  ///
  /// In en, this message translates to:
  /// **'Day 5 - Mount Sinai Hike'**
  String get tripDetailsDay5Title;

  /// No description provided for @tripDetailsDay5Desc.
  ///
  /// In en, this message translates to:
  /// **'Early morning hike to Mount Sinai for sunrise. Visit St. Catherine\'s Monastery.'**
  String get tripDetailsDay5Desc;

  /// No description provided for @tripDetailsDay6Title.
  ///
  /// In en, this message translates to:
  /// **'Day 6 - Water Sports'**
  String get tripDetailsDay6Title;

  /// No description provided for @tripDetailsDay6Desc.
  ///
  /// In en, this message translates to:
  /// **'Windsurfing and kitesurfing lessons. Farewell dinner at a seaside restaurant.'**
  String get tripDetailsDay6Desc;

  /// No description provided for @tripDetailsDay7Title.
  ///
  /// In en, this message translates to:
  /// **'Day 7 - Departure'**
  String get tripDetailsDay7Title;

  /// No description provided for @tripDetailsDay7Desc.
  ///
  /// In en, this message translates to:
  /// **'Breakfast at hotel. Check-out and transfer to airport.'**
  String get tripDetailsDay7Desc;

  /// No description provided for @tripDetailsRelatedNameSharm.
  ///
  /// In en, this message translates to:
  /// **'Sharm El Sheikh'**
  String get tripDetailsRelatedNameSharm;

  /// No description provided for @tripDetailsRelatedNameHurghada.
  ///
  /// In en, this message translates to:
  /// **'Hurghada Trip'**
  String get tripDetailsRelatedNameHurghada;

  /// No description provided for @tripDetailsRelatedNameLuxorAswan.
  ///
  /// In en, this message translates to:
  /// **'Luxor & Aswan'**
  String get tripDetailsRelatedNameLuxorAswan;

  /// No description provided for @tripDetailsHeroRatingLine.
  ///
  /// In en, this message translates to:
  /// **'4.5 (120 reviews)'**
  String get tripDetailsHeroRatingLine;

  /// No description provided for @tripDetailsHeroLocationShort.
  ///
  /// In en, this message translates to:
  /// **'Dahab, Egypt'**
  String get tripDetailsHeroLocationShort;

  /// No description provided for @tripDetailsHeroDaysBadge.
  ///
  /// In en, this message translates to:
  /// **'7 Days'**
  String get tripDetailsHeroDaysBadge;

  /// No description provided for @tripDetailsOut.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get tripDetailsOut;

  /// No description provided for @tripDetailsIn.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get tripDetailsIn;

  /// No description provided for @tripDetailsOutSummaryLine1.
  ///
  /// In en, this message translates to:
  /// **'21 May, Friday'**
  String get tripDetailsOutSummaryLine1;

  /// No description provided for @tripDetailsOutSummaryLine2.
  ///
  /// In en, this message translates to:
  /// **'Cairo International Airport (CAI)'**
  String get tripDetailsOutSummaryLine2;

  /// No description provided for @tripDetailsInSummaryLine1.
  ///
  /// In en, this message translates to:
  /// **'27 May, Thursday'**
  String get tripDetailsInSummaryLine1;

  /// No description provided for @tripDetailsInSummaryLine2.
  ///
  /// In en, this message translates to:
  /// **'Dahab, South Sinai'**
  String get tripDetailsInSummaryLine2;

  /// No description provided for @tripDetailsTripDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip description'**
  String get tripDetailsTripDescriptionTitle;

  /// No description provided for @tripDetailsAmenitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get tripDetailsAmenitiesTitle;

  /// No description provided for @tripDetailsAmenityHotelStars.
  ///
  /// In en, this message translates to:
  /// **'Hotel 4 stars'**
  String get tripDetailsAmenityHotelStars;

  /// No description provided for @tripDetailsAmenityFoodBar.
  ///
  /// In en, this message translates to:
  /// **'Food bar'**
  String get tripDetailsAmenityFoodBar;

  /// No description provided for @tripDetailsAmenityBusTrip.
  ///
  /// In en, this message translates to:
  /// **'Bus trip'**
  String get tripDetailsAmenityBusTrip;

  /// No description provided for @tripDetailsAmenityTourGuide.
  ///
  /// In en, this message translates to:
  /// **'Tour guide'**
  String get tripDetailsAmenityTourGuide;

  /// No description provided for @tripDetailsAccommodationTitle.
  ///
  /// In en, this message translates to:
  /// **'Accommodation'**
  String get tripDetailsAccommodationTitle;

  /// No description provided for @tripDetailsAccommodationHotelNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Hotel Name'**
  String get tripDetailsAccommodationHotelNameLabel;

  /// No description provided for @tripDetailsHotelName.
  ///
  /// In en, this message translates to:
  /// **'Le Meridien Dahab Resort'**
  String get tripDetailsHotelName;

  /// No description provided for @tripDetailsHotelRatingStars.
  ///
  /// In en, this message translates to:
  /// **'5.0'**
  String get tripDetailsHotelRatingStars;

  /// No description provided for @tripDetailsAccommodationHotelLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Hotel Location'**
  String get tripDetailsAccommodationHotelLocationLabel;

  /// No description provided for @tripDetailsHotelAddress.
  ///
  /// In en, this message translates to:
  /// **'Blue Hole Road, Dahab, Egypt'**
  String get tripDetailsHotelAddress;

  /// No description provided for @tripDetailsCheckInOut.
  ///
  /// In en, this message translates to:
  /// **'Check-in 2:00 PM · Check-out 11:00 AM'**
  String get tripDetailsCheckInOut;

  /// No description provided for @tripDetailsViewMap.
  ///
  /// In en, this message translates to:
  /// **'View map'**
  String get tripDetailsViewMap;

  /// No description provided for @tripDetailsSeeAllAccommodation.
  ///
  /// In en, this message translates to:
  /// **'See All Accommodation'**
  String get tripDetailsSeeAllAccommodation;

  /// No description provided for @tripDetailsViewFullItinerary.
  ///
  /// In en, this message translates to:
  /// **'View full itinerary'**
  String get tripDetailsViewFullItinerary;

  /// No description provided for @tripDetailsFlightDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Flight details'**
  String get tripDetailsFlightDetailsTitle;

  /// No description provided for @tripDetailsTransportationTitle.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get tripDetailsTransportationTitle;

  /// No description provided for @tripDetailsFlightLegSummary.
  ///
  /// In en, this message translates to:
  /// **'CAI → SSH · EgyptAir · 1h 10m'**
  String get tripDetailsFlightLegSummary;

  /// No description provided for @tripDetailsTrainLegSummary.
  ///
  /// In en, this message translates to:
  /// **'Return · Cairo · 8h 30m'**
  String get tripDetailsTrainLegSummary;

  /// No description provided for @tripDetailsDestinationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Destinations'**
  String get tripDetailsDestinationsTitle;

  /// No description provided for @tripDetailsDestinationDahab.
  ///
  /// In en, this message translates to:
  /// **'Dahab'**
  String get tripDetailsDestinationDahab;

  /// No description provided for @tripDetailsDestinationNuweiba.
  ///
  /// In en, this message translates to:
  /// **'Nuweiba'**
  String get tripDetailsDestinationNuweiba;

  /// No description provided for @tripDetailsDestinationDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Destination Details'**
  String get tripDetailsDestinationDetailsTitle;

  /// No description provided for @tripDetailsDestinationVisaLabel.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get tripDetailsDestinationVisaLabel;

  /// No description provided for @tripDetailsDestinationVisaValue.
  ///
  /// In en, this message translates to:
  /// **'Visa required'**
  String get tripDetailsDestinationVisaValue;

  /// No description provided for @tripDetailsDestinationRequiredVaccinesLabel.
  ///
  /// In en, this message translates to:
  /// **'Required Vaccines'**
  String get tripDetailsDestinationRequiredVaccinesLabel;

  /// No description provided for @tripDetailsDestinationRequiredVaccinesValue.
  ///
  /// In en, this message translates to:
  /// **'+201026329736'**
  String get tripDetailsDestinationRequiredVaccinesValue;

  /// No description provided for @tripDetailsDestinationTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get tripDetailsDestinationTimeLabel;

  /// No description provided for @tripDetailsDestinationTimeValue.
  ///
  /// In en, this message translates to:
  /// **'GMT+1'**
  String get tripDetailsDestinationTimeValue;

  /// No description provided for @tripDetailsDestinationLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get tripDetailsDestinationLanguageLabel;

  /// No description provided for @tripDetailsDestinationLanguageValue.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get tripDetailsDestinationLanguageValue;

  /// No description provided for @tripDetailsDestinationCurrencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get tripDetailsDestinationCurrencyLabel;

  /// No description provided for @tripDetailsDestinationCurrencyValue.
  ///
  /// In en, this message translates to:
  /// **'Euro (EUR)'**
  String get tripDetailsDestinationCurrencyValue;

  /// No description provided for @tripDetailsDestinationTemperatureLabel.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get tripDetailsDestinationTemperatureLabel;

  /// No description provided for @tripDetailsDestinationTemperatureValue.
  ///
  /// In en, this message translates to:
  /// **'25°C'**
  String get tripDetailsDestinationTemperatureValue;

  /// No description provided for @tripDetailsDestinationPublicTransportationLabel.
  ///
  /// In en, this message translates to:
  /// **'Public Transportation'**
  String get tripDetailsDestinationPublicTransportationLabel;

  /// No description provided for @tripDetailsDestinationPublicTransportationValue.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get tripDetailsDestinationPublicTransportationValue;

  /// No description provided for @tripDetailsDestinationTaxiAppsLabel.
  ///
  /// In en, this message translates to:
  /// **'Taxi Apps'**
  String get tripDetailsDestinationTaxiAppsLabel;

  /// No description provided for @tripDetailsDestinationTaxiAppsValue.
  ///
  /// In en, this message translates to:
  /// **'Uber, InDrive'**
  String get tripDetailsDestinationTaxiAppsValue;

  /// No description provided for @tripDetailsIncludesExcludesTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip includes & excludes'**
  String get tripDetailsIncludesExcludesTitle;

  /// No description provided for @tripDetailsExcludesTitle.
  ///
  /// In en, this message translates to:
  /// **'Excludes'**
  String get tripDetailsExcludesTitle;

  /// No description provided for @tripDetailsExcludeVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa fees'**
  String get tripDetailsExcludeVisa;

  /// No description provided for @tripDetailsExcludeAlcohol.
  ///
  /// In en, this message translates to:
  /// **'Alcoholic beverages'**
  String get tripDetailsExcludeAlcohol;

  /// No description provided for @tripDetailsSeeAllPhotos.
  ///
  /// In en, this message translates to:
  /// **'See all photos'**
  String get tripDetailsSeeAllPhotos;

  /// No description provided for @tripDetailsActivityPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity plans'**
  String get tripDetailsActivityPlansTitle;

  /// No description provided for @tripDetailsActivitySnorkel.
  ///
  /// In en, this message translates to:
  /// **'Blue Hole snorkeling'**
  String get tripDetailsActivitySnorkel;

  /// No description provided for @tripDetailsActivitySnorkelPrice.
  ///
  /// In en, this message translates to:
  /// **'EGP 500'**
  String get tripDetailsActivitySnorkelPrice;

  /// No description provided for @tripDetailsActivitySafari.
  ///
  /// In en, this message translates to:
  /// **'Desert safari'**
  String get tripDetailsActivitySafari;

  /// No description provided for @tripDetailsActivitySafariPrice.
  ///
  /// In en, this message translates to:
  /// **'EGP 350'**
  String get tripDetailsActivitySafariPrice;

  /// No description provided for @tripDetailsActivityDiving.
  ///
  /// In en, this message translates to:
  /// **'Intro diving session'**
  String get tripDetailsActivityDiving;

  /// No description provided for @tripDetailsActivityDivingPrice.
  ///
  /// In en, this message translates to:
  /// **'EGP 800'**
  String get tripDetailsActivityDivingPrice;

  /// No description provided for @tripDetailsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get tripDetailsAdd;

  /// No description provided for @tripDetailsAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get tripDetailsAdded;

  /// No description provided for @tripDetailsViewAllActivities.
  ///
  /// In en, this message translates to:
  /// **'View all activities'**
  String get tripDetailsViewAllActivities;

  /// No description provided for @tripDetailsActivityRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity Rate'**
  String get tripDetailsActivityRateTitle;

  /// No description provided for @tripDetailsActivityRateLuxury.
  ///
  /// In en, this message translates to:
  /// **'level of luxury'**
  String get tripDetailsActivityRateLuxury;

  /// No description provided for @tripDetailsActivityRateShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get tripDetailsActivityRateShopping;

  /// No description provided for @tripDetailsActivityRateNightOutings.
  ///
  /// In en, this message translates to:
  /// **'Night outings'**
  String get tripDetailsActivityRateNightOutings;

  /// No description provided for @tripDetailsSeeAllActivities.
  ///
  /// In en, this message translates to:
  /// **'See All Activities'**
  String get tripDetailsSeeAllActivities;

  /// No description provided for @tripDetailsVisaDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Visa Details'**
  String get tripDetailsVisaDetailsTitle;

  /// No description provided for @tripDetailsTripInstructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Instructions'**
  String get tripDetailsTripInstructionsTitle;

  /// No description provided for @tripDetailsSafetyProceduresTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety Procedures'**
  String get tripDetailsSafetyProceduresTitle;

  /// No description provided for @tripDetailsCompanySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get tripDetailsCompanySectionTitle;

  /// No description provided for @tripDetailsViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get tripDetailsViewAll;

  /// No description provided for @tripDetailsReviewCountry.
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get tripDetailsReviewCountry;

  /// No description provided for @tripDetailsCompanyRatingValue.
  ///
  /// In en, this message translates to:
  /// **'4.9'**
  String get tripDetailsCompanyRatingValue;

  /// No description provided for @tripDetailsCompanyRatingCount.
  ///
  /// In en, this message translates to:
  /// **'112'**
  String get tripDetailsCompanyRatingCount;

  /// No description provided for @tripDetailsPolicyCancellation.
  ///
  /// In en, this message translates to:
  /// **'Cancellation policy'**
  String get tripDetailsPolicyCancellation;

  /// No description provided for @tripDetailsPolicyInsurance.
  ///
  /// In en, this message translates to:
  /// **'Travel insurance'**
  String get tripDetailsPolicyInsurance;

  /// No description provided for @tripDetailsPolicyTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get tripDetailsPolicyTerms;

  /// No description provided for @tripDetailsPolicyFaqs.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get tripDetailsPolicyFaqs;

  /// No description provided for @tripDetailsSeeAllReviews.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get tripDetailsSeeAllReviews;

  /// No description provided for @tripDetailsOrganizerTitle.
  ///
  /// In en, this message translates to:
  /// **'Organizer'**
  String get tripDetailsOrganizerTitle;

  /// No description provided for @tripDetailsOrganizerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Trusted partner on Trip Marche'**
  String get tripDetailsOrganizerSubtitle;

  /// No description provided for @tripDetailsStartingFrom.
  ///
  /// In en, this message translates to:
  /// **'Starting from'**
  String get tripDetailsStartingFrom;

  /// No description provided for @tripDetailsBookingFromPrice.
  ///
  /// In en, this message translates to:
  /// **'EGP 5,000'**
  String get tripDetailsBookingFromPrice;

  /// No description provided for @tripDetailsItineraryLoc1.
  ///
  /// In en, this message translates to:
  /// **'Beijing'**
  String get tripDetailsItineraryLoc1;

  /// No description provided for @tripDetailsItineraryActs1.
  ///
  /// In en, this message translates to:
  /// **'• Check-in at hotel\n• City orientation walk\n• Welcome dinner'**
  String get tripDetailsItineraryActs1;

  /// No description provided for @tripDetailsItineraryLoc2.
  ///
  /// In en, this message translates to:
  /// **'Hangzhou'**
  String get tripDetailsItineraryLoc2;

  /// No description provided for @tripDetailsItineraryActs2.
  ///
  /// In en, this message translates to:
  /// **'• West Lake cruise\n• Tea plantation visit\n• Evening free time'**
  String get tripDetailsItineraryActs2;

  /// No description provided for @tripDetailsReviewSampleName.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Hassan'**
  String get tripDetailsReviewSampleName;

  /// No description provided for @tripDetailsReviewSampleDate.
  ///
  /// In en, this message translates to:
  /// **'Dec 2025'**
  String get tripDetailsReviewSampleDate;

  /// No description provided for @tripDetailsReviewSampleBody.
  ///
  /// In en, this message translates to:
  /// **'Amazing trip! Great organization and friendly guides. The snorkeling day was unforgettable.'**
  String get tripDetailsReviewSampleBody;

  /// No description provided for @bookingTripTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get bookingTripTermsTitle;

  /// No description provided for @bookingTripTermsHeader.
  ///
  /// In en, this message translates to:
  /// **'Trip Terms & Conditions'**
  String get bookingTripTermsHeader;

  /// No description provided for @bookingTripTermsLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String bookingTripTermsLastUpdated(Object date);

  /// No description provided for @bookingTripTermsSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Booking & Payment'**
  String get bookingTripTermsSection1Title;

  /// No description provided for @bookingTripTermsSection1Body.
  ///
  /// In en, this message translates to:
  /// **'By booking a trip through Trip Marche, you agree to the following terms. A deposit of 30% is required at the time of booking to secure your place. The remaining balance must be paid at least 14 days before the trip departure date. Failure to pay the remaining balance by the due date may result in cancellation of your booking. All payments are processed securely through our payment partners.'**
  String get bookingTripTermsSection1Body;

  /// No description provided for @bookingTripTermsSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Eligibility'**
  String get bookingTripTermsSection2Title;

  /// No description provided for @bookingTripTermsSection2Body.
  ///
  /// In en, this message translates to:
  /// **'Participants must be at least 18 years of age to book independently. Travelers under 18 must be accompanied by a parent or legal guardian. Certain activities may have additional age or health requirements. It is the responsibility of the traveler to ensure they meet all eligibility criteria and have the necessary travel documents.'**
  String get bookingTripTermsSection2Body;

  /// No description provided for @bookingTripTermsSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Trip Modifications'**
  String get bookingTripTermsSection3Title;

  /// No description provided for @bookingTripTermsSection3Body.
  ///
  /// In en, this message translates to:
  /// **'Trip Marche reserves the right to modify the trip itinerary due to weather conditions, safety concerns, or other unforeseen circumstances. We will make every effort to provide equivalent alternatives. In the event of significant changes, travelers will be notified as soon as possible and may be offered a partial refund or credit.'**
  String get bookingTripTermsSection3Body;

  /// No description provided for @bookingTripTermsSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Traveler Responsibilities'**
  String get bookingTripTermsSection4Title;

  /// No description provided for @bookingTripTermsSection4Body.
  ///
  /// In en, this message translates to:
  /// **'Travelers are responsible for ensuring they have valid travel documents, appropriate travel insurance, and any required vaccinations. Travelers must follow the instructions of trip guides and respect local laws and customs. Trip Marche is not liable for any consequences resulting from a traveler\'s failure to comply with entry requirements.'**
  String get bookingTripTermsSection4Body;

  /// No description provided for @bookingTripTermsSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Liability'**
  String get bookingTripTermsSection5Title;

  /// No description provided for @bookingTripTermsSection5Body.
  ///
  /// In en, this message translates to:
  /// **'Trip Marche acts as an organizer and intermediary. While we take every precaution to ensure safety, we are not liable for any loss, injury, or damage arising from activities during the trip, acts of nature, or the actions of third-party service providers. Travelers participate in all activities at their own risk. We strongly recommend purchasing comprehensive travel insurance.'**
  String get bookingTripTermsSection5Body;

  /// No description provided for @bookingTripTermsSection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Privacy'**
  String get bookingTripTermsSection6Title;

  /// No description provided for @bookingTripTermsSection6Body.
  ///
  /// In en, this message translates to:
  /// **'Personal information collected during the booking process is used solely for trip organization and communication purposes. We do not share your information with third parties except as necessary to fulfill your booking. For more details, please refer to our Privacy Policy.'**
  String get bookingTripTermsSection6Body;

  /// No description provided for @bookingTripTermsSection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Dispute Resolution'**
  String get bookingTripTermsSection7Title;

  /// No description provided for @bookingTripTermsSection7Body.
  ///
  /// In en, this message translates to:
  /// **'Any disputes arising from these terms shall be resolved through amicable negotiation. If a resolution cannot be reached, disputes shall be submitted to the competent courts. These terms are governed by the laws of the Arab Republic of Egypt.'**
  String get bookingTripTermsSection7Body;

  /// No description provided for @bookingTripInstructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Instructions'**
  String get bookingTripInstructionsTitle;

  /// No description provided for @bookingTripInstructionsHeader.
  ///
  /// In en, this message translates to:
  /// **'Before You Go'**
  String get bookingTripInstructionsHeader;

  /// No description provided for @bookingTripInstructionsIntro.
  ///
  /// In en, this message translates to:
  /// **'Please read the following instructions carefully to ensure a smooth and enjoyable trip experience. Proper preparation will help you make the most of your Dahab adventure.'**
  String get bookingTripInstructionsIntro;

  /// No description provided for @bookingTripInstructionsWhatToPack.
  ///
  /// In en, this message translates to:
  /// **'What to Pack'**
  String get bookingTripInstructionsWhatToPack;

  /// No description provided for @bookingTripInstructionsMeetingPointTime.
  ///
  /// In en, this message translates to:
  /// **'Meeting Point & Time'**
  String get bookingTripInstructionsMeetingPointTime;

  /// No description provided for @bookingTripInstructionsDocumentsToBring.
  ///
  /// In en, this message translates to:
  /// **'Documents to Bring'**
  String get bookingTripInstructionsDocumentsToBring;

  /// No description provided for @bookingTripInstructionsImportantReminders.
  ///
  /// In en, this message translates to:
  /// **'Important Reminders'**
  String get bookingTripInstructionsImportantReminders;

  /// No description provided for @bookingTripSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Safety'**
  String get bookingTripSafetyTitle;

  /// No description provided for @bookingTripSafetyBanner.
  ///
  /// In en, this message translates to:
  /// **'Your safety is our top priority. Please read the following guidelines carefully.'**
  String get bookingTripSafetyBanner;

  /// No description provided for @bookingTripSafetyHeader.
  ///
  /// In en, this message translates to:
  /// **'Safety Procedures'**
  String get bookingTripSafetyHeader;

  /// No description provided for @bookingTripSafetyIntro.
  ///
  /// In en, this message translates to:
  /// **'At Trip Marche, we are committed to ensuring the safety and well-being of all our travelers. Our trips are designed with comprehensive safety measures and all our guides are trained in first aid and emergency procedures.'**
  String get bookingTripSafetyIntro;

  /// No description provided for @bookingTripSafetyWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Water Activities Safety'**
  String get bookingTripSafetyWaterTitle;

  /// No description provided for @bookingTripSafetyDesertTitle.
  ///
  /// In en, this message translates to:
  /// **'Desert Safety'**
  String get bookingTripSafetyDesertTitle;

  /// No description provided for @bookingTripSafetyHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'Health & Medical'**
  String get bookingTripSafetyHealthTitle;

  /// No description provided for @bookingTripSafetyEmergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get bookingTripSafetyEmergencyTitle;

  /// No description provided for @bookingTripSafetyGeneralTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'General Safety Tips'**
  String get bookingTripSafetyGeneralTipsTitle;

  /// No description provided for @authResetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get authResetPasswordTitle;

  /// No description provided for @authResetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password below'**
  String get authResetPasswordSubtitle;

  /// No description provided for @authNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get authNewPasswordLabel;

  /// No description provided for @authNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get authNewPasswordHint;

  /// No description provided for @authConfirmNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get authConfirmNewPasswordLabel;

  /// No description provided for @authConfirmNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get authConfirmNewPasswordHint;

  /// No description provided for @authResetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get authResetPasswordButton;

  /// No description provided for @tripDetailsDurationUnit.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get tripDetailsDurationUnit;

  /// No description provided for @tripDetailsProgramDayPrefix.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get tripDetailsProgramDayPrefix;

  /// No description provided for @tripDetailsTypeDomestic.
  ///
  /// In en, this message translates to:
  /// **'Domestic'**
  String get tripDetailsTypeDomestic;

  /// No description provided for @tripDetailsPayOnArrival.
  ///
  /// In en, this message translates to:
  /// **'Pay on arrival'**
  String get tripDetailsPayOnArrival;

  /// No description provided for @tripDetailsFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load trip details.'**
  String get tripDetailsFailedToLoad;

  /// No description provided for @tripDetailsTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tripDetailsTryAgain;

  /// No description provided for @tripDetailsNoFlights.
  ///
  /// In en, this message translates to:
  /// **'Flight details will appear here when available.'**
  String get tripDetailsNoFlights;

  /// No description provided for @tripDetailsNoTransport.
  ///
  /// In en, this message translates to:
  /// **'Ground or sea transport details will appear here when available.'**
  String get tripDetailsNoTransport;

  /// No description provided for @tripDetailsVisaAndEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Visa and entry'**
  String get tripDetailsVisaAndEntryTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'it',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
