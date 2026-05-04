// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get errorFieldRequired => 'Questo campo è obbligatorio';

  @override
  String get errorInvalidName => 'Formato nome non valido';

  @override
  String get errorInvalidUrl => 'URL non valido';

  @override
  String get errorInvalidPhoneNumber => 'Numero di telefono non valido';

  @override
  String get errorInvalidEmail => 'Indirizzo email non valido';

  @override
  String get errorInvalidPassword =>
      'La password deve contenere almeno 8 caratteri con maiuscole, minuscole e caratteri speciali';

  @override
  String get errorPasswordMismatch => 'Le password non corrispondono';

  @override
  String get errorInvalidNumber => 'Numero non valido';

  @override
  String get errorInvalidIban => 'Formato IBAN non valido';

  @override
  String get errorInvalidMobileNumber => 'Numero di cellulare non valido';

  @override
  String get errorInvalidStcPayId => 'ID STC Pay non valido';

  @override
  String get errorInvalidNationalId => 'Documento nazionale non valido';

  @override
  String get errorInvalidPassport => 'Numero di passaporto non valido';

  @override
  String get sorryMessage => 'Ci dispiace';

  @override
  String get nothingFound => 'Nessun risultato';

  @override
  String errorPhoneValidation(Object length, Object start) {
    return 'Il numero di telefono deve iniziare con $start ed essere lungo $length cifre.';
  }

  @override
  String get errorExperienceRequired => 'Devi aggiungere almeno un’esperienza.';

  @override
  String get errorIdDocumentRequired =>
      'Devi caricare un documento d’identità per verificare la tua identità.';

  @override
  String get errorPhotoRequired => 'Devi caricare una foto con sfondo bianco';

  @override
  String get updateAvailableTitle => 'Aggiornamento disponibile';

  @override
  String get updateMandatoryMessage =>
      'È disponibile una nuova versione dell’app. Aggiorna per continuare a usare l’app.';

  @override
  String get updateOptionalMessage =>
      'È disponibile una nuova versione dell’app. Consigliamo di aggiornare per la migliore esperienza.';

  @override
  String get updateNow => 'Aggiorna ora';

  @override
  String get skip => 'Salta';

  @override
  String get chooseImage => 'Carica: scegli immagine';

  @override
  String get takePicture => 'Carica: scatta foto';

  @override
  String get chooseFromFiles => 'Carica: scegli dai file';

  @override
  String get updatePleaseUpdateToContinue => 'Aggiorna l’app per continuare.';

  @override
  String get updateNewVersionAvailableShort =>
      'È disponibile una nuova versione.';

  @override
  String get authLoginTitle => 'Accedi al tuo account';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'Inserisci la tua email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordHint => 'Inserisci la tua password';

  @override
  String get authForgotPassword => 'Hai dimenticato la password?';

  @override
  String get authLoginButton => 'Accedi';

  @override
  String get authNoAccountPrompt => 'Non hai un account? ';

  @override
  String get authCreateOne => 'Creane uno';

  @override
  String get authOrLoginWith => 'Oppure accedi con';

  @override
  String get authContinueWithGoogle => 'Continua con Google';

  @override
  String get authContinueWithApple => 'Continua con Apple';

  @override
  String get authTravelAgencyPrompt => 'Fornitore o agenzia di viaggi? ';

  @override
  String get authJoinAsTripPartner => 'Unisciti come fornitore';

  @override
  String get authPartnerPortalTitle => 'Portale partner';

  @override
  String get authWebViewLoadFailed =>
      'Impossibile caricare questa pagina. Controlla la connessione e riprova.';

  @override
  String get authWebViewRetry => 'Riprova';

  @override
  String get authSignUpTitle => 'Crea il tuo account';

  @override
  String get authSignUpSubtitle => 'Registrati per iniziare';

  @override
  String get authFullNameLabel => 'Nome completo';

  @override
  String get authFullNameHint => 'Inserisci il tuo nome completo';

  @override
  String get authPhoneLabel => 'Numero di telefono';

  @override
  String get authPhoneHint => 'Inserisci il tuo numero di telefono';

  @override
  String get authConfirmPasswordLabel => 'Conferma password';

  @override
  String get authConfirmPasswordHint => 'Conferma la tua password';

  @override
  String get authSignUpButton => 'Registrati';

  @override
  String get authOrSignUpWith => 'Oppure registrati con';

  @override
  String get authSocialGoogle => 'Google';

  @override
  String get authSocialApple => 'Apple';

  @override
  String get authHaveAccountPrompt => 'Hai già un account? ';

  @override
  String get authLoginAction => 'Accedi';

  @override
  String get authForgotPasswordTitle => 'Password dimenticata';

  @override
  String get authForgotPasswordDescription =>
      'Inserisci il tuo indirizzo email qui sotto e ti invieremo un link per reimpostare la password.';

  @override
  String get authForgotPasswordSubtitle => 'Dimenticata? Sistemiamo noi.';

  @override
  String get authSendButton => 'Invia';

  @override
  String get authSendCodeButton => 'Invia codice';

  @override
  String get authVerifyTitle => 'Verifica il tuo numero';

  @override
  String get authVerifyDescription =>
      'Abbiamo inviato un codice OTP al tuo numero registrato. Inserisci il codice qui sotto.';

  @override
  String get authVerifyButton => 'Verifica';

  @override
  String get authBack => 'Indietro';

  @override
  String get authResendCode => 'Reinvia codice';

  @override
  String get authVerifyEmailTitle => 'Verifica la tua email';

  @override
  String get authVerifyEmailSubtitle =>
      'Ti inviamo un codice a 6 cifre per verificare il tuo numero';

  @override
  String get authVerificationCodeNotReceived =>
      'Codice di verifica non ricevuto?';

  @override
  String get authResendNow => 'Reinvia ora';

  @override
  String get homeAppTitle => 'TripMarche';

  @override
  String get homeSearchHint => 'Cerca un viaggio';

  @override
  String get homeLocationText => 'Egitto, Il Cairo, New Cairo';

  @override
  String get homeTrendingDestinations => 'Destinazioni di tendenza';

  @override
  String get homePopularTrips => 'Viaggi popolari';

  @override
  String get homeSponsoredTrips => 'Viaggi sponsorizzati';

  @override
  String get homeDomesticTripsInEgypt => 'Viaggi nazionali in Egitto';

  @override
  String get homeInternationalTripsFromEgypt =>
      'Viaggi internazionali dall’Egitto';

  @override
  String get homeRecommendedForYou => 'Consigliati per te';

  @override
  String get homeSpecialTrips => 'Viaggi speciali';

  @override
  String get homeTopRated => 'Più votati';

  @override
  String get homeFromCairoAlexandria => 'Da Il Cairo & Alessandria';

  @override
  String get homeNewInTripMarche => 'Novità su TripMarche';

  @override
  String get homePerPerson => 'Persona';

  @override
  String get homeSeeAll => 'Vedi tutto';

  @override
  String get wishlistTitle => 'Preferiti';

  @override
  String get wishlistSearchHint => 'Cerca un viaggio';

  @override
  String get wishlistSortBy => 'Ordina per';

  @override
  String get wishlistFilters => 'Filtri';

  @override
  String get wishlistNewInTripMarche => 'Novità su TripMarche';

  @override
  String get wishlistRecommended => 'Consigliati';

  @override
  String get wishlistBestPrice => 'Miglior prezzo';

  @override
  String get wishlistEmptyTitle => 'Nessun viaggio salvato';

  @override
  String get wishlistEmptyDescription =>
      'Tocca l’icona del cuore su un viaggio per\nsalvarlo nei preferiti.';

  @override
  String get wishlistFiltersTitle => 'Filtri';

  @override
  String get wishlistFiltersClearAll => 'Cancella tutto';

  @override
  String get wishlistFiltersDestination => 'Destinazione';

  @override
  String get wishlistFiltersSelectDestination => 'Seleziona';

  @override
  String get wishlistFiltersPriceRange => 'Fascia di prezzo';

  @override
  String get wishlistFiltersTripType => 'Tipo di viaggio';

  @override
  String get wishlistFiltersDomestic => 'Nazionale';

  @override
  String get wishlistFiltersInternational => 'Internazionale';

  @override
  String get wishlistFiltersDepartureCountry => 'Paese di partenza';

  @override
  String get wishlistFiltersDepartureCity => 'Città di partenza';

  @override
  String get wishlistFiltersSelectCountry => 'Seleziona';

  @override
  String get wishlistFiltersSelectCity => 'Seleziona';

  @override
  String get wishlistFiltersTripMonth => 'Mese del viaggio';

  @override
  String get wishlistFiltersSelectMonth => 'Seleziona';

  @override
  String get wishlistFiltersActions => 'Attività';

  @override
  String get wishlistFiltersSelectAction => 'Seleziona';

  @override
  String get wishlistFiltersTravelAgency => 'Agenzia di viaggi';

  @override
  String get wishlistFiltersAgencyNameHint => 'Nome dell’agenzia';

  @override
  String get wishlistFiltersAgencyRating => 'Valutazione dell’agenzia';

  @override
  String get wishlistFiltersOtherCountries => 'Altri paesi';

  @override
  String get wishlistFiltersOtherCities => 'Altre città';

  @override
  String get wishlistFiltersSelectCountries => 'Seleziona';

  @override
  String get wishlistFiltersSelectCities => 'Seleziona';

  @override
  String get wishlistFiltersNumberOfCities => 'Numero di città';

  @override
  String get wishlistFiltersNumberOfCountries => 'Numero di paesi';

  @override
  String get wishlistFiltersDuration => 'Durata';

  @override
  String get wishlistFiltersDurationUpTo3 => 'Fino a 3 giorni';

  @override
  String get wishlistFiltersDurationUpTo7 => 'Fino a 7 giorni';

  @override
  String get wishlistFiltersDuration7Plus => '+7 giorni';

  @override
  String get wishlistFiltersGroupSize => 'Dimensione del gruppo';

  @override
  String get wishlistFiltersGroupSizeSmall => 'Fino a 10';

  @override
  String get wishlistFiltersGroupSizeUpTo20 => 'Fino a 20';

  @override
  String get wishlistFiltersGroupSize20Plus => '20+';

  @override
  String get wishlistFiltersTripSeason => 'Stagione';

  @override
  String get wishlistFiltersSeasonSpring => 'Primavera';

  @override
  String get wishlistFiltersSeasonHajj => 'Hajj';

  @override
  String get wishlistFiltersSeasonNewYear => 'Capodanno';

  @override
  String get wishlistFiltersTripFeatures => 'Caratteristiche del viaggio';

  @override
  String get wishlistFiltersFeatureIncludeFlight => 'Include volo';

  @override
  String get wishlistFiltersFeatureIncludeHotel => 'Include hotel';

  @override
  String get wishlistFiltersFeatureFreeMeal => 'Pasto gratuito';

  @override
  String get wishlistFiltersFeatureVisaOnArrival => 'Visto all’arrivo';

  @override
  String get wishlistFiltersTripRating => 'Valutazione viaggio';

  @override
  String get wishlistFiltersDiscountCode =>
      'Il viaggio applica un codice sconto';

  @override
  String get wishlistFiltersFreeCancellation => 'Cancellazione gratuita';

  @override
  String get wishlistFiltersSeeResults => 'Vedi +500 risultati';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsNotificationSetting => 'Impostazioni notifiche';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsCurrency => 'Valuta';

  @override
  String get settingsEnglish => 'Inglese';

  @override
  String get settingsArabic => 'Arabo';

  @override
  String get settingsDarkMode => 'Modalità scura';

  @override
  String settingsAppVersion(Object version) {
    return 'Versione app $version';
  }

  @override
  String get notificationSettingsTitle => 'Impostazioni notifiche';

  @override
  String get notificationSettingsIntro =>
      'Gestisci le preferenze di notifica per restare aggiornato su nuovi viaggi, offerte e aggiornamenti delle prenotazioni.';

  @override
  String get notificationSettingsBookingUpdatesTitle =>
      'Aggiornamenti prenotazione';

  @override
  String get notificationSettingsBookingUpdatesSubtitle =>
      'Ricevi aggiornamenti in tempo reale su conferme, cancellazioni e modifiche alle tue prenotazioni.';

  @override
  String get notificationSettingsToursTitle => 'Tour';

  @override
  String get notificationSettingsToursSubtitle =>
      'Ricevi una notifica quando vengono aggiunti nuovi viaggi o tour che corrispondono ai tuoi interessi.';

  @override
  String get notificationSettingsReviewsTitle => 'Recensioni';

  @override
  String get notificationSettingsReviewsSubtitle =>
      'Ricevi un avviso quando qualcuno risponde alla tua recensione o quando sei invitato a recensire un viaggio che hai fatto.';

  @override
  String get notificationSettingsPromotionsSubtitle =>
      'Accedi a sconti speciali, offerte a tempo limitato e promozioni stagionali.';

  @override
  String get notificationSettingsPush => 'Notifiche push';

  @override
  String get notificationSettingsEmail => 'Notifiche email';

  @override
  String get notificationSettingsTripUpdates => 'Aggiornamenti viaggio';

  @override
  String get notificationSettingsPromotions => 'Promozioni';

  @override
  String get notificationSettingsPriceAlerts => 'Avvisi prezzo';

  @override
  String get profileTitleAccount => 'Account';

  @override
  String get profileTitleSupport => 'Supporto';

  @override
  String get profilePersonalInfo => 'Info personali';

  @override
  String get profilePaymentMethod => 'Metodo di pagamento';

  @override
  String get profileMyReviews => 'Le mie recensioni';

  @override
  String get profileAddReview => 'Aggiungi recensione';

  @override
  String get profileReviewLabel => 'Recensione';

  @override
  String get profileProductRatingLabel => 'Valutazione prodotto';

  @override
  String get profileMyReviewsRoute => 'Il Cairo → Dahab';

  @override
  String get profileFollowingCompanies => 'Aziende seguite';

  @override
  String get profileSettings => 'Impostazioni';

  @override
  String get profileCustomerService => 'Assistenza clienti';

  @override
  String get profileFaqs => 'FAQ';

  @override
  String get profileTermsAndConditions => 'Termini e condizioni';

  @override
  String get profileDeleteAccount => 'Elimina account';

  @override
  String get profileLogout => 'Esci';

  @override
  String profileTripsBooked(Object count) {
    return '$count viaggi prenotati';
  }

  @override
  String get profileDeleteAccountTitle => 'Elimina account';

  @override
  String get profileDeleteAccountMessage =>
      'Sei sicuro di voler eliminare il tuo account? Questa azione non può essere annullata.';

  @override
  String get profileLogoutConfirmTitle => 'Esci';

  @override
  String get profileLogoutConfirmMessage => 'Sei sicuro di voler uscire?';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get followingsTitle => 'I miei seguiti';

  @override
  String followingsCountTitle(Object count) {
    return '$count seguiti';
  }

  @override
  String get followingsUnfollow => 'Smetti di seguire';

  @override
  String get followingsEmptyTitle => 'Nessun seguito';

  @override
  String get followingsEmptyDescription =>
      'Inizia a seguire le aziende per vedere\nqui i loro viaggi.';

  @override
  String get myTripsTitle => 'I miei viaggi';

  @override
  String get myTripsTabUpcoming => 'In arrivo';

  @override
  String get myTripsTabPast => 'Passati';

  @override
  String get myTripsSearchHint => 'Cerca un viaggio';

  @override
  String get myTripsCatalogTripsOf => 'Viaggi a';

  @override
  String myTripsCatalogReviewCountInline(int count) {
    return '($count)';
  }

  @override
  String get myTripsCatalogSaveWishlist => 'Aggiungi ai preferiti';

  @override
  String get myTripsCatalogRemoveWishlist => 'Rimuovi dai preferiti';

  @override
  String get myTripsTabActive => 'Attivi';

  @override
  String get myTripsTabPastNew => 'Passati';

  @override
  String get myTripsTabCanceled => 'Annullati';

  @override
  String get myTripsStatusActive => 'Attivo';

  @override
  String get myTripsStatusPast => 'Passato';

  @override
  String get myTripsStatusCanceled => 'Annullato';

  @override
  String get myTripsBookAgain => 'Prenota di nuovo';

  @override
  String get myTripsFromPrefix => 'Da';

  @override
  String get myTripsViewDetails => 'Vedi dettagli';

  @override
  String get myTripsViewReceipt => 'Vedi ricevuta';

  @override
  String get myTripsBookingDetails => 'Dettagli prenotazione';

  @override
  String get myTripsDownloadPdf => 'Scarica PDF';

  @override
  String get myTripsEmptyTitle => 'Nessun viaggio';

  @override
  String get myTripsEmptyDescription =>
      'Inizia a esplorare e prenota\nla tua prima avventura!';

  @override
  String get myTripsExploreTrips => 'Esplora viaggi';

  @override
  String get navHome => 'Home';

  @override
  String get navTrips => 'Viaggi';

  @override
  String get navWishlist => 'Preferiti';

  @override
  String get navAccount => 'Account';

  @override
  String get bookingContactInfoTitle => 'Informazioni di contatto';

  @override
  String get bookingContactFullNameLabel => 'Nome completo';

  @override
  String get bookingContactFullNameHint => 'Inserisci il tuo nome completo';

  @override
  String get bookingContactPhoneLabel => 'Numero di telefono';

  @override
  String get bookingContactPhoneHint => '+20 123 456 7890';

  @override
  String get bookingContactEmailLabel => 'Email';

  @override
  String get bookingContactEmailHint => 'email@example.com';

  @override
  String get bookingContactEmergencyLabel => 'Contatto di emergenza';

  @override
  String get bookingContactEmergencyHint => 'Numero contatto di emergenza';

  @override
  String get bookingContactIdPassportLabel => 'Numero ID/Passaporto';

  @override
  String get bookingContactIdPassportHint =>
      'Inserisci il tuo numero ID o passaporto';

  @override
  String get bookingContinue => 'Continua';

  @override
  String get bookingAddNewCardTitle => 'Aggiungi nuova carta';

  @override
  String get bookingCardNumberLabel => 'Numero carta';

  @override
  String get bookingCardNumberHint => '0000 0000 0000 0000';

  @override
  String get bookingCardholderNameLabel => 'Intestatario carta';

  @override
  String get bookingCardholderNameHint => 'John Doe';

  @override
  String get bookingExpiryDateLabel => 'Scadenza';

  @override
  String get bookingExpiryDateHint => 'MM/AA';

  @override
  String get bookingCvvLabel => 'CVV';

  @override
  String get bookingCvvHint => '***';

  @override
  String get bookingSaveCard => 'Salva carta';

  @override
  String get bookingCardholderNamePlaceholder => 'INTESTATARIO CARTA';

  @override
  String get bookingPaymentMethodTitle => 'Metodo di pagamento';

  @override
  String get bookingPaymentOptionCreditCard => 'Carta di credito';

  @override
  String get bookingPaymentOptionCreditCardSubtitle =>
      'Paga con Visa, Mastercard';

  @override
  String get bookingPaymentOptionPaypal => 'PayPal';

  @override
  String get bookingPaymentOptionPaypalSubtitle =>
      'Paga con il tuo account PayPal';

  @override
  String get bookingPaymentOptionApplePay => 'Apple Pay';

  @override
  String get bookingPaymentOptionApplePaySubtitle => 'Paga con Apple Pay';

  @override
  String get bookingSavedCards => 'Carte salvate';

  @override
  String get bookingAddNewCard => 'Aggiungi nuova carta';

  @override
  String bookingPayNow(Object amount) {
    return 'Paga ora - $amount';
  }

  @override
  String bookingCardExpires(Object expiry) {
    return 'Scade $expiry';
  }

  @override
  String get profilePersonalInfoTitle => 'Info personali';

  @override
  String get profileFullNameLabel => 'Nome completo';

  @override
  String get profileEmailLabel => 'Email';

  @override
  String get profilePhoneNumberLabel => 'Numero di telefono';

  @override
  String get profilePasswordLabel => 'Password';

  @override
  String get profileCountryLabel => 'Paese';

  @override
  String get profileCityLabel => 'Città';

  @override
  String get profileEditAction => 'Modifica';

  @override
  String get profileChangePasswordAction => 'Cambia password';

  @override
  String get profileGender => 'Genere';

  @override
  String get profileGenderMale => 'Maschio';

  @override
  String get profileGenderFemale => 'Femmina';

  @override
  String get profileDateOfBirth => 'Data di nascita';

  @override
  String get profileSaveChanges => 'Salva modifiche';

  @override
  String get companyProfileCompanyName => 'Travel Egypt Co.';

  @override
  String companyProfileReviewsCountShort(Object count) {
    return '($count recensioni)';
  }

  @override
  String get companyProfileFollowing => 'Seguito';

  @override
  String get companyProfileFollow => 'Segui';

  @override
  String get companyProfileStatsTrips => 'Viaggi';

  @override
  String get companyProfileStatsReviews => 'Recensioni';

  @override
  String get companyProfileStatsFollowers => 'Follower';

  @override
  String get companyProfileAbout => 'Informazioni';

  @override
  String get companyProfileAboutDescription =>
      'Travel Egypt Co. è un’agenzia di viaggi leader specializzata in tour e avventure in Egitto. Offriamo esperienze uniche in tutto l’Egitto, dalle antiche piramidi ai bellissimi resort sul Mar Rosso.';

  @override
  String get companyProfileTrips => 'Viaggi';

  @override
  String get companyProfileReviews => 'Recensioni';

  @override
  String get companyProfileSeeAll => 'Vedi tutto';

  @override
  String get companyProfileTripName => 'Nome viaggio';

  @override
  String get companyProfileReviewAuthor => 'John Doe';

  @override
  String get companyProfileReviewDate => '2 giorni fa';

  @override
  String get companyProfileReviewComment =>
      'Ottima esperienza! Il viaggio era ben organizzato e la guida molto professionale.';

  @override
  String get filterTitle => 'Filtro';

  @override
  String get filterReset => 'Reimposta';

  @override
  String get filterDuration => 'Durata';

  @override
  String get filterTripType => 'Tipo di viaggio';

  @override
  String get filterRating => 'Valutazione';

  @override
  String get filterDepartureCity => 'Città di partenza';

  @override
  String get filterSelectCity => 'Seleziona città';

  @override
  String get filterApply => 'Applica';

  @override
  String get destinationTitle => 'Destinazione';

  @override
  String get destinationSearchHint => 'Cerca destinazioni...';

  @override
  String get destinationRecentSearches => 'Ricerche recenti';

  @override
  String get destinationClearAll => 'Cancella tutto';

  @override
  String get destinationPopularDestinations => 'Destinazioni popolari';

  @override
  String searchTripsFound(Object count) {
    return '$count viaggi trovati';
  }

  @override
  String get searchQueryExample => 'Sharm El Sheikh';

  @override
  String get tripDetailsTitle => 'Viaggio a Dahab';

  @override
  String get tripDetailsHeroCountryTag => 'Indonesia';

  @override
  String get tripDetailsHeroByCompany => 'Da Agenzia di Viaggi';

  @override
  String get tripDetailsHeroFromLocation => 'Da Il Cairo & Alessandria';

  @override
  String get tripDetailsHeroDateRange => '27 nov → 4 dic';

  @override
  String get tripDetailsHeroFromPrefix => 'Da ';

  @override
  String tripDetailsHeroByCompanyLine(String company) {
    return 'Da $company';
  }

  @override
  String tripDetailsGalleryMoreCount(Object count) {
    return '+$count';
  }

  @override
  String imageGalleryPosition(int current, int total) {
    return '$current di $total';
  }

  @override
  String get tripDetailsOverviewTitle => 'Panoramica viaggio';

  @override
  String get tripDetailsOverviewBody =>
      'Vivi la bellezza mozzafiato delle Alpi svizzere in questa avventura di 7 giorni. Visita destinazioni iconiche, goditi viaggi in treno panoramici e immergiti nella cultura svizzera. Perfetto per amanti della natura e della fotografia.';

  @override
  String get tripDetailsWhatsIncludedTitle => 'Cosa include';

  @override
  String get tripDetailsIncludedFlightTickets => 'Biglietti aerei';

  @override
  String get tripDetailsIncludedHotelStay => 'Soggiorno in hotel';

  @override
  String get tripDetailsIncludedBreakfast => 'Colazione';

  @override
  String get tripDetailsIncludedAirportTransfer => 'Trasferimento aeroporto';

  @override
  String get tripDetailsDepartureDetailsTitle => 'Dettagli partenza';

  @override
  String get tripDetailsMeetingLocationLabel => 'Punto d’incontro';

  @override
  String get tripDetailsMeetingLocationValue =>
      '18 El Tesen Road, New Cairo, Egitto';

  @override
  String get tripDetailsReturnLocationLabel => 'Luogo di ritorno';

  @override
  String get tripDetailsReturnLocationValue => '54 Ramses, Centro, Egitto';

  @override
  String get tripDetailsMeetingTimeLabel => 'Ora d’incontro';

  @override
  String get tripDetailsMeetingTimeValue => '5:00 PM';

  @override
  String get tripDetailsReturnTimeLabel => 'Ora di ritorno';

  @override
  String get tripDetailsReturnTimeValue => '9:30 PM';

  @override
  String get tripDetailsProgramTitle => 'Programma del viaggio';

  @override
  String get tripDetailsProgramMealsLabel => 'Pasti';

  @override
  String get tripDetailsProgramDay1 => 'Giorno 1';

  @override
  String get tripDetailsProgramDay2 => 'Giorno 2';

  @override
  String get tripDetailsProgramCity1 => 'Pechino';

  @override
  String get tripDetailsProgramCity2 => 'Hangzhou';

  @override
  String get tripDetailsProgramDay1Item1 => 'Arrivo all’aeroporto di Changdu';

  @override
  String get tripDetailsProgramDay1Item2 => 'Volo domestico per Pechino';

  @override
  String get tripDetailsProgramDay1Item3 => 'Check-in in hotel';

  @override
  String get tripDetailsProgramDay1Item4 => 'Tour libero in Wangfujing Street';

  @override
  String get tripDetailsProgramDay2Item1 => 'Tour della città di Hangzhou';

  @override
  String get tripDetailsProgramDay2Item2 => 'Check-in in hotel e tour serale';

  @override
  String get tripDetailsProgramDay2Item3 => 'Visita al West Lake in crociera';

  @override
  String get tripDetailsProgramSeeAll => 'Vedi tutto il programma';

  @override
  String get tripDetailsAirlineLabel => 'Compagnia aerea';

  @override
  String get tripDetailsAirlineName => 'Egyptair';

  @override
  String get tripDetailsFlightLeg1FromCity => 'Il Cairo';

  @override
  String get tripDetailsFlightLeg1FromTime => '5:00 AM';

  @override
  String get tripDetailsFlightLeg1ToCity => 'Parigi';

  @override
  String get tripDetailsFlightLeg1ToTime => '7:20 AM';

  @override
  String get tripDetailsFlightLeg1Date => '28 aprile';

  @override
  String get tripDetailsFlightLeg2FromCity => 'Parigi';

  @override
  String get tripDetailsFlightLeg2FromTime => '8:00 AM';

  @override
  String get tripDetailsFlightLeg2ToCity => 'Il Cairo';

  @override
  String get tripDetailsFlightLeg2ToTime => '5:20 AM';

  @override
  String get tripDetailsFlightLeg2Date => '4 maggio';

  @override
  String get tripDetailsTransportLeg1FromCity => 'Il Cairo';

  @override
  String get tripDetailsTransportLeg1FromTime => '8:00 AM';

  @override
  String get tripDetailsTransportLeg1ToCity => 'Parigi';

  @override
  String get tripDetailsTransportLeg1ToTime => '5:20 AM';

  @override
  String get tripDetailsTransportLeg1CenterLabel => 'Autobus';

  @override
  String get tripDetailsTransportLeg1Date => '29 maggio';

  @override
  String get tripDetailsTransportLeg2FromCity => 'Il Cairo';

  @override
  String get tripDetailsTransportLeg2FromTime => '8:00 AM';

  @override
  String get tripDetailsTransportLeg2ToCity => 'Parigi';

  @override
  String get tripDetailsTransportLeg2ToTime => '5:20 AM';

  @override
  String get tripDetailsTransportLeg2CenterLabel => 'Barca';

  @override
  String get tripDetailsTransportLeg2Date => '29 maggio';

  @override
  String get tripDetailsDestinationHurghada => 'Hurghada';

  @override
  String get tripDetailsDestinationParis => 'Parigi';

  @override
  String get tripDetailsStatCitiesLabel => 'Numero di città';

  @override
  String get tripDetailsStatCitiesValue => '7 città';

  @override
  String tripDetailsStatCitiesCount(int count) {
    return '$count città';
  }

  @override
  String get tripDetailsPriceLabel => 'Prezzo';

  @override
  String get tripDetailsPerPersonSmall => 'a persona';

  @override
  String get tripDetailsBookingPriceDisplay => '1000.00';

  @override
  String get tripDetailsCompanyName => 'Travel Egypt Co.';

  @override
  String get tripDetailsCompanyTagline => 'Agenzia di viaggi avventura';

  @override
  String get tripDetailsFollow => 'Segui';

  @override
  String get tripDetailsDurationValue => '7 giorni';

  @override
  String get tripDetailsDurationLabel => 'Durata';

  @override
  String get tripDetailsGroupSizeValue => '20-25';

  @override
  String get tripDetailsGroupSizeLabel => 'Dimensione gruppo';

  @override
  String get tripDetailsTypeValue => 'Internazionale';

  @override
  String get tripDetailsTypeLabel => 'Tipo';

  @override
  String get tripDetailsPerPerson => '/Persona';

  @override
  String get tripDetailsDescriptionTitle => 'Descrizione';

  @override
  String get tripDetailsReadMore => ' Leggi di più';

  @override
  String get tripDetailsShowLess => ' Mostra meno';

  @override
  String get tripDetailsDescriptionBody =>
      'Vivi la magia di Dahab, una bellissima città costiera sulla costa sud-est della penisola del Sinai in Egitto. Questo viaggio di 7 giorni include snorkeling al Blue Hole, safari nel deserto, giri in cammello e visite ad antichi villaggi beduini. Goditi splendidi reef corallini, acque cristalline e paesaggi montani mozzafiato. Le nostre guide esperte ti garantiranno un’avventura indimenticabile con alloggi confortevoli e deliziosa cucina locale.';

  @override
  String get tripDetailsItineraryTitle => 'Itinerario';

  @override
  String get tripDetailsIncludesTitle => 'Include';

  @override
  String get tripDetailsIncludesHotel => 'Hotel';

  @override
  String get tripDetailsIncludesTransportation => 'Trasporto';

  @override
  String get tripDetailsIncludesMeals => 'Pasti';

  @override
  String get tripDetailsIncludesActivities => 'Attività';

  @override
  String get tripDetailsIncludesTourGuide => 'Guida';

  @override
  String get tripDetailsImagesTitle => 'Immagini viaggio';

  @override
  String get tripDetailsReviewsTitle => 'Recensioni';

  @override
  String tripDetailsReviewsCount(Object count) {
    return '$count recensioni';
  }

  @override
  String get tripDetailsRelatedTripsTitle => 'Viaggi correlati';

  @override
  String get tripDetailsTotalPrice => 'Prezzo totale';

  @override
  String get tripDetailsBookNow => 'Prenota ora';

  @override
  String tripDetailsPricePerPersonShort(Object price) {
    return '$price/Persona';
  }

  @override
  String get tripDetailsDay1Title => 'Giorno 1 - Arrivo e check-in';

  @override
  String get tripDetailsDay1Desc =>
      'Arrivo a Dahab, trasferimento in hotel, cena di benvenuto e incontro di orientamento con il gruppo.';

  @override
  String get tripDetailsDay2Title => 'Giorno 2 - Snorkeling Blue Hole';

  @override
  String get tripDetailsDay2Desc =>
      'Giornata intera di snorkeling al famoso Blue Hole. Pranzo in un ristorante sul mare. Serata libera.';

  @override
  String get tripDetailsDay3Title => 'Giorno 3 - Safari nel deserto';

  @override
  String get tripDetailsDay3Desc =>
      'Safari in jeep nel deserto del Sinai. Visita a un villaggio beduino. Cena e osservazione delle stelle nel deserto.';

  @override
  String get tripDetailsDay4Title => 'Giorno 4 - Giorno libero e attività';

  @override
  String get tripDetailsDay4Desc =>
      'Scegli tra attività opzionali: immersioni, giri in cammello o esplora i mercati locali.';

  @override
  String get tripDetailsDay5Title => 'Giorno 5 - Escursione Monte Sinai';

  @override
  String get tripDetailsDay5Desc =>
      'Escursione all’alba sul Monte Sinai. Visita al Monastero di Santa Caterina.';

  @override
  String get tripDetailsDay6Title => 'Giorno 6 - Sport acquatici';

  @override
  String get tripDetailsDay6Desc =>
      'Lezioni di windsurf e kitesurf. Cena di addio in un ristorante sul mare.';

  @override
  String get tripDetailsDay7Title => 'Giorno 7 - Partenza';

  @override
  String get tripDetailsDay7Desc =>
      'Colazione in hotel. Check-out e trasferimento in aeroporto.';

  @override
  String get tripDetailsRelatedNameSharm => 'Sharm El Sheikh';

  @override
  String get tripDetailsRelatedNameHurghada => 'Viaggio Hurghada';

  @override
  String get tripDetailsRelatedNameLuxorAswan => 'Luxor e Aswan';

  @override
  String get tripDetailsHeroRatingLine => '4.5 (120 recensioni)';

  @override
  String get tripDetailsHeroLocationShort => 'Dahab, Egitto';

  @override
  String get tripDetailsHeroDaysBadge => '7 giorni';

  @override
  String get tripDetailsOut => 'Andata';

  @override
  String get tripDetailsIn => 'Ritorno';

  @override
  String get tripDetailsOutSummaryLine1 => '21 maggio, venerdì';

  @override
  String get tripDetailsOutSummaryLine2 =>
      'Aeroporto Internazionale del Cairo (CAI)';

  @override
  String get tripDetailsInSummaryLine1 => '27 maggio, giovedì';

  @override
  String get tripDetailsInSummaryLine2 => 'Dahab, Sinai del Sud';

  @override
  String get tripDetailsTripDescriptionTitle => 'Descrizione viaggio';

  @override
  String get tripDetailsAmenitiesTitle => 'Servizi';

  @override
  String get tripDetailsAmenityHotelStars => 'Hotel 4 stelle';

  @override
  String get tripDetailsAmenityFoodBar => 'Food bar';

  @override
  String get tripDetailsAmenityBusTrip => 'Viaggio in autobus';

  @override
  String get tripDetailsAmenityTourGuide => 'Guida turistica';

  @override
  String get tripDetailsAccommodationTitle => 'Alloggio';

  @override
  String get tripDetailsAccommodationHotelNameLabel => 'Nome hotel';

  @override
  String get tripDetailsHotelName => 'Le Meridien Dahab Resort';

  @override
  String get tripDetailsHotelRatingStars => '5.0';

  @override
  String get tripDetailsAccommodationHotelLocationLabel => 'Posizione hotel';

  @override
  String get tripDetailsHotelAddress => 'Blue Hole Road, Dahab, Egitto';

  @override
  String get tripDetailsCheckInOut => 'Check-in 2:00 PM · Check-out 11:00 AM';

  @override
  String get tripDetailsViewMap => 'Vedi mappa';

  @override
  String get tripDetailsSeeAllAccommodation => 'Vedi tutti gli alloggi';

  @override
  String get tripDetailsViewFullItinerary => 'Vedi itinerario completo';

  @override
  String get tripDetailsFlightDetailsTitle => 'Dettagli volo';

  @override
  String get tripDetailsTransportationTitle => 'Trasporti';

  @override
  String get tripDetailsFlightLegSummary => 'CAI → SSH · EgyptAir · 1h 10m';

  @override
  String get tripDetailsTrainLegSummary => 'Ritorno · Il Cairo · 8h 30m';

  @override
  String get tripDetailsDestinationsTitle => 'Destinazioni';

  @override
  String get tripDetailsDestinationDahab => 'Dahab';

  @override
  String get tripDetailsDestinationNuweiba => 'Nuweiba';

  @override
  String get tripDetailsDestinationDetailsTitle => 'Dettagli destinazione';

  @override
  String get tripDetailsDestinationVisaLabel => 'Visto';

  @override
  String get tripDetailsDestinationVisaValue => 'Visto richiesto';

  @override
  String get tripDetailsDestinationRequiredVaccinesLabel => 'Vaccini richiesti';

  @override
  String get tripDetailsDestinationRequiredVaccinesValue => '+201026329736';

  @override
  String get tripDetailsDestinationTimeLabel => 'Ora';

  @override
  String get tripDetailsDestinationTimeValue => 'GMT+1';

  @override
  String get tripDetailsDestinationLanguageLabel => 'Lingua';

  @override
  String get tripDetailsDestinationLanguageValue => 'Inglese';

  @override
  String get tripDetailsDestinationCurrencyLabel => 'Valuta';

  @override
  String get tripDetailsDestinationCurrencyValue => 'Euro (EUR)';

  @override
  String get tripDetailsDestinationTemperatureLabel => 'Temperatura';

  @override
  String get tripDetailsDestinationTemperatureValue => '25°C';

  @override
  String get tripDetailsDestinationPublicTransportationLabel =>
      'Trasporto pubblico';

  @override
  String get tripDetailsDestinationPublicTransportationValue => 'Autobus';

  @override
  String get tripDetailsDestinationTaxiAppsLabel => 'App taxi';

  @override
  String get tripDetailsDestinationTaxiAppsValue => 'Uber, InDrive';

  @override
  String get tripDetailsIncludesExcludesTitle => 'Include ed esclude';

  @override
  String get tripDetailsExcludesTitle => 'Esclude';

  @override
  String get tripDetailsExcludeVisa => 'Spese visto';

  @override
  String get tripDetailsExcludeAlcohol => 'Bevande alcoliche';

  @override
  String get tripDetailsSeeAllPhotos => 'Vedi tutte le foto';

  @override
  String get tripDetailsActivityPlansTitle => 'Piani attività';

  @override
  String get tripDetailsActivitySnorkel => 'Snorkeling Blue Hole';

  @override
  String get tripDetailsActivitySnorkelPrice => 'EGP 500';

  @override
  String get tripDetailsActivitySafari => 'Safari nel deserto';

  @override
  String get tripDetailsActivitySafariPrice => 'EGP 350';

  @override
  String get tripDetailsActivityDiving => 'Sessione introduttiva di immersione';

  @override
  String get tripDetailsActivityDivingPrice => 'EGP 800';

  @override
  String get tripDetailsAdd => 'Aggiungi';

  @override
  String get tripDetailsAdded => 'Aggiunto';

  @override
  String get tripDetailsViewAllActivities => 'Vedi tutte le attività';

  @override
  String get tripDetailsActivityRateTitle => 'Valutazione attività';

  @override
  String get tripDetailsActivityRateLuxury => 'livello di lusso';

  @override
  String get tripDetailsActivityRateShopping => 'Shopping';

  @override
  String get tripDetailsActivityRateNightOutings => 'Uscite serali';

  @override
  String get tripDetailsSeeAllActivities => 'Vedi tutte le attività';

  @override
  String get tripDetailsVisaDetailsTitle => 'Dettagli visto';

  @override
  String get tripDetailsTripInstructionsTitle => 'Istruzioni del viaggio';

  @override
  String get tripDetailsSafetyProceduresTitle => 'Procedure di sicurezza';

  @override
  String get tripDetailsCompanySectionTitle => 'Azienda';

  @override
  String get tripDetailsViewAll => 'Vedi tutto';

  @override
  String get tripDetailsReviewCountry => 'Spagna';

  @override
  String get tripDetailsCompanyRatingValue => '4.9';

  @override
  String get tripDetailsCompanyRatingCount => '112';

  @override
  String get tripDetailsPolicyCancellation => 'Politica di cancellazione';

  @override
  String get tripDetailsPolicyInsurance => 'Assicurazione di viaggio';

  @override
  String get tripDetailsPolicyTerms => 'Termini e condizioni';

  @override
  String get tripDetailsPolicyFaqs => 'Domande frequenti';

  @override
  String get tripDetailsSeeAllReviews => 'Vedi tutto';

  @override
  String get tripDetailsOrganizerTitle => 'Organizzatore';

  @override
  String get tripDetailsOrganizerSubtitle =>
      'Partner affidabile su Trip Marche';

  @override
  String get tripDetailsStartingFrom => 'A partire da';

  @override
  String get tripDetailsBookingFromPrice => 'EGP 5,000';

  @override
  String get tripDetailsItineraryLoc1 => 'Pechino';

  @override
  String get tripDetailsItineraryActs1 =>
      '• Check-in in hotel\n• Passeggiata di orientamento\n• Cena di benvenuto';

  @override
  String get tripDetailsItineraryLoc2 => 'Hangzhou';

  @override
  String get tripDetailsItineraryActs2 =>
      '• Crociera sul West Lake\n• Visita a una piantagione di tè\n• Serata libera';

  @override
  String get tripDetailsReviewSampleName => 'Ahmed Hassan';

  @override
  String get tripDetailsReviewSampleDate => 'Dic 2025';

  @override
  String get tripDetailsReviewSampleBody =>
      'Viaggio fantastico! Ottima organizzazione e guide cordiali. La giornata di snorkeling è stata indimenticabile.';

  @override
  String get bookingTripTermsTitle => 'Termini e condizioni';

  @override
  String get bookingTripTermsHeader => 'Termini e condizioni del viaggio';

  @override
  String bookingTripTermsLastUpdated(Object date) {
    return 'Ultimo aggiornamento: $date';
  }

  @override
  String get bookingTripTermsSection1Title => '1. Prenotazione e pagamento';

  @override
  String get bookingTripTermsSection1Body =>
      'Prenotando un viaggio tramite Trip Marche, accetti i seguenti termini. È richiesto un deposito del 30% al momento della prenotazione per garantire il posto. Il saldo restante deve essere pagato almeno 14 giorni prima della partenza. Il mancato pagamento può comportare la cancellazione della prenotazione. Tutti i pagamenti vengono elaborati in modo sicuro tramite i nostri partner.';

  @override
  String get bookingTripTermsSection2Title => '2. Idoneità';

  @override
  String get bookingTripTermsSection2Body =>
      'I partecipanti devono avere almeno 18 anni per prenotare in autonomia. I viaggiatori sotto i 18 anni devono essere accompagnati da un genitore o tutore legale. Alcune attività possono richiedere requisiti aggiuntivi di età o salute. È responsabilità del viaggiatore soddisfare i requisiti e avere i documenti necessari.';

  @override
  String get bookingTripTermsSection3Title => '3. Modifiche al viaggio';

  @override
  String get bookingTripTermsSection3Body =>
      'Trip Marche si riserva il diritto di modificare l’itinerario per condizioni meteo, sicurezza o altre circostanze impreviste. Faremo il possibile per offrire alternative equivalenti. In caso di cambiamenti significativi, i viaggiatori saranno avvisati e potranno ricevere un rimborso parziale o un credito.';

  @override
  String get bookingTripTermsSection4Title =>
      '4. Responsabilità del viaggiatore';

  @override
  String get bookingTripTermsSection4Body =>
      'I viaggiatori sono responsabili di avere documenti di viaggio validi, un’assicurazione adeguata e eventuali vaccinazioni richieste. Devono seguire le istruzioni delle guide e rispettare leggi e usanze locali. Trip Marche non è responsabile delle conseguenze dovute al mancato rispetto dei requisiti di ingresso.';

  @override
  String get bookingTripTermsSection5Title => '5. Responsabilità';

  @override
  String get bookingTripTermsSection5Body =>
      'Trip Marche agisce come organizzatore e intermediario. Pur adottando tutte le precauzioni, non siamo responsabili per perdite, infortuni o danni derivanti da attività durante il viaggio, eventi naturali o azioni di terzi. I viaggiatori partecipano a proprio rischio. Consigliamo vivamente un’assicurazione di viaggio completa.';

  @override
  String get bookingTripTermsSection6Title => '6. Privacy';

  @override
  String get bookingTripTermsSection6Body =>
      'Le informazioni personali raccolte durante la prenotazione vengono utilizzate esclusivamente per l’organizzazione del viaggio e la comunicazione. Non condividiamo i tuoi dati con terze parti salvo quanto necessario per completare la prenotazione. Per maggiori dettagli consulta la nostra Informativa sulla privacy.';

  @override
  String get bookingTripTermsSection7Title =>
      '7. Risoluzione delle controversie';

  @override
  String get bookingTripTermsSection7Body =>
      'Eventuali controversie derivanti da questi termini saranno risolte tramite negoziazione amichevole. Se non si raggiunge un accordo, le controversie saranno sottoposte ai tribunali competenti. Questi termini sono regolati dalle leggi della Repubblica Araba d’Egitto.';

  @override
  String get bookingTripInstructionsTitle => 'Istruzioni del viaggio';

  @override
  String get bookingTripInstructionsHeader => 'Prima di partire';

  @override
  String get bookingTripInstructionsIntro =>
      'Leggi attentamente le seguenti istruzioni per garantire un’esperienza di viaggio fluida e piacevole. Una corretta preparazione ti aiuterà a sfruttare al meglio la tua avventura a Dahab.';

  @override
  String get bookingTripInstructionsWhatToPack => 'Cosa portare';

  @override
  String get bookingTripInstructionsMeetingPointTime =>
      'Punto e ora d’incontro';

  @override
  String get bookingTripInstructionsDocumentsToBring => 'Documenti da portare';

  @override
  String get bookingTripInstructionsImportantReminders =>
      'Promemoria importanti';

  @override
  String get bookingTripSafetyTitle => 'Sicurezza del viaggio';

  @override
  String get bookingTripSafetyBanner =>
      'La tua sicurezza è la nostra priorità. Leggi attentamente le seguenti linee guida.';

  @override
  String get bookingTripSafetyHeader => 'Procedure di sicurezza';

  @override
  String get bookingTripSafetyIntro =>
      'In Trip Marche ci impegniamo a garantire la sicurezza e il benessere di tutti i viaggiatori. I nostri viaggi sono progettati con misure di sicurezza complete e tutte le guide sono formate in primo soccorso e procedure di emergenza.';

  @override
  String get bookingTripSafetyWaterTitle => 'Sicurezza attività acquatiche';

  @override
  String get bookingTripSafetyDesertTitle => 'Sicurezza nel deserto';

  @override
  String get bookingTripSafetyHealthTitle => 'Salute e assistenza medica';

  @override
  String get bookingTripSafetyEmergencyTitle => 'Contatti di emergenza';

  @override
  String get bookingTripSafetyGeneralTipsTitle =>
      'Consigli generali di sicurezza';

  @override
  String get authResetPasswordTitle => 'Reimposta password';

  @override
  String get authResetPasswordSubtitle =>
      'Inserisci qui sotto la nuova password';

  @override
  String get authNewPasswordLabel => 'Nuova password';

  @override
  String get authNewPasswordHint => 'Inserisci nuova password';

  @override
  String get authConfirmNewPasswordLabel => 'Conferma nuova password';

  @override
  String get authConfirmNewPasswordHint => 'Conferma nuova password';

  @override
  String get authResetPasswordButton => 'Reimposta password';

  @override
  String get tripDetailsDurationUnit => 'Giorni';

  @override
  String get tripDetailsProgramDayPrefix => 'Giorno';

  @override
  String get tripDetailsTypeDomestic => 'Nazionale';

  @override
  String get tripDetailsPayOnArrival => 'Paga all\'arrivo';

  @override
  String get tripDetailsFailedToLoad =>
      'Impossibile caricare i dettagli del viaggio.';

  @override
  String get tripDetailsTryAgain => 'Riprova';

  @override
  String get tripDetailsNoFlights =>
      'I dettagli del volo compariranno qui quando disponibili.';

  @override
  String get tripDetailsNoTransport =>
      'I dettagli di trasporto via terra o mare compariranno qui quando disponibili.';

  @override
  String get tripDetailsVisaAndEntryTitle => 'Visto e ingresso';
}
