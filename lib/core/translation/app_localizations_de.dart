// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get errorFieldRequired => 'Dieses Feld ist erforderlich';

  @override
  String get errorInvalidName => 'Ungültiges Namensformat';

  @override
  String get errorInvalidUrl => 'Ungültige URL';

  @override
  String get errorInvalidPhoneNumber => 'Ungültige Telefonnummer';

  @override
  String get errorInvalidEmail => 'Ungültige E-Mail-Adresse';

  @override
  String get errorInvalidPassword =>
      'Das Passwort muss mindestens 8 Zeichen lang sein und Groß-/Kleinbuchstaben sowie Sonderzeichen enthalten';

  @override
  String get errorPasswordMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get errorInvalidNumber => 'Ungültige Nummer';

  @override
  String get errorInvalidIban => 'Ungültiges IBAN-Format';

  @override
  String get errorInvalidMobileNumber => 'Ungültige Mobilnummer';

  @override
  String get errorInvalidStcPayId => 'Ungültige STC Pay-ID';

  @override
  String get errorInvalidNationalId => 'Ungültige nationale ID';

  @override
  String get errorInvalidPassport => 'Ungültige Passnummer';

  @override
  String get sorryMessage => 'Es tut uns leid';

  @override
  String get nothingFound => 'Nichts gefunden';

  @override
  String errorPhoneValidation(Object length, Object start) {
    return 'Die Telefonnummer muss mit $start beginnen und $length Ziffern lang sein.';
  }

  @override
  String get errorExperienceRequired =>
      'Du musst mindestens eine Erfahrung hinzufügen.';

  @override
  String get errorIdDocumentRequired =>
      'Du musst ein Ausweisdokument hochladen, um deine Identität zu verifizieren.';

  @override
  String get errorPhotoRequired =>
      'Du musst ein Foto mit weißem Hintergrund hochladen';

  @override
  String get updateAvailableTitle => 'Update verfügbar';

  @override
  String get updateMandatoryMessage =>
      'Eine neue Version der App ist verfügbar. Bitte aktualisiere, um die App weiterhin zu nutzen.';

  @override
  String get updateOptionalMessage =>
      'Eine neue Version der App ist verfügbar. Wir empfehlen ein Update für die beste Erfahrung.';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get skip => 'Überspringen';

  @override
  String get chooseImage => 'Hochladen: Bild auswählen';

  @override
  String get takePicture => 'Hochladen: Foto aufnehmen';

  @override
  String get chooseFromFiles => 'Hochladen: Aus Dateien wählen';

  @override
  String get updatePleaseUpdateToContinue =>
      'Bitte aktualisiere die App, um fortzufahren.';

  @override
  String get updateNewVersionAvailableShort =>
      'Eine neue Version ist verfügbar.';

  @override
  String get authLoginTitle => 'Melde dich in deinem Konto an';

  @override
  String get authEmailLabel => 'E-Mail';

  @override
  String get authEmailHint => 'Gib deine E-Mail ein';

  @override
  String get authPasswordLabel => 'Passwort';

  @override
  String get authPasswordHint => 'Gib dein Passwort ein';

  @override
  String get authForgotPassword => 'Passwort vergessen?';

  @override
  String get authLoginButton => 'Anmelden';

  @override
  String get authNoAccountPrompt => 'Du hast noch kein Konto? ';

  @override
  String get authCreateOne => 'Konto erstellen';

  @override
  String get authOrLoginWith => 'Oder anmelden mit';

  @override
  String get authContinueWithGoogle => 'Mit Google fortfahren';

  @override
  String get authContinueWithApple => 'Mit Apple fortfahren';

  @override
  String get authTravelAgencyPrompt => 'Reiseveranstalter oder Agentur? ';

  @override
  String get authJoinAsTripPartner => 'Als Anbieter beitreten';

  @override
  String get authPartnerPortalTitle => 'Partnerportal';

  @override
  String get authWebViewLoadFailed =>
      'Diese Seite konnte nicht geladen werden. Bitte Verbindung prüfen und erneut versuchen.';

  @override
  String get authWebViewRetry => 'Erneut versuchen';

  @override
  String get authSignUpTitle => 'Erstelle dein Konto';

  @override
  String get authSignUpSubtitle => 'Registriere dich, um zu starten';

  @override
  String get authFullNameLabel => 'Vollständiger Name';

  @override
  String get authFullNameHint => 'Gib deinen vollständigen Namen ein';

  @override
  String get authPhoneLabel => 'Telefonnummer';

  @override
  String get authPhoneHint => 'Gib deine Telefonnummer ein';

  @override
  String get authConfirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get authConfirmPasswordHint => 'Bestätige dein Passwort';

  @override
  String get authSignUpButton => 'Registrieren';

  @override
  String get authOrSignUpWith => 'Oder registrieren mit';

  @override
  String get authSocialGoogle => 'Google';

  @override
  String get authSocialApple => 'Apple';

  @override
  String get authHaveAccountPrompt => 'Du hast bereits ein Konto? ';

  @override
  String get authLoginAction => 'Anmelden';

  @override
  String get authForgotPasswordTitle => 'Passwort vergessen';

  @override
  String get authForgotPasswordDescription =>
      'Gib unten deine E-Mail-Adresse ein und wir senden dir einen Link zum Zurücksetzen deines Passworts.';

  @override
  String get authForgotPasswordSubtitle => 'Vergessen? Wir helfen dir.';

  @override
  String get authSendButton => 'Senden';

  @override
  String get authSendCodeButton => 'Code senden';

  @override
  String get authVerifyTitle => 'Verifiziere deine Nummer';

  @override
  String get authVerifyDescription =>
      'Wir haben dir einen OTP-Code an deine registrierte Nummer gesendet. Bitte gib den Code unten ein.';

  @override
  String get authVerifyButton => 'Verifizieren';

  @override
  String get authBack => 'Zurück';

  @override
  String get authResendCode => 'Code erneut senden';

  @override
  String get authVerifyEmailTitle => 'Verifiziere deine E-Mail';

  @override
  String get authVerifyEmailSubtitle =>
      'Wir senden dir einen 6-stelligen Code zur Verifizierung deiner Nummer';

  @override
  String get authVerificationCodeNotReceived =>
      'Verifizierungscode nicht erhalten?';

  @override
  String get authResendNow => 'Jetzt erneut senden';

  @override
  String get homeAppTitle => 'TripMarche';

  @override
  String get homeSearchHint => 'Nach einer Reise suchen';

  @override
  String homeSearchHintDestination(Object destination) {
    return 'Nach einer Reise nach $destination suchen';
  }

  @override
  String get homeLocationText => 'Kairo, Ägypten';

  @override
  String get homeTrendingDestinations => 'Trendziele';

  @override
  String get homeTrendingDestinationsSearchHint => 'Reiseziele suchen';

  @override
  String get homeViewAll => 'Alle anzeigen';

  @override
  String get homePopularTrips => 'Beliebte Reisen';

  @override
  String get homeSponsoredTrips => 'Gesponserte Reisen';

  @override
  String get homeDomesticTripsInEgypt => 'Inlandsreisen in Ägypten';

  @override
  String get homeInternationalTripsFromEgypt =>
      'Internationale Reisen ab Ägypten';

  @override
  String get homeRecommendedForYou => 'Für dich empfohlen';

  @override
  String get homeSpecialTrips => 'Spezielle Reisen';

  @override
  String get homeTopRated => 'Top bewertet';

  @override
  String get homeFromCairoAlexandria => 'Von Kairo & Alexandria';

  @override
  String get homeNewInTripMarche => 'Neu bei TripMarche';

  @override
  String get homePerPerson => 'Person';

  @override
  String get homeSeeAll => 'Alle ansehen';

  @override
  String get wishlistTitle => 'Wunschliste';

  @override
  String get wishlistSearchHint => 'Nach einer Reise suchen';

  @override
  String get wishlistSortBy => 'Sortieren nach';

  @override
  String get wishlistFilters => 'Filter';

  @override
  String get wishlistNewInTripMarche => 'Neu bei TripMarche';

  @override
  String get wishlistRecommended => 'Empfohlen';

  @override
  String get wishlistBestPrice => 'Bester Preis';

  @override
  String get wishlistEmptyTitle => 'Noch keine Reisen gespeichert';

  @override
  String get wishlistEmptyDescription =>
      'Tippe auf das Herzsymbol bei einer Reise,\num sie zur Wunschliste hinzuzufügen.';

  @override
  String get wishlistFiltersTitle => 'Filter';

  @override
  String get wishlistFiltersClearAll => 'Alles löschen';

  @override
  String get wishlistFiltersDestination => 'Reiseziel';

  @override
  String get wishlistFiltersSelectDestination => 'Auswählen';

  @override
  String get wishlistFiltersPriceRange => 'Preisspanne';

  @override
  String get wishlistFiltersTripType => 'Reisetyp';

  @override
  String get wishlistFiltersDomestic => 'Inland';

  @override
  String get wishlistFiltersInternational => 'International';

  @override
  String get wishlistFiltersDepartureCountry => 'Abreiseland';

  @override
  String get wishlistFiltersDepartureCity => 'Abreisestadt';

  @override
  String get wishlistFiltersSelectCountry => 'Auswählen';

  @override
  String get wishlistFiltersSelectCity => 'Auswählen';

  @override
  String get wishlistFiltersTripMonth => 'Reisemonat';

  @override
  String get wishlistFiltersSelectMonth => 'Auswählen';

  @override
  String get wishlistFiltersActions => 'Aktivitäten';

  @override
  String get wishlistFiltersSelectAction => 'Auswählen';

  @override
  String get wishlistFiltersTravelAgency => 'Reiseagentur';

  @override
  String get wishlistFiltersAgencyNameHint => 'Name der Reiseagentur';

  @override
  String get wishlistFiltersAgencyRating => 'Bewertung der Reiseagentur';

  @override
  String get wishlistFiltersOtherCountries => 'Andere Länder';

  @override
  String get wishlistFiltersOtherCities => 'Andere Städte';

  @override
  String get wishlistFiltersSelectCountries => 'Auswählen';

  @override
  String get wishlistFiltersSelectCities => 'Auswählen';

  @override
  String get wishlistFiltersNumberOfCities => 'Anzahl der Städte';

  @override
  String get wishlistFiltersNumberOfCountries => 'Anzahl der Länder';

  @override
  String get wishlistFiltersDuration => 'Dauer';

  @override
  String get wishlistFiltersDurationUpTo3 => 'Bis zu 3 Tage';

  @override
  String get wishlistFiltersDurationUpTo7 => 'Bis zu 7 Tage';

  @override
  String get wishlistFiltersDuration7Plus => '+7 Tage';

  @override
  String get wishlistFiltersGroupSize => 'Gruppengröße';

  @override
  String get wishlistFiltersGroupSizeSmall => 'Bis zu 10';

  @override
  String get wishlistFiltersGroupSizeUpTo20 => 'Bis zu 20';

  @override
  String get wishlistFiltersGroupSize20Plus => '20+';

  @override
  String get wishlistFiltersTripSeason => 'Reisesaison';

  @override
  String get wishlistFiltersSeasonSpring => 'Frühling';

  @override
  String get wishlistFiltersSeasonHajj => 'Hadsch';

  @override
  String get wishlistFiltersSeasonNewYear => 'Neujahr';

  @override
  String get wishlistFiltersTripFeatures => 'Reise-Features';

  @override
  String get wishlistFiltersFeatureIncludeFlight => 'Flug inklusive';

  @override
  String get wishlistFiltersFeatureIncludeHotel => 'Hotel inklusive';

  @override
  String get wishlistFiltersFeatureFreeMeal => 'Kostenlose Mahlzeit';

  @override
  String get wishlistFiltersFeatureVisaOnArrival => 'Visum bei Ankunft';

  @override
  String get wishlistFiltersTripRating => 'Reisebewertung';

  @override
  String get wishlistFiltersDiscountCode => 'Reise mit Rabattcode';

  @override
  String get wishlistFiltersFreeCancellation => 'Kostenlose Stornierung';

  @override
  String get filterSeeResults => 'Ergebnisse anzeigen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsNotificationSetting => 'Benachrichtigungseinstellungen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsCurrency => 'Währung';

  @override
  String get settingsEnglish => 'Englisch';

  @override
  String get settingsArabic => 'Arabisch';

  @override
  String get settingsDarkMode => 'Dunkelmodus';

  @override
  String settingsAppVersion(Object version) {
    return 'App-Version $version';
  }

  @override
  String get notificationSettingsTitle => 'Benachrichtigungseinstellungen';

  @override
  String get notificationSettingsIntro =>
      'Verwalte deine Benachrichtigungseinstellungen, um über neue Reisen, Angebote und Buchungsupdates informiert zu bleiben.';

  @override
  String get notificationSettingsBookingUpdatesTitle => 'Buchungsupdates';

  @override
  String get notificationSettingsBookingUpdatesSubtitle =>
      'Erhalte Echtzeit-Updates zu Reisebestätigungen, Stornierungen und Änderungen an deinen Buchungen.';

  @override
  String get notificationSettingsToursTitle => 'Touren';

  @override
  String get notificationSettingsToursSubtitle =>
      'Erhalte Benachrichtigungen, wenn neue Reisen oder Touren hinzugefügt werden, die zu deinen Interessen passen.';

  @override
  String get notificationSettingsReviewsTitle => 'Bewertungen';

  @override
  String get notificationSettingsReviewsSubtitle =>
      'Werde benachrichtigt, wenn jemand auf deine Bewertung antwortet oder wenn du eingeladen wirst, eine Reise zu bewerten, die du gemacht hast.';

  @override
  String get notificationSettingsPromotionsSubtitle =>
      'Erhalte Zugang zu speziellen Rabatten, zeitlich begrenzten Angeboten und saisonalen Aktionen.';

  @override
  String get notificationSettingsPush => 'Push-Benachrichtigungen';

  @override
  String get notificationSettingsEmail => 'E-Mail-Benachrichtigungen';

  @override
  String get notificationSettingsTripUpdates => 'Reise-Updates';

  @override
  String get notificationSettingsPromotions => 'Aktionen';

  @override
  String get notificationSettingsPriceAlerts => 'Preisalarme';

  @override
  String get profileTitleAccount => 'Konto';

  @override
  String get profileTitleSupport => 'Support';

  @override
  String get profilePersonalInfo => 'Persönliche Infos';

  @override
  String get profilePaymentMethod => 'Zahlungsmethode';

  @override
  String get profileMyReviews => 'Meine Bewertungen';

  @override
  String get profileAddReview => 'Bewertung hinzufügen';

  @override
  String get profileReviewLabel => 'Bewertung';

  @override
  String get profileProductRatingLabel => 'Produktbewertung';

  @override
  String get profileMyReviewsRoute => 'Kairo → Dahab';

  @override
  String get profileFollowingCompanies => 'Gefolgte Unternehmen';

  @override
  String get profileSettings => 'Einstellungen';

  @override
  String get profileCustomerService => 'Kundenservice';

  @override
  String get profileFaqs => 'FAQs';

  @override
  String get profileTermsAndConditions => 'Allgemeine Geschäftsbedingungen';

  @override
  String get profileDeleteAccount => 'Konto löschen';

  @override
  String get profileLogout => 'Abmelden';

  @override
  String profileTripsBooked(Object count) {
    return '$count Reisen gebucht';
  }

  @override
  String get profileDeleteAccountTitle => 'Konto löschen';

  @override
  String get profileDeleteAccountMessage =>
      'Möchtest du dein Konto wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get profileLogoutConfirmTitle => 'Abmelden';

  @override
  String get profileLogoutConfirmMessage =>
      'Möchtest du dich wirklich abmelden?';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonOk => 'OK';

  @override
  String get followingsTitle => 'Meine Abonnements';

  @override
  String followingsCountTitle(Object count) {
    return '$count abonniert';
  }

  @override
  String get followingsUnfollow => 'Entfolgen';

  @override
  String get followingsEmptyTitle => 'Noch keine Abonnements';

  @override
  String get followingsEmptyDescription =>
      'Folge Unternehmen, um\nihre Reisen hier zu sehen.';

  @override
  String get myTripsTitle => 'Meine Reisen';

  @override
  String get myTripsTabUpcoming => 'Bevorstehend';

  @override
  String get myTripsTabPast => 'Vergangen';

  @override
  String get myTripsSearchHint => 'Nach einer Reise suchen';

  @override
  String get myTripsCatalogTripsOf => 'Reisen in';

  @override
  String myTripsCatalogReviewCountInline(int count) {
    return '($count)';
  }

  @override
  String get myTripsCatalogSaveWishlist => 'Zur Merkliste hinzufügen';

  @override
  String get myTripsCatalogRemoveWishlist => 'Von der Merkliste entfernen';

  @override
  String get myTripsTabActive => 'Aktiv';

  @override
  String get myTripsTabPastNew => 'Vergangen';

  @override
  String get myTripsTabCanceled => 'Storniert';

  @override
  String get myTripsStatusActive => 'Aktiv';

  @override
  String get myTripsStatusPast => 'Vergangen';

  @override
  String get myTripsStatusCanceled => 'Storniert';

  @override
  String get myTripsBookAgain => 'Erneut buchen';

  @override
  String get myTripsFromPrefix => 'Ab';

  @override
  String get myTripsViewDetails => 'Details ansehen';

  @override
  String get myTripsViewReceipt => 'Beleg ansehen';

  @override
  String get myTripsBookingDetails => 'Buchungsdetails';

  @override
  String get myTripsDownloadPdf => 'PDF herunterladen';

  @override
  String get myTripsEmptyTitle => 'Noch keine Reisen';

  @override
  String get myTripsEmptyDescription =>
      'Entdecke Reisen und buche\ndein erstes Abenteuer!';

  @override
  String get myTripsExploreTrips => 'Reisen entdecken';

  @override
  String get navHome => 'Start';

  @override
  String get navTrips => 'Reisen';

  @override
  String get navWishlist => 'Wunschliste';

  @override
  String get navAccount => 'Konto';

  @override
  String get bookingContactInfoTitle => 'Kontaktinformationen';

  @override
  String get bookingContactFullNameLabel => 'Vollständiger Name';

  @override
  String get bookingContactFullNameHint => 'Gib deinen vollständigen Namen ein';

  @override
  String get bookingContactPhoneLabel => 'Telefonnummer';

  @override
  String get bookingContactPhoneHint => '+20 123 456 7890';

  @override
  String get bookingContactEmailLabel => 'E-Mail';

  @override
  String get bookingContactEmailHint => 'email@example.com';

  @override
  String get bookingContactEmergencyLabel => 'Notfallkontakt';

  @override
  String get bookingContactEmergencyHint => 'Notfallkontakt-Nummer';

  @override
  String get bookingContactIdPassportLabel => 'ID-/Passnummer';

  @override
  String get bookingContactIdPassportHint =>
      'Gib deine ID- oder Passnummer ein';

  @override
  String get bookingContinue => 'Weiter';

  @override
  String get bookingAddNewCardTitle => 'Neue Karte hinzufügen';

  @override
  String get bookingCardNumberLabel => 'Kartennummer';

  @override
  String get bookingCardNumberHint => '0000 0000 0000 0000';

  @override
  String get bookingCardholderNameLabel => 'Karteninhaber';

  @override
  String get bookingCardholderNameHint => 'John Doe';

  @override
  String get bookingExpiryDateLabel => 'Ablaufdatum';

  @override
  String get bookingExpiryDateHint => 'MM/JJ';

  @override
  String get bookingCvvLabel => 'CVV';

  @override
  String get bookingCvvHint => '***';

  @override
  String get bookingSaveCard => 'Karte speichern';

  @override
  String get bookingCardholderNamePlaceholder => 'KARTENINHABER';

  @override
  String get bookingPaymentMethodTitle => 'Zahlungsmethode';

  @override
  String get bookingPaymentOptionCreditCard => 'Kreditkarte';

  @override
  String get bookingPaymentOptionCreditCardSubtitle =>
      'Bezahlen mit Visa, Mastercard';

  @override
  String get bookingPaymentOptionPaypal => 'PayPal';

  @override
  String get bookingPaymentOptionPaypalSubtitle =>
      'Bezahlen mit deinem PayPal-Konto';

  @override
  String get bookingPaymentOptionApplePay => 'Apple Pay';

  @override
  String get bookingPaymentOptionApplePaySubtitle => 'Bezahlen mit Apple Pay';

  @override
  String get bookingSavedCards => 'Gespeicherte Karten';

  @override
  String get bookingAddNewCard => 'Neue Karte hinzufügen';

  @override
  String bookingPayNow(Object amount) {
    return 'Jetzt bezahlen – $amount';
  }

  @override
  String bookingCardExpires(Object expiry) {
    return 'Läuft ab $expiry';
  }

  @override
  String get profilePersonalInfoTitle => 'Persönliche Infos';

  @override
  String get profileFullNameLabel => 'Vollständiger Name';

  @override
  String get profileEmailLabel => 'E-Mail';

  @override
  String get profilePhoneNumberLabel => 'Telefonnummer';

  @override
  String get profilePasswordLabel => 'Passwort';

  @override
  String get profileCountryLabel => 'Land';

  @override
  String get profileCityLabel => 'Stadt';

  @override
  String get profileEditAction => 'Bearbeiten';

  @override
  String get profileChangePasswordAction => 'Passwort ändern';

  @override
  String get profileGender => 'Geschlecht';

  @override
  String get profileGenderMale => 'Männlich';

  @override
  String get profileGenderFemale => 'Weiblich';

  @override
  String get profileDateOfBirth => 'Geburtsdatum';

  @override
  String get profileSaveChanges => 'Änderungen speichern';

  @override
  String get companyProfileCompanyName => 'Travel Egypt Co.';

  @override
  String companyProfileReviewsCountShort(Object count) {
    return '($count Bewertungen)';
  }

  @override
  String get companyProfileFollowing => 'Folge ich';

  @override
  String get companyProfileFollow => 'Folgen';

  @override
  String get companyProfileStatsTrips => 'Reisen';

  @override
  String get companyProfileStatsReviews => 'Bewertungen';

  @override
  String get companyProfileStatsFollowers => 'Follower';

  @override
  String get companyProfileAbout => 'Über';

  @override
  String get companyProfileAboutDescription =>
      'Travel Egypt Co. ist ein führendes Reiseunternehmen, spezialisiert auf ägyptische Touren und Abenteuer. Wir bieten einzigartige Erlebnisse in ganz Ägypten – von den antiken Pyramiden bis zu den wunderschönen Red-Sea-Resorts.';

  @override
  String get companyProfileTrips => 'Reisen';

  @override
  String get companyProfileReviews => 'Bewertungen';

  @override
  String get companyProfileSeeAll => 'Alle ansehen';

  @override
  String get companyProfileTripName => 'Reisename';

  @override
  String get companyProfileReviewAuthor => 'John Doe';

  @override
  String get companyProfileReviewDate => 'vor 2 Tagen';

  @override
  String get companyProfileReviewComment =>
      'Tolle Erfahrung! Die Reise war sehr gut organisiert und der Guide war sehr professionell.';

  @override
  String get filterTitle => 'Filter';

  @override
  String get filterReset => 'Zurücksetzen';

  @override
  String get filterDuration => 'Dauer';

  @override
  String get filterTripType => 'Reisetyp';

  @override
  String get filterRating => 'Bewertung';

  @override
  String get filterDepartureCity => 'Abreisestadt';

  @override
  String get filterSelectCity => 'Stadt auswählen';

  @override
  String get filterApply => 'Anwenden';

  @override
  String get destinationTitle => 'Reiseziel';

  @override
  String get destinationSearchHint => 'Reiseziele suchen...';

  @override
  String get destinationRecentSearches => 'Letzte Suchanfragen';

  @override
  String get destinationClearAll => 'Alles löschen';

  @override
  String get destinationPopularDestinations => 'Beliebte Reiseziele';

  @override
  String searchTripsFound(Object count) {
    return '$count Reisen gefunden';
  }

  @override
  String get searchQueryExample => 'Sharm El Sheikh';

  @override
  String get searchResultTitle => 'Suchergebnisse';

  @override
  String get searchResultSearchHint => 'Nach einer Reise suchen';

  @override
  String get searchResultSortBy => 'Sortieren nach';

  @override
  String get searchResultFilters => 'Filter';

  @override
  String get searchResultRating => '4.9';

  @override
  String get searchResultReviews => '(112)';

  @override
  String get searchResultFromCity => 'Ab Kairo';

  @override
  String get searchResultDateFrom => '27 Nov';

  @override
  String get searchResultDateTo => '4 Dez';

  @override
  String get searchResultLabelNew => 'Neu bei TripMarche';

  @override
  String get searchResultLabelRecommended => 'Empfohlen';

  @override
  String get searchResultLabelBestPrice => 'Bester Preis';

  @override
  String get searchResultOldPrice => '\$1000';

  @override
  String get searchResultDiscountPrice => '\$699';

  @override
  String get searchResultPerPerson => '/Person';

  @override
  String get tripDetailsTitle => 'Dahab-Reise';

  @override
  String get tripDetailsHeroCountryTag => 'Indonesien';

  @override
  String get tripDetailsHeroByCompany => 'Von Reiseunternehmen';

  @override
  String get tripDetailsHeroFromLocation => 'Von Kairo & Alexandria';

  @override
  String get tripDetailsHeroDateRange => '27. Nov → 4. Dez';

  @override
  String get tripDetailsHeroFromPrefix => 'Von ';

  @override
  String tripDetailsHeroByCompanyLine(String company) {
    return 'Von $company';
  }

  @override
  String tripDetailsGalleryMoreCount(Object count) {
    return '+$count';
  }

  @override
  String imageGalleryPosition(int current, int total) {
    return '$current von $total';
  }

  @override
  String get tripDetailsOverviewTitle => 'Über diese Reise';

  @override
  String get tripDetailsOverviewBody =>
      'Erlebe die atemberaubende Schönheit der Schweizer Alpen auf diesem 7-tägigen Abenteuer. Besuche ikonische Ziele, genieße malerische Zugfahrten und tauche in die Schweizer Kultur ein. Perfekt für Naturliebhaber und Fotografie-Fans.';

  @override
  String get tripDetailsWhatsIncludedTitle => 'Inklusive';

  @override
  String get tripDetailsIncludedFlightTickets => 'Flugtickets';

  @override
  String get tripDetailsIncludedHotelStay => 'Hotelaufenthalt';

  @override
  String get tripDetailsIncludedBreakfast => 'Frühstück';

  @override
  String get tripDetailsIncludedAirportTransfer => 'Flughafentransfer';

  @override
  String get tripDetailsDepartureDetailsTitle => 'Abreisedetails';

  @override
  String get tripDetailsMeetingLocationLabel => 'Treffpunkt';

  @override
  String get tripDetailsMeetingLocationValue =>
      '18 El Tesen Road, New Cairo, Ägypten';

  @override
  String get tripDetailsReturnLocationLabel => 'Rückgabeort';

  @override
  String get tripDetailsReturnLocationValue => '54 Ramses, Downtown, Ägypten';

  @override
  String get tripDetailsMeetingTimeLabel => 'Treffzeit';

  @override
  String get tripDetailsMeetingTimeValue => '17:00';

  @override
  String get tripDetailsReturnTimeLabel => 'Rückkehrzeit';

  @override
  String get tripDetailsReturnTimeValue => '21:30';

  @override
  String get tripDetailsProgramTitle => 'Reiseprogramm';

  @override
  String get tripDetailsProgramMealsLabel => 'Mahlzeiten';

  @override
  String get tripDetailsProgramDay1 => 'Tag 1';

  @override
  String get tripDetailsProgramDay2 => 'Tag 2';

  @override
  String get tripDetailsProgramCity1 => 'Peking';

  @override
  String get tripDetailsProgramCity2 => 'Hangzhou';

  @override
  String get tripDetailsProgramDay1Item1 => 'Ankunft am Flughafen Changdu';

  @override
  String get tripDetailsProgramDay1Item2 => 'Inlandsflug nach Peking';

  @override
  String get tripDetailsProgramDay1Item3 => 'Hotel-Check-in';

  @override
  String get tripDetailsProgramDay1Item4 =>
      'Freie Tour in der Wangfujing-Straße';

  @override
  String get tripDetailsProgramDay2Item1 => 'Stadttour in Hangzhou';

  @override
  String get tripDetailsProgramDay2Item2 => 'Hotel-Check-in und Abendtour';

  @override
  String get tripDetailsProgramDay2Item3 =>
      'Besuch des Westsees per Kreuzfahrt';

  @override
  String get tripDetailsProgramSeeAll => 'Gesamtes Programm ansehen';

  @override
  String get tripDetailsAirlineLabel => 'Fluggesellschaft';

  @override
  String get tripDetailsAirlineName => 'Egyptair';

  @override
  String get tripDetailsFlightLeg1FromCity => 'Kairo';

  @override
  String get tripDetailsFlightLeg1FromTime => '05:00';

  @override
  String get tripDetailsFlightLeg1ToCity => 'Paris';

  @override
  String get tripDetailsFlightLeg1ToTime => '07:20';

  @override
  String get tripDetailsFlightLeg1Date => '28. April';

  @override
  String get tripDetailsFlightLeg2FromCity => 'Paris';

  @override
  String get tripDetailsFlightLeg2FromTime => '08:00';

  @override
  String get tripDetailsFlightLeg2ToCity => 'Kairo';

  @override
  String get tripDetailsFlightLeg2ToTime => '05:20';

  @override
  String get tripDetailsFlightLeg2Date => '4. Mai';

  @override
  String get tripDetailsTransportLeg1FromCity => 'Kairo';

  @override
  String get tripDetailsTransportLeg1FromTime => '08:00';

  @override
  String get tripDetailsTransportLeg1ToCity => 'Paris';

  @override
  String get tripDetailsTransportLeg1ToTime => '05:20';

  @override
  String get tripDetailsTransportLeg1CenterLabel => 'Bus';

  @override
  String get tripDetailsTransportLeg1Date => '29. Mai';

  @override
  String get tripDetailsTransportLeg2FromCity => 'Kairo';

  @override
  String get tripDetailsTransportLeg2FromTime => '08:00';

  @override
  String get tripDetailsTransportLeg2ToCity => 'Paris';

  @override
  String get tripDetailsTransportLeg2ToTime => '05:20';

  @override
  String get tripDetailsTransportLeg2CenterLabel => 'Boot';

  @override
  String get tripDetailsTransportLeg2Date => '29. Mai';

  @override
  String get tripDetailsDestinationHurghada => 'Hurghada';

  @override
  String get tripDetailsDestinationParis => 'Paris';

  @override
  String get tripDetailsStatCitiesLabel => 'Anzahl der Städte';

  @override
  String get tripDetailsStatCitiesValue => '7 Städte';

  @override
  String tripDetailsStatCitiesCount(int count) {
    return '$count Städte';
  }

  @override
  String get tripDetailsPriceLabel => 'Preis';

  @override
  String get tripDetailsPerPersonSmall => 'pro Person';

  @override
  String get tripDetailsBookingPriceDisplay => '1000,00';

  @override
  String get tripDetailsCompanyName => 'Travel Egypt Co.';

  @override
  String get tripDetailsCompanyTagline => 'Abenteuer-Reiseagentur';

  @override
  String get tripDetailsFollow => 'Folgen';

  @override
  String get tripDetailsDurationValue => '7 Tage';

  @override
  String get tripDetailsDurationLabel => 'Dauer';

  @override
  String get tripDetailsGroupSizeValue => '20–25';

  @override
  String get tripDetailsGroupSizeLabel => 'Gruppengröße';

  @override
  String get tripDetailsTypeValue => 'International';

  @override
  String get tripDetailsTypeLabel => 'Typ';

  @override
  String get tripDetailsPerPerson => '/Person';

  @override
  String get tripDetailsDescriptionTitle => 'Beschreibung';

  @override
  String get tripDetailsReadMore => ' Mehr lesen';

  @override
  String get tripDetailsShowLess => ' Weniger anzeigen';

  @override
  String get tripDetailsDescriptionBody =>
      'Erlebe den Zauber von Dahab, einer wunderschönen Küstenstadt an der Südostküste der Sinai-Halbinsel in Ägypten. Diese 7-tägige Reise umfasst Schnorcheln im Blue Hole, Wüstensafaris, Kamelritte und Besuche in alten Beduinendörfern. Genieße die atemberaubenden Korallenriffe, kristallklares Wasser und beeindruckende Berglandschaften. Unsere erfahrenen Guides sorgen für ein unvergessliches Abenteuer mit komfortablen Unterkünften und köstlicher lokaler Küche.';

  @override
  String get tripDetailsItineraryTitle => 'Reiseplan';

  @override
  String get tripDetailsIncludesTitle => 'Inklusive';

  @override
  String get tripDetailsIncludesHotel => 'Hotel';

  @override
  String get tripDetailsIncludesTransportation => 'Transport';

  @override
  String get tripDetailsIncludesMeals => 'Mahlzeiten';

  @override
  String get tripDetailsIncludesActivities => 'Aktivitäten';

  @override
  String get tripDetailsIncludesTourGuide => 'Reiseleiter';

  @override
  String get tripDetailsImagesTitle => 'Reisebilder';

  @override
  String get tripDetailsReviewsTitle => 'Bewertungen';

  @override
  String tripDetailsReviewsCount(Object count) {
    return '$count Bewertungen';
  }

  @override
  String get tripDetailsRelatedTripsTitle => 'Ähnliche Reisen';

  @override
  String get tripDetailsTotalPrice => 'Gesamtpreis';

  @override
  String get tripDetailsBookNow => 'Jetzt buchen';

  @override
  String tripDetailsPricePerPersonShort(Object price) {
    return '$price/Person';
  }

  @override
  String get tripDetailsDay1Title => 'Tag 1 – Ankunft & Check-in';

  @override
  String get tripDetailsDay1Desc =>
      'Ankunft in Dahab, Transfer zum Hotel, Willkommensdinner und Orientierungstreffen mit der Gruppe.';

  @override
  String get tripDetailsDay2Title => 'Tag 2 – Blue-Hole-Schnorcheln';

  @override
  String get tripDetailsDay2Desc =>
      'Ganztägiges Schnorcheln am berühmten Blue Hole. Mittagessen in einem Strandrestaurant. Abends freie Zeit.';

  @override
  String get tripDetailsDay3Title => 'Tag 3 – Wüstensafari';

  @override
  String get tripDetailsDay3Desc =>
      'Jeep-Safari durch die Sinai-Wüste. Besuch eines Beduinendorfs. Sternenhimmel-Dinner in der Wüste.';

  @override
  String get tripDetailsDay4Title => 'Tag 4 – Freier Tag & Aktivitäten';

  @override
  String get tripDetailsDay4Desc =>
      'Wähle aus optionalen Aktivitäten: Tauchen, Kamelritte oder erkunde die lokalen Märkte.';

  @override
  String get tripDetailsDay5Title => 'Tag 5 – Mount-Sinai-Wanderung';

  @override
  String get tripDetailsDay5Desc =>
      'Frühe Wanderung zum Mount Sinai zum Sonnenaufgang. Besuch des Katharinenklosters.';

  @override
  String get tripDetailsDay6Title => 'Tag 6 – Wassersport';

  @override
  String get tripDetailsDay6Desc =>
      'Windsurf- und Kitesurf-Unterricht. Abschiedsessen in einem Restaurant am Meer.';

  @override
  String get tripDetailsDay7Title => 'Tag 7 – Abreise';

  @override
  String get tripDetailsDay7Desc =>
      'Frühstück im Hotel. Check-out und Transfer zum Flughafen.';

  @override
  String get tripDetailsRelatedNameSharm => 'Sharm El Sheikh';

  @override
  String get tripDetailsRelatedNameHurghada => 'Hurghada-Reise';

  @override
  String get tripDetailsRelatedNameLuxorAswan => 'Luxor & Assuan';

  @override
  String get tripDetailsHeroRatingLine => '4,5 (120 Bewertungen)';

  @override
  String get tripDetailsHeroLocationShort => 'Dahab, Ägypten';

  @override
  String get tripDetailsHeroDaysBadge => '7 Tage';

  @override
  String get tripDetailsOut => 'Hin';

  @override
  String get tripDetailsIn => 'Zurück';

  @override
  String get tripDetailsOutSummaryLine1 => '21. Mai, Freitag';

  @override
  String get tripDetailsOutSummaryLine2 =>
      'Flughafen Kairo International (CAI)';

  @override
  String get tripDetailsInSummaryLine1 => '27. Mai, Donnerstag';

  @override
  String get tripDetailsInSummaryLine2 => 'Dahab, Süd-Sinai';

  @override
  String get tripDetailsTripDescriptionTitle => 'Reisebeschreibung';

  @override
  String get tripDetailsAmenitiesTitle => 'Ausstattung';

  @override
  String get tripDetailsAmenityHotelStars => 'Hotel 4 Sterne';

  @override
  String get tripDetailsAmenityFoodBar => 'Food-Bar';

  @override
  String get tripDetailsAmenityBusTrip => 'Busfahrt';

  @override
  String get tripDetailsAmenityTourGuide => 'Reiseleiter';

  @override
  String get tripDetailsAccommodationTitle => 'Wo du übernachtest';

  @override
  String get tripDetailsAccommodationHotelNameLabel => 'Hotelname';

  @override
  String get tripDetailsHotelName => 'Le Meridien Dahab Resort';

  @override
  String get tripDetailsHotelRatingStars => '5,0';

  @override
  String get tripDetailsAccommodationHotelLocationLabel => 'Hoteladresse';

  @override
  String get tripDetailsHotelAddress => 'Blue Hole Road, Dahab, Ägypten';

  @override
  String get tripDetailsCheckInOut => 'Check-in 14:00 · Check-out 11:00';

  @override
  String get tripDetailsViewMap => 'Karte ansehen';

  @override
  String get tripDetailsSeeAllAccommodation => 'Alle Unterkünfte ansehen';

  @override
  String get tripDetailsViewFullItinerary => 'Vollständigen Reiseplan ansehen';

  @override
  String get tripDetailsFlightDetailsTitle => 'Flugdetails';

  @override
  String get tripDetailsTransportationTitle => 'Transport';

  @override
  String get tripDetailsFlightLegSummary =>
      'CAI → SSH · EgyptAir · 1 Std. 10 Min.';

  @override
  String get tripDetailsTrainLegSummary => 'Rückfahrt · Kairo · 8 Std. 30 Min.';

  @override
  String get tripDetailsDestinationsTitle => 'Reise-Highlights';

  @override
  String get tripDetailsDestinationDahab => 'Dahab';

  @override
  String get tripDetailsDestinationNuweiba => 'Nuweiba';

  @override
  String get tripDetailsDestinationDetailsTitle => 'Zieldetails';

  @override
  String get tripDetailsDestinationVisaLabel => 'Visum';

  @override
  String get tripDetailsDestinationVisaValue => 'Visum erforderlich';

  @override
  String get tripDetailsDestinationRequiredVaccinesLabel =>
      'Erforderliche Impfungen';

  @override
  String get tripDetailsDestinationRequiredVaccinesValue => '+201026329736';

  @override
  String get tripDetailsDestinationTimeLabel => 'Zeit';

  @override
  String get tripDetailsDestinationTimeValue => 'GMT+1';

  @override
  String get tripDetailsDestinationLanguageLabel => 'Sprache';

  @override
  String get tripDetailsDestinationLanguageValue => 'Englisch';

  @override
  String get tripDetailsDestinationCurrencyLabel => 'Währung';

  @override
  String get tripDetailsDestinationCurrencyValue => 'Euro (EUR)';

  @override
  String get tripDetailsDestinationTemperatureLabel => 'Temperatur';

  @override
  String get tripDetailsDestinationTemperatureValue => '25°C';

  @override
  String get tripDetailsDestinationPublicTransportationLabel =>
      'Öffentliche Verkehrsmittel';

  @override
  String get tripDetailsDestinationPublicTransportationValue => 'Bus';

  @override
  String get tripDetailsDestinationTaxiAppsLabel => 'Taxi-Apps';

  @override
  String get tripDetailsDestinationTaxiAppsValue => 'Uber, InDrive';

  @override
  String get tripDetailsIncludesExcludesTitle => 'Inklusive & Exklusive';

  @override
  String get tripDetailsExcludesTitle => 'Nicht enthalten';

  @override
  String get tripDetailsExcludeVisa => 'Visagebühren';

  @override
  String get tripDetailsExcludeAlcohol => 'Alkoholische Getränke';

  @override
  String get tripDetailsSeeAllPhotos => 'Alle Fotos ansehen';

  @override
  String get tripDetailsActivityPlansTitle => 'Aktivitätspläne';

  @override
  String get tripDetailsActivitySnorkel => 'Blue-Hole-Schnorcheln';

  @override
  String get tripDetailsActivitySnorkelPrice => 'EGP 500';

  @override
  String get tripDetailsActivitySafari => 'Wüstensafari';

  @override
  String get tripDetailsActivitySafariPrice => 'EGP 350';

  @override
  String get tripDetailsActivityDiving => 'Einführungstauchen';

  @override
  String get tripDetailsActivityDivingPrice => 'EGP 800';

  @override
  String get tripDetailsAdd => 'Hinzufügen';

  @override
  String get tripDetailsAdded => 'Hinzugefügt';

  @override
  String get tripDetailsViewAllActivities => 'Alle Aktivitäten ansehen';

  @override
  String get tripDetailsActivityRateTitle => 'Aktivitätsbewertung';

  @override
  String get tripDetailsActivityRateLuxury => 'Luxuslevel';

  @override
  String get tripDetailsActivityRateShopping => 'Shopping';

  @override
  String get tripDetailsActivityRateNightOutings => 'Nachtleben';

  @override
  String get tripDetailsSeeAllActivities => 'Alle Aktivitäten ansehen';

  @override
  String get tripDetailsVisaDetailsTitle => 'Visadetails';

  @override
  String get tripDetailsTripInstructionsTitle => 'Reiserichtlinien';

  @override
  String get tripDetailsSafetyProceduresTitle => 'Sicherheitsrichtlinien';

  @override
  String get tripDetailsCompanySectionTitle => 'Reisepartner';

  @override
  String get tripDetailsViewAll => 'Alle ansehen';

  @override
  String get tripDetailsReviewCountry => 'Spanien';

  @override
  String get tripDetailsCompanyRatingValue => '4,9';

  @override
  String get tripDetailsCompanyRatingCount => '112';

  @override
  String get tripDetailsPolicyCancellation => 'Stornierungsbedingungen';

  @override
  String get tripDetailsPolicyInsurance => 'Reiseversicherung';

  @override
  String get tripDetailsPolicyTerms => 'Allgemeine Geschäftsbedingungen';

  @override
  String get tripDetailsPolicyFaqs => 'Häufig gestellte Fragen';

  @override
  String get tripDetailsSeeAllReviews => 'Alle ansehen';

  @override
  String get tripDetailsOrganizerTitle => 'Veranstalter';

  @override
  String get tripDetailsOrganizerSubtitle =>
      'Vertrauenswürdiger Partner bei Trip Marche';

  @override
  String get tripDetailsStartingFrom => 'Ab';

  @override
  String get tripDetailsBookingFromPrice => 'EGP 5.000';

  @override
  String get tripDetailsItineraryLoc1 => 'Peking';

  @override
  String get tripDetailsItineraryActs1 =>
      '• Hotel-Check-in\n• Stadtrundgang\n• Willkommensdinner';

  @override
  String get tripDetailsItineraryLoc2 => 'Hangzhou';

  @override
  String get tripDetailsItineraryActs2 =>
      '• Westsee-Kreuzfahrt\n• Teeplantagenbesuch\n• Freier Abend';

  @override
  String get tripDetailsReviewSampleName => 'Ahmed Hassan';

  @override
  String get tripDetailsReviewSampleDate => 'Dez 2025';

  @override
  String get tripDetailsReviewSampleBody =>
      'Tolle Reise! Super Organisation und freundliche Guides. Der Schnorcheltag war unvergesslich.';

  @override
  String get bookingTripTermsTitle => 'AGB';

  @override
  String get bookingTripTermsHeader => 'Reise-AGB';

  @override
  String bookingTripTermsLastUpdated(Object date) {
    return 'Zuletzt aktualisiert: $date';
  }

  @override
  String get bookingTripTermsSection1Title => '1. Buchung & Zahlung';

  @override
  String get bookingTripTermsSection1Body =>
      'Mit der Buchung einer Reise über Trip Marche stimmst du den folgenden Bedingungen zu. Eine Anzahlung von 30% ist zum Zeitpunkt der Buchung erforderlich, um deinen Platz zu sichern. Der Restbetrag muss spätestens 14 Tage vor Reisebeginn bezahlt werden. Bei Nichtzahlung kann deine Buchung storniert werden. Alle Zahlungen werden sicher über unsere Zahlungspartner abgewickelt.';

  @override
  String get bookingTripTermsSection2Title => '2. Teilnahmebedingungen';

  @override
  String get bookingTripTermsSection2Body =>
      'Teilnehmende müssen mindestens 18 Jahre alt sein, um selbstständig zu buchen. Reisende unter 18 Jahren müssen von einem Elternteil oder gesetzlichen Vertreter begleitet werden. Bestimmte Aktivitäten können zusätzliche Alters- oder Gesundheitsanforderungen haben. Es liegt in der Verantwortung des Reisenden, die Teilnahmebedingungen zu erfüllen und die notwendigen Reisedokumente bereitzuhalten.';

  @override
  String get bookingTripTermsSection3Title => '3. Reiseänderungen';

  @override
  String get bookingTripTermsSection3Body =>
      'Trip Marche behält sich das Recht vor, den Reiseplan aufgrund von Wetterbedingungen, Sicherheitsbedenken oder anderen unvorhersehbaren Umständen zu ändern. Wir bemühen uns, gleichwertige Alternativen bereitzustellen. Bei wesentlichen Änderungen werden Reisende so früh wie möglich informiert und können eine teilweise Rückerstattung oder Gutschrift erhalten.';

  @override
  String get bookingTripTermsSection4Title => '4. Pflichten der Reisenden';

  @override
  String get bookingTripTermsSection4Body =>
      'Reisende sind dafür verantwortlich, gültige Reisedokumente, eine geeignete Reiseversicherung und alle erforderlichen Impfungen zu besitzen. Reisende müssen den Anweisungen der Guides folgen und lokale Gesetze sowie Gepflogenheiten respektieren. Trip Marche haftet nicht für Konsequenzen, die aus der Nichteinhaltung von Einreisebestimmungen entstehen.';

  @override
  String get bookingTripTermsSection5Title => '5. Haftung';

  @override
  String get bookingTripTermsSection5Body =>
      'Trip Marche agiert als Organisator und Vermittler. Obwohl wir alle Vorsichtsmaßnahmen treffen, haften wir nicht für Verlust, Verletzung oder Schaden, der während der Reise durch Aktivitäten, Naturereignisse oder Handlungen von Drittanbietern entsteht. Reisende nehmen an Aktivitäten auf eigenes Risiko teil. Wir empfehlen dringend den Abschluss einer umfassenden Reiseversicherung.';

  @override
  String get bookingTripTermsSection6Title => '6. Datenschutz';

  @override
  String get bookingTripTermsSection6Body =>
      'Persönliche Informationen, die während des Buchungsprozesses erhoben werden, werden ausschließlich zur Reiseorganisation und Kommunikation verwendet. Wir teilen deine Informationen nicht mit Dritten, außer wenn dies zur Erfüllung deiner Buchung erforderlich ist. Weitere Details findest du in unserer Datenschutzrichtlinie.';

  @override
  String get bookingTripTermsSection7Title => '7. Streitbeilegung';

  @override
  String get bookingTripTermsSection7Body =>
      'Streitigkeiten, die aus diesen Bedingungen entstehen, werden durch gütliche Verhandlungen gelöst. Kann keine Einigung erzielt werden, werden Streitigkeiten den zuständigen Gerichten vorgelegt. Diese Bedingungen unterliegen den Gesetzen der Arabischen Republik Ägypten.';

  @override
  String get bookingTripInstructionsTitle => 'Reisehinweise';

  @override
  String get bookingTripInstructionsHeader => 'Vor der Reise';

  @override
  String get bookingTripInstructionsIntro =>
      'Bitte lies die folgenden Hinweise sorgfältig durch, um eine reibungslose und angenehme Reise zu gewährleisten. Gute Vorbereitung hilft dir, das Beste aus deinem Dahab-Abenteuer zu machen.';

  @override
  String get bookingTripInstructionsWhatToPack => 'Packliste';

  @override
  String get bookingTripInstructionsMeetingPointTime => 'Treffpunkt & Zeit';

  @override
  String get bookingTripInstructionsDocumentsToBring =>
      'Mitzubringende Dokumente';

  @override
  String get bookingTripInstructionsImportantReminders => 'Wichtige Hinweise';

  @override
  String get bookingTripSafetyTitle => 'Reisesicherheit';

  @override
  String get bookingTripSafetyBanner =>
      'Deine Sicherheit hat oberste Priorität. Bitte lies die folgenden Richtlinien sorgfältig durch.';

  @override
  String get bookingTripSafetyHeader => 'Sicherheitsmaßnahmen';

  @override
  String get bookingTripSafetyIntro =>
      'Bei Trip Marche setzen wir uns für die Sicherheit und das Wohlbefinden aller Reisenden ein. Unsere Reisen sind mit umfassenden Sicherheitsmaßnahmen geplant und alle Guides sind in Erster Hilfe und Notfallverfahren geschult.';

  @override
  String get bookingTripSafetyWaterTitle => 'Sicherheit bei Wasseraktivitäten';

  @override
  String get bookingTripSafetyDesertTitle => 'Wüstensicherheit';

  @override
  String get bookingTripSafetyHealthTitle => 'Gesundheit & Medizinisches';

  @override
  String get bookingTripSafetyEmergencyTitle => 'Notfallkontakte';

  @override
  String get bookingTripSafetyGeneralTipsTitle => 'Allgemeine Sicherheitstipps';

  @override
  String get authResetPasswordTitle => 'Passwort zurücksetzen';

  @override
  String get authResetPasswordSubtitle => 'Gib unten dein neues Passwort ein';

  @override
  String get authNewPasswordLabel => 'Neues Passwort';

  @override
  String get authNewPasswordHint => 'Neues Passwort eingeben';

  @override
  String get authConfirmNewPasswordLabel => 'Neues Passwort bestätigen';

  @override
  String get authConfirmNewPasswordHint => 'Neues Passwort bestätigen';

  @override
  String get authResetPasswordButton => 'Passwort zurücksetzen';

  @override
  String get tripDetailsDurationUnit => 'Tage';

  @override
  String get tripDetailsProgramDayPrefix => 'Tag';

  @override
  String get tripDetailsTypeDomestic => 'Inland';

  @override
  String get tripDetailsPayOnArrival => 'Zahlung bei Ankunft';

  @override
  String get tripDetailsFailedToLoad =>
      'Reisedetails konnten nicht geladen werden.';

  @override
  String get tripDetailsTryAgain => 'Erneut versuchen';

  @override
  String get tripDetailsNoFlights =>
      'Flugdetails erscheinen hier, sobald sie verfügbar sind.';

  @override
  String get tripDetailsNoTransport =>
      'Details zu Land- oder Seetransport erscheinen hier, sobald sie verfügbar sind.';

  @override
  String get tripDetailsVisaAndEntryTitle => 'Visum und Einreise';

  @override
  String get csLetsGetInTouch => 'Kontaktieren Sie uns';

  @override
  String get csCall => 'Anrufen';

  @override
  String get csSendMessage => 'Nachricht senden';

  @override
  String get csWhatsApp => 'WhatsApp';
}
