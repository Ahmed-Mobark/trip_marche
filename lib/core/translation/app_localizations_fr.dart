// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get errorFieldRequired => 'Ce champ est obligatoire';

  @override
  String get errorInvalidName => 'Format de nom invalide';

  @override
  String get errorInvalidUrl => 'URL invalide';

  @override
  String get errorInvalidPhoneNumber => 'Numéro de téléphone invalide';

  @override
  String get errorInvalidEmail => 'Adresse e-mail invalide';

  @override
  String get errorInvalidPassword =>
      'Le mot de passe doit contenir au moins 8 caractères avec majuscules, minuscules et caractères spéciaux';

  @override
  String get errorPasswordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get errorInvalidNumber => 'Nombre invalide';

  @override
  String get errorInvalidIban => 'Format IBAN invalide';

  @override
  String get errorInvalidMobileNumber => 'Numéro de mobile invalide';

  @override
  String get errorInvalidStcPayId => 'ID STC Pay invalide';

  @override
  String get errorInvalidNationalId => 'ID nationale invalide';

  @override
  String get errorInvalidPassport => 'Numéro de passeport invalide';

  @override
  String get sorryMessage => 'Nous sommes désolés';

  @override
  String get nothingFound => 'Aucun résultat';

  @override
  String errorPhoneValidation(Object length, Object start) {
    return 'Le numéro de téléphone doit commencer par $start et contenir $length chiffres.';
  }

  @override
  String get errorExperienceRequired =>
      'Vous devez ajouter au moins une expérience.';

  @override
  String get errorIdDocumentRequired =>
      'Vous devez télécharger une pièce d’identité pour vérifier votre identité.';

  @override
  String get errorPhotoRequired =>
      'Vous devez télécharger une photo avec un fond blanc';

  @override
  String get updateAvailableTitle => 'Mise à jour disponible';

  @override
  String get updateMandatoryMessage =>
      'Une nouvelle version de l’application est disponible. Veuillez mettre à jour pour continuer à utiliser l’application.';

  @override
  String get updateOptionalMessage =>
      'Une nouvelle version de l’application est disponible. Nous recommandons de mettre à jour pour une meilleure expérience.';

  @override
  String get updateNow => 'Mettre à jour';

  @override
  String get skip => 'Ignorer';

  @override
  String get chooseImage => 'Téléverser : choisir une image';

  @override
  String get takePicture => 'Téléverser : prendre une photo';

  @override
  String get chooseFromFiles => 'Téléverser : choisir depuis les fichiers';

  @override
  String get updatePleaseUpdateToContinue =>
      'Veuillez mettre à jour l’application pour continuer.';

  @override
  String get updateNewVersionAvailableShort =>
      'Une nouvelle version est disponible.';

  @override
  String get authLoginTitle => 'Connectez-vous à votre compte';

  @override
  String get authEmailLabel => 'E-mail';

  @override
  String get authEmailHint => 'Saisissez votre e-mail';

  @override
  String get authPasswordLabel => 'Mot de passe';

  @override
  String get authPasswordHint => 'Saisissez votre mot de passe';

  @override
  String get authForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authLoginButton => 'Se connecter';

  @override
  String get authNoAccountPrompt => 'Vous n’avez pas de compte ? ';

  @override
  String get authCreateOne => 'Créer un compte';

  @override
  String get authOrLoginWith => 'Ou se connecter avec';

  @override
  String get authContinueWithGoogle => 'Continuer avec Google';

  @override
  String get authContinueWithApple => 'Continuer avec Apple';

  @override
  String get authTravelAgencyPrompt => 'Vendeur ou agence de voyages ? ';

  @override
  String get authJoinAsTripPartner => 'Rejoindre en tant que vendeur';

  @override
  String get authPartnerPortalTitle => 'Portail partenaire';

  @override
  String get authWebViewLoadFailed =>
      'Impossible de charger cette page. Vérifiez votre connexion et réessayez.';

  @override
  String get authWebViewRetry => 'Réessayer';

  @override
  String get authSignUpTitle => 'Créez votre compte';

  @override
  String get authSignUpSubtitle => 'Inscrivez-vous pour commencer';

  @override
  String get authFullNameLabel => 'Nom complet';

  @override
  String get authFullNameHint => 'Saisissez votre nom complet';

  @override
  String get authPhoneLabel => 'Numéro de téléphone';

  @override
  String get authPhoneHint => 'Saisissez votre numéro de téléphone';

  @override
  String get authConfirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get authConfirmPasswordHint => 'Confirmez votre mot de passe';

  @override
  String get authSignUpButton => 'S’inscrire';

  @override
  String get authOrSignUpWith => 'Ou s’inscrire avec';

  @override
  String get authSocialGoogle => 'Google';

  @override
  String get authSocialApple => 'Apple';

  @override
  String get authHaveAccountPrompt => 'Vous avez déjà un compte ? ';

  @override
  String get authLoginAction => 'Se connecter';

  @override
  String get authForgotPasswordTitle => 'Mot de passe oublié';

  @override
  String get authForgotPasswordDescription =>
      'Saisissez votre adresse e-mail ci-dessous et nous vous enverrons un lien pour réinitialiser votre mot de passe.';

  @override
  String get authForgotPasswordSubtitle => 'Oublié ? On s’en occupe.';

  @override
  String get authSendButton => 'Envoyer';

  @override
  String get authSendCodeButton => 'Envoyer le code';

  @override
  String get authVerifyTitle => 'Vérifiez votre numéro';

  @override
  String get authVerifyDescription =>
      'Nous avons envoyé un code OTP à votre numéro enregistré. Veuillez saisir le code ci-dessous.';

  @override
  String get authVerifyButton => 'Vérifier';

  @override
  String get authBack => 'Retour';

  @override
  String get authResendCode => 'Renvoyer le code';

  @override
  String get authVerifyEmailTitle => 'Vérifiez votre e-mail';

  @override
  String get authVerifyEmailSubtitle =>
      'Nous vous envoyons un code à 6 chiffres pour vérifier votre numéro';

  @override
  String get authVerificationCodeNotReceived => 'Code non reçu ?';

  @override
  String get authResendNow => 'Renvoyer maintenant';

  @override
  String get homeAppTitle => 'TripMarche';

  @override
  String get homeSearchHint => 'Rechercher un voyage';

  @override
  String get homeLocationText => 'Égypte, Le Caire, New Cairo';

  @override
  String get homeTrendingDestinations => 'Destinations tendances';

  @override
  String get homePopularTrips => 'Voyages populaires';

  @override
  String get homeSponsoredTrips => 'Voyages sponsorisés';

  @override
  String get homeDomesticTripsInEgypt => 'Voyages domestiques en Égypte';

  @override
  String get homeInternationalTripsFromEgypt =>
      'Voyages internationaux depuis l’Égypte';

  @override
  String get homeRecommendedForYou => 'Recommandé pour vous';

  @override
  String get homeSpecialTrips => 'Voyages spéciaux';

  @override
  String get homeTopRated => 'Les mieux notés';

  @override
  String get homeFromCairoAlexandria => 'Depuis Le Caire & Alexandrie';

  @override
  String get homeNewInTripMarche => 'Nouveau sur TripMarche';

  @override
  String get homePerPerson => 'Personne';

  @override
  String get homeSeeAll => 'Voir tout';

  @override
  String get wishlistTitle => 'Liste de souhaits';

  @override
  String get wishlistSearchHint => 'Rechercher un voyage';

  @override
  String get wishlistSortBy => 'Trier par';

  @override
  String get wishlistFilters => 'Filtres';

  @override
  String get wishlistNewInTripMarche => 'Nouveau sur TripMarche';

  @override
  String get wishlistRecommended => 'Recommandé';

  @override
  String get wishlistBestPrice => 'Meilleur prix';

  @override
  String get wishlistEmptyTitle => 'Aucun voyage enregistré';

  @override
  String get wishlistEmptyDescription =>
      'Appuyez sur l’icône cœur d’un voyage pour\nl’enregistrer dans votre liste de souhaits.';

  @override
  String get wishlistFiltersTitle => 'Filtres';

  @override
  String get wishlistFiltersClearAll => 'Tout effacer';

  @override
  String get wishlistFiltersDestination => 'Destination';

  @override
  String get wishlistFiltersSelectDestination => 'Sélectionner';

  @override
  String get wishlistFiltersPriceRange => 'Fourchette de prix';

  @override
  String get wishlistFiltersTripType => 'Type de voyage';

  @override
  String get wishlistFiltersDomestic => 'Domestique';

  @override
  String get wishlistFiltersInternational => 'International';

  @override
  String get wishlistFiltersDepartureCountry => 'Pays de départ';

  @override
  String get wishlistFiltersDepartureCity => 'Ville de départ';

  @override
  String get wishlistFiltersSelectCountry => 'Sélectionner';

  @override
  String get wishlistFiltersSelectCity => 'Sélectionner';

  @override
  String get wishlistFiltersTripMonth => 'Mois du voyage';

  @override
  String get wishlistFiltersSelectMonth => 'Sélectionner';

  @override
  String get wishlistFiltersActions => 'Activités';

  @override
  String get wishlistFiltersSelectAction => 'Sélectionner';

  @override
  String get wishlistFiltersTravelAgency => 'Agence de voyage';

  @override
  String get wishlistFiltersAgencyNameHint => 'Nom de l’agence';

  @override
  String get wishlistFiltersAgencyRating => 'Note de l’agence';

  @override
  String get wishlistFiltersOtherCountries => 'Autres pays';

  @override
  String get wishlistFiltersOtherCities => 'Autres villes';

  @override
  String get wishlistFiltersSelectCountries => 'Sélectionner';

  @override
  String get wishlistFiltersSelectCities => 'Sélectionner';

  @override
  String get wishlistFiltersNumberOfCities => 'Nombre de villes';

  @override
  String get wishlistFiltersNumberOfCountries => 'Nombre de pays';

  @override
  String get wishlistFiltersDuration => 'Durée';

  @override
  String get wishlistFiltersDurationUpTo3 => 'Jusqu’à 3 jours';

  @override
  String get wishlistFiltersDurationUpTo7 => 'Jusqu’à 7 jours';

  @override
  String get wishlistFiltersDuration7Plus => '+7 jours';

  @override
  String get wishlistFiltersGroupSize => 'Taille du groupe';

  @override
  String get wishlistFiltersGroupSizeSmall => 'Jusqu’à 10';

  @override
  String get wishlistFiltersGroupSizeUpTo20 => 'Jusqu’à 20';

  @override
  String get wishlistFiltersGroupSize20Plus => '20+';

  @override
  String get wishlistFiltersTripSeason => 'Saison';

  @override
  String get wishlistFiltersSeasonSpring => 'Printemps';

  @override
  String get wishlistFiltersSeasonHajj => 'Hajj';

  @override
  String get wishlistFiltersSeasonNewYear => 'Nouvel An';

  @override
  String get wishlistFiltersTripFeatures => 'Caractéristiques';

  @override
  String get wishlistFiltersFeatureIncludeFlight => 'Vol inclus';

  @override
  String get wishlistFiltersFeatureIncludeHotel => 'Hôtel inclus';

  @override
  String get wishlistFiltersFeatureFreeMeal => 'Repas gratuit';

  @override
  String get wishlistFiltersFeatureVisaOnArrival => 'Visa à l’arrivée';

  @override
  String get wishlistFiltersTripRating => 'Note du voyage';

  @override
  String get wishlistFiltersDiscountCode => 'Le voyage applique un code promo';

  @override
  String get wishlistFiltersFreeCancellation => 'Annulation gratuite';

  @override
  String get wishlistFiltersSeeResults => 'Voir +500 résultats';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsNotificationSetting => 'Paramètres de notification';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsCurrency => 'Devise';

  @override
  String get settingsEnglish => 'Anglais';

  @override
  String get settingsArabic => 'Arabe';

  @override
  String get settingsDarkMode => 'Mode sombre';

  @override
  String settingsAppVersion(Object version) {
    return 'Version de l’app $version';
  }

  @override
  String get notificationSettingsTitle => 'Paramètres de notification';

  @override
  String get notificationSettingsIntro =>
      'Gérez vos préférences de notification pour rester informé des nouveaux voyages, offres et mises à jour de réservation.';

  @override
  String get notificationSettingsBookingUpdatesTitle =>
      'Mises à jour de réservation';

  @override
  String get notificationSettingsBookingUpdatesSubtitle =>
      'Recevez des mises à jour en temps réel sur les confirmations, annulations et modifications de vos réservations.';

  @override
  String get notificationSettingsToursTitle => 'Tours';

  @override
  String get notificationSettingsToursSubtitle =>
      'Soyez informé lorsque de nouveaux voyages ou tours correspondant à vos intérêts sont ajoutés.';

  @override
  String get notificationSettingsReviewsTitle => 'Avis';

  @override
  String get notificationSettingsReviewsSubtitle =>
      'Soyez averti lorsqu’une personne répond à votre avis ou lorsque vous êtes invité à laisser un avis sur un voyage effectué.';

  @override
  String get notificationSettingsPromotionsSubtitle =>
      'Accédez à des réductions spéciales, des offres limitées et des promotions saisonnières.';

  @override
  String get notificationSettingsPush => 'Notifications push';

  @override
  String get notificationSettingsEmail => 'Notifications e-mail';

  @override
  String get notificationSettingsTripUpdates => 'Mises à jour de voyage';

  @override
  String get notificationSettingsPromotions => 'Promotions';

  @override
  String get notificationSettingsPriceAlerts => 'Alertes de prix';

  @override
  String get profileTitleAccount => 'Compte';

  @override
  String get profileTitleSupport => 'Support';

  @override
  String get profilePersonalInfo => 'Infos personnelles';

  @override
  String get profilePaymentMethod => 'Mode de paiement';

  @override
  String get profileMyReviews => 'Mes avis';

  @override
  String get profileAddReview => 'Ajouter un avis';

  @override
  String get profileReviewLabel => 'Avis';

  @override
  String get profileProductRatingLabel => 'Note du produit';

  @override
  String get profileMyReviewsRoute => 'Le Caire → Dahab';

  @override
  String get profileFollowingCompanies => 'Entreprises suivies';

  @override
  String get profileSettings => 'Paramètres';

  @override
  String get profileCustomerService => 'Service client';

  @override
  String get profileFaqs => 'FAQ';

  @override
  String get profileTermsAndConditions => 'Conditions générales';

  @override
  String get profileDeleteAccount => 'Supprimer le compte';

  @override
  String get profileLogout => 'Se déconnecter';

  @override
  String profileTripsBooked(Object count) {
    return '$count voyages réservés';
  }

  @override
  String get profileDeleteAccountTitle => 'Supprimer le compte';

  @override
  String get profileDeleteAccountMessage =>
      'Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.';

  @override
  String get profileLogoutConfirmTitle => 'Se déconnecter';

  @override
  String get profileLogoutConfirmMessage =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get followingsTitle => 'Mes abonnements';

  @override
  String followingsCountTitle(Object count) {
    return '$count abonnements';
  }

  @override
  String get followingsUnfollow => 'Se désabonner';

  @override
  String get followingsEmptyTitle => 'Aucun abonnement';

  @override
  String get followingsEmptyDescription =>
      'Commencez à suivre des entreprises pour voir\nleurs voyages ici.';

  @override
  String get myTripsTitle => 'Mes voyages';

  @override
  String get myTripsTabUpcoming => 'À venir';

  @override
  String get myTripsTabPast => 'Passés';

  @override
  String get myTripsSearchHint => 'Rechercher un voyage';

  @override
  String get myTripsCatalogTripsOf => 'Voyages à';

  @override
  String myTripsCatalogReviewCountInline(int count) {
    return '($count)';
  }

  @override
  String get myTripsCatalogSaveWishlist => 'Ajouter aux favoris';

  @override
  String get myTripsCatalogRemoveWishlist => 'Retirer des favoris';

  @override
  String get myTripsTabActive => 'Actifs';

  @override
  String get myTripsTabPastNew => 'Passés';

  @override
  String get myTripsTabCanceled => 'Annulés';

  @override
  String get myTripsStatusActive => 'Actif';

  @override
  String get myTripsStatusPast => 'Passé';

  @override
  String get myTripsStatusCanceled => 'Annulé';

  @override
  String get myTripsBookAgain => 'Réserver à nouveau';

  @override
  String get myTripsFromPrefix => 'À partir de';

  @override
  String get myTripsViewDetails => 'Voir les détails';

  @override
  String get myTripsViewReceipt => 'Voir le reçu';

  @override
  String get myTripsBookingDetails => 'Détails de réservation';

  @override
  String get myTripsDownloadPdf => 'Télécharger le PDF';

  @override
  String get myTripsEmptyTitle => 'Aucun voyage';

  @override
  String get myTripsEmptyDescription =>
      'Commencez à explorer et réservez\nvotre première aventure !';

  @override
  String get myTripsExploreTrips => 'Explorer les voyages';

  @override
  String get navHome => 'Accueil';

  @override
  String get navTrips => 'Voyages';

  @override
  String get navWishlist => 'Souhaits';

  @override
  String get navAccount => 'Compte';

  @override
  String get bookingContactInfoTitle => 'Informations de contact';

  @override
  String get bookingContactFullNameLabel => 'Nom complet';

  @override
  String get bookingContactFullNameHint => 'Saisissez votre nom complet';

  @override
  String get bookingContactPhoneLabel => 'Numéro de téléphone';

  @override
  String get bookingContactPhoneHint => '+20 123 456 7890';

  @override
  String get bookingContactEmailLabel => 'E-mail';

  @override
  String get bookingContactEmailHint => 'email@example.com';

  @override
  String get bookingContactEmergencyLabel => 'Contact d’urgence';

  @override
  String get bookingContactEmergencyHint => 'Numéro du contact d’urgence';

  @override
  String get bookingContactIdPassportLabel => 'Numéro d’ID/Passeport';

  @override
  String get bookingContactIdPassportHint =>
      'Saisissez votre numéro d’ID ou passeport';

  @override
  String get bookingContinue => 'Continuer';

  @override
  String get bookingAddNewCardTitle => 'Ajouter une nouvelle carte';

  @override
  String get bookingCardNumberLabel => 'Numéro de carte';

  @override
  String get bookingCardNumberHint => '0000 0000 0000 0000';

  @override
  String get bookingCardholderNameLabel => 'Nom du titulaire';

  @override
  String get bookingCardholderNameHint => 'John Doe';

  @override
  String get bookingExpiryDateLabel => 'Date d’expiration';

  @override
  String get bookingExpiryDateHint => 'MM/AA';

  @override
  String get bookingCvvLabel => 'CVV';

  @override
  String get bookingCvvHint => '***';

  @override
  String get bookingSaveCard => 'Enregistrer la carte';

  @override
  String get bookingCardholderNamePlaceholder => 'NOM DU TITULAIRE';

  @override
  String get bookingPaymentMethodTitle => 'Mode de paiement';

  @override
  String get bookingPaymentOptionCreditCard => 'Carte bancaire';

  @override
  String get bookingPaymentOptionCreditCardSubtitle =>
      'Payer avec Visa, Mastercard';

  @override
  String get bookingPaymentOptionPaypal => 'PayPal';

  @override
  String get bookingPaymentOptionPaypalSubtitle =>
      'Payer avec votre compte PayPal';

  @override
  String get bookingPaymentOptionApplePay => 'Apple Pay';

  @override
  String get bookingPaymentOptionApplePaySubtitle => 'Payer avec Apple Pay';

  @override
  String get bookingSavedCards => 'Cartes enregistrées';

  @override
  String get bookingAddNewCard => 'Ajouter une nouvelle carte';

  @override
  String bookingPayNow(Object amount) {
    return 'Payer maintenant - $amount';
  }

  @override
  String bookingCardExpires(Object expiry) {
    return 'Expire $expiry';
  }

  @override
  String get profilePersonalInfoTitle => 'Infos personnelles';

  @override
  String get profileFullNameLabel => 'Nom complet';

  @override
  String get profileEmailLabel => 'E-mail';

  @override
  String get profilePhoneNumberLabel => 'Numéro de téléphone';

  @override
  String get profilePasswordLabel => 'Mot de passe';

  @override
  String get profileCountryLabel => 'Pays';

  @override
  String get profileCityLabel => 'Ville';

  @override
  String get profileEditAction => 'Modifier';

  @override
  String get profileChangePasswordAction => 'Changer le mot de passe';

  @override
  String get profileGender => 'Genre';

  @override
  String get profileGenderMale => 'Homme';

  @override
  String get profileGenderFemale => 'Femme';

  @override
  String get profileDateOfBirth => 'Date de naissance';

  @override
  String get profileSaveChanges => 'Enregistrer';

  @override
  String get companyProfileCompanyName => 'Travel Egypt Co.';

  @override
  String companyProfileReviewsCountShort(Object count) {
    return '($count avis)';
  }

  @override
  String get companyProfileFollowing => 'Abonné';

  @override
  String get companyProfileFollow => 'Suivre';

  @override
  String get companyProfileStatsTrips => 'Voyages';

  @override
  String get companyProfileStatsReviews => 'Avis';

  @override
  String get companyProfileStatsFollowers => 'Abonnés';

  @override
  String get companyProfileAbout => 'À propos';

  @override
  String get companyProfileAboutDescription =>
      'Travel Egypt Co. est une agence de voyage leader spécialisée dans les tours et aventures en Égypte. Nous proposons des expériences uniques à travers l’Égypte, des pyramides antiques aux magnifiques stations balnéaires de la mer Rouge.';

  @override
  String get companyProfileTrips => 'Voyages';

  @override
  String get companyProfileReviews => 'Avis';

  @override
  String get companyProfileSeeAll => 'Voir tout';

  @override
  String get companyProfileTripName => 'Nom du voyage';

  @override
  String get companyProfileReviewAuthor => 'John Doe';

  @override
  String get companyProfileReviewDate => 'il y a 2 jours';

  @override
  String get companyProfileReviewComment =>
      'Super expérience ! Le voyage était très bien organisé et le guide était très professionnel.';

  @override
  String get filterTitle => 'Filtre';

  @override
  String get filterReset => 'Réinitialiser';

  @override
  String get filterDuration => 'Durée';

  @override
  String get filterTripType => 'Type de voyage';

  @override
  String get filterRating => 'Note';

  @override
  String get filterDepartureCity => 'Ville de départ';

  @override
  String get filterSelectCity => 'Sélectionner une ville';

  @override
  String get filterApply => 'Appliquer';

  @override
  String get destinationTitle => 'Destination';

  @override
  String get destinationSearchHint => 'Rechercher des destinations...';

  @override
  String get destinationRecentSearches => 'Recherches récentes';

  @override
  String get destinationClearAll => 'Tout effacer';

  @override
  String get destinationPopularDestinations => 'Destinations populaires';

  @override
  String searchTripsFound(Object count) {
    return '$count voyages trouvés';
  }

  @override
  String get searchQueryExample => 'Sharm El Sheikh';

  @override
  String get searchResultTitle => 'Résultats de recherche';

  @override
  String get searchResultSearchHint => 'Rechercher un voyage';

  @override
  String get searchResultSortBy => 'Trier par';

  @override
  String get searchResultFilters => 'Filtres';

  @override
  String get searchResultRating => '4.9';

  @override
  String get searchResultReviews => '(112)';

  @override
  String get searchResultFromCity => 'Depuis Le Caire';

  @override
  String get searchResultDateFrom => '27 Nov';

  @override
  String get searchResultDateTo => '4 Déc';

  @override
  String get searchResultLabelNew => 'Nouveau sur TripMarche';

  @override
  String get searchResultLabelRecommended => 'Recommandé';

  @override
  String get searchResultLabelBestPrice => 'Meilleur prix';

  @override
  String get searchResultOldPrice => '\$1000';

  @override
  String get searchResultDiscountPrice => '\$699';

  @override
  String get searchResultPerPerson => '/Personne';

  @override
  String get tripDetailsTitle => 'Voyage à Dahab';

  @override
  String get tripDetailsHeroCountryTag => 'Indonésie';

  @override
  String get tripDetailsHeroByCompany => 'Par l’agence de voyage';

  @override
  String get tripDetailsHeroFromLocation => 'Depuis Le Caire & Alexandrie';

  @override
  String get tripDetailsHeroDateRange => '27 nov → 4 déc';

  @override
  String get tripDetailsHeroFromPrefix => 'Depuis ';

  @override
  String tripDetailsHeroByCompanyLine(String company) {
    return 'Par $company';
  }

  @override
  String tripDetailsGalleryMoreCount(Object count) {
    return '+$count';
  }

  @override
  String imageGalleryPosition(int current, int total) {
    return '$current sur $total';
  }

  @override
  String get tripDetailsOverviewTitle => 'Aperçu du voyage';

  @override
  String get tripDetailsOverviewBody =>
      'Découvrez la beauté à couper le souffle des Alpes suisses lors de cette aventure de 7 jours. Visitez des destinations emblématiques, profitez de trajets en train panoramiques et plongez dans la culture suisse. Parfait pour les amoureux de la nature et de la photo.';

  @override
  String get tripDetailsWhatsIncludedTitle => 'Inclus';

  @override
  String get tripDetailsIncludedFlightTickets => 'Billets d’avion';

  @override
  String get tripDetailsIncludedHotelStay => 'Séjour à l’hôtel';

  @override
  String get tripDetailsIncludedBreakfast => 'Petit-déjeuner';

  @override
  String get tripDetailsIncludedAirportTransfer => 'Transfert aéroport';

  @override
  String get tripDetailsDepartureDetailsTitle => 'Détails du départ';

  @override
  String get tripDetailsMeetingLocationLabel => 'Lieu de rendez-vous';

  @override
  String get tripDetailsMeetingLocationValue =>
      '18 El Tesen Road, New Cairo, Égypte';

  @override
  String get tripDetailsReturnLocationLabel => 'Lieu de retour';

  @override
  String get tripDetailsReturnLocationValue =>
      '54 Ramses, Centre-ville, Égypte';

  @override
  String get tripDetailsMeetingTimeLabel => 'Heure de rendez-vous';

  @override
  String get tripDetailsMeetingTimeValue => '17:00';

  @override
  String get tripDetailsReturnTimeLabel => 'Heure de retour';

  @override
  String get tripDetailsReturnTimeValue => '21:30';

  @override
  String get tripDetailsProgramTitle => 'Programme du voyage';

  @override
  String get tripDetailsProgramMealsLabel => 'Repas';

  @override
  String get tripDetailsProgramDay1 => 'Jour 1';

  @override
  String get tripDetailsProgramDay2 => 'Jour 2';

  @override
  String get tripDetailsProgramCity1 => 'Pékin';

  @override
  String get tripDetailsProgramCity2 => 'Hangzhou';

  @override
  String get tripDetailsProgramDay1Item1 => 'Arrivée à l’aéroport de Changdu';

  @override
  String get tripDetailsProgramDay1Item2 => 'Vol domestique vers Pékin';

  @override
  String get tripDetailsProgramDay1Item3 => 'Check-in à l’hôtel';

  @override
  String get tripDetailsProgramDay1Item4 => 'Tour libre dans la rue Wangfujing';

  @override
  String get tripDetailsProgramDay2Item1 => 'Visite de la ville de Hangzhou';

  @override
  String get tripDetailsProgramDay2Item2 =>
      'Check-in à l’hôtel et visite du soir';

  @override
  String get tripDetailsProgramDay2Item3 => 'Visite du West Lake en croisière';

  @override
  String get tripDetailsProgramSeeAll => 'Voir tout le programme';

  @override
  String get tripDetailsAirlineLabel => 'Compagnie aérienne';

  @override
  String get tripDetailsAirlineName => 'Egyptair';

  @override
  String get tripDetailsFlightLeg1FromCity => 'Le Caire';

  @override
  String get tripDetailsFlightLeg1FromTime => '5:00';

  @override
  String get tripDetailsFlightLeg1ToCity => 'Paris';

  @override
  String get tripDetailsFlightLeg1ToTime => '7:20';

  @override
  String get tripDetailsFlightLeg1Date => '28 avril';

  @override
  String get tripDetailsFlightLeg2FromCity => 'Paris';

  @override
  String get tripDetailsFlightLeg2FromTime => '8:00';

  @override
  String get tripDetailsFlightLeg2ToCity => 'Le Caire';

  @override
  String get tripDetailsFlightLeg2ToTime => '5:20';

  @override
  String get tripDetailsFlightLeg2Date => '4 mai';

  @override
  String get tripDetailsTransportLeg1FromCity => 'Le Caire';

  @override
  String get tripDetailsTransportLeg1FromTime => '8:00';

  @override
  String get tripDetailsTransportLeg1ToCity => 'Paris';

  @override
  String get tripDetailsTransportLeg1ToTime => '5:20';

  @override
  String get tripDetailsTransportLeg1CenterLabel => 'Bus';

  @override
  String get tripDetailsTransportLeg1Date => '29 mai';

  @override
  String get tripDetailsTransportLeg2FromCity => 'Le Caire';

  @override
  String get tripDetailsTransportLeg2FromTime => '8:00';

  @override
  String get tripDetailsTransportLeg2ToCity => 'Paris';

  @override
  String get tripDetailsTransportLeg2ToTime => '5:20';

  @override
  String get tripDetailsTransportLeg2CenterLabel => 'Bateau';

  @override
  String get tripDetailsTransportLeg2Date => '29 mai';

  @override
  String get tripDetailsDestinationHurghada => 'Hurghada';

  @override
  String get tripDetailsDestinationParis => 'Paris';

  @override
  String get tripDetailsStatCitiesLabel => 'Nombre de villes';

  @override
  String get tripDetailsStatCitiesValue => '7 villes';

  @override
  String tripDetailsStatCitiesCount(int count) {
    return '$count villes';
  }

  @override
  String get tripDetailsPriceLabel => 'Prix';

  @override
  String get tripDetailsPerPersonSmall => 'par personne';

  @override
  String get tripDetailsBookingPriceDisplay => '1000.00';

  @override
  String get tripDetailsCompanyName => 'Travel Egypt Co.';

  @override
  String get tripDetailsCompanyTagline => 'Agence de voyage d’aventure';

  @override
  String get tripDetailsFollow => 'Suivre';

  @override
  String get tripDetailsDurationValue => '7 jours';

  @override
  String get tripDetailsDurationLabel => 'Durée';

  @override
  String get tripDetailsGroupSizeValue => '20-25';

  @override
  String get tripDetailsGroupSizeLabel => 'Taille du groupe';

  @override
  String get tripDetailsTypeValue => 'International';

  @override
  String get tripDetailsTypeLabel => 'Type';

  @override
  String get tripDetailsPerPerson => '/Personne';

  @override
  String get tripDetailsDescriptionTitle => 'Description';

  @override
  String get tripDetailsReadMore => ' Lire plus';

  @override
  String get tripDetailsShowLess => ' Réduire';

  @override
  String get tripDetailsDescriptionBody =>
      'Découvrez la magie de Dahab, une magnifique ville côtière située au sud-est de la péninsule du Sinaï en Égypte. Ce voyage de 7 jours comprend du snorkeling au Blue Hole, des safaris dans le désert, des balades à dos de chameau et des visites de villages bédouins anciens. Profitez des superbes récifs coralliens, des eaux cristallines et de paysages montagneux époustouflants. Nos guides expérimentés vous garantiront une aventure inoubliable avec des hébergements confortables et une délicieuse cuisine locale.';

  @override
  String get tripDetailsItineraryTitle => 'Itinéraire';

  @override
  String get tripDetailsIncludesTitle => 'Inclus';

  @override
  String get tripDetailsIncludesHotel => 'Hôtel';

  @override
  String get tripDetailsIncludesTransportation => 'Transport';

  @override
  String get tripDetailsIncludesMeals => 'Repas';

  @override
  String get tripDetailsIncludesActivities => 'Activités';

  @override
  String get tripDetailsIncludesTourGuide => 'Guide';

  @override
  String get tripDetailsImagesTitle => 'Images du voyage';

  @override
  String get tripDetailsReviewsTitle => 'Avis';

  @override
  String tripDetailsReviewsCount(Object count) {
    return '$count avis';
  }

  @override
  String get tripDetailsRelatedTripsTitle => 'Voyages similaires';

  @override
  String get tripDetailsTotalPrice => 'Prix total';

  @override
  String get tripDetailsBookNow => 'Réserver';

  @override
  String tripDetailsPricePerPersonShort(Object price) {
    return '$price/Personne';
  }

  @override
  String get tripDetailsDay1Title => 'Jour 1 - Arrivée & check-in';

  @override
  String get tripDetailsDay1Desc =>
      'Arrivée à Dahab, transfert à l’hôtel, dîner de bienvenue et réunion d’orientation avec le groupe.';

  @override
  String get tripDetailsDay2Title => 'Jour 2 - Snorkeling Blue Hole';

  @override
  String get tripDetailsDay2Desc =>
      'Journée complète de snorkeling au célèbre Blue Hole. Déjeuner dans un restaurant en bord de mer. Soirée libre.';

  @override
  String get tripDetailsDay3Title => 'Jour 3 - Safari dans le désert';

  @override
  String get tripDetailsDay3Desc =>
      'Safari en jeep dans le désert du Sinaï. Visite d’un village bédouin. Dîner et observation des étoiles dans le désert.';

  @override
  String get tripDetailsDay4Title => 'Jour 4 - Journée libre & activités';

  @override
  String get tripDetailsDay4Desc =>
      'Choisissez des activités optionnelles : plongée, balades à dos de chameau ou découverte des marchés locaux.';

  @override
  String get tripDetailsDay5Title => 'Jour 5 - Randonnée du mont Sinaï';

  @override
  String get tripDetailsDay5Desc =>
      'Randonnée tôt le matin pour le lever du soleil au mont Sinaï. Visite du monastère Sainte-Catherine.';

  @override
  String get tripDetailsDay6Title => 'Jour 6 - Sports nautiques';

  @override
  String get tripDetailsDay6Desc =>
      'Cours de windsurf et kitesurf. Dîner d’adieu dans un restaurant au bord de la mer.';

  @override
  String get tripDetailsDay7Title => 'Jour 7 - Départ';

  @override
  String get tripDetailsDay7Desc =>
      'Petit-déjeuner à l’hôtel. Check-out et transfert à l’aéroport.';

  @override
  String get tripDetailsRelatedNameSharm => 'Sharm El Sheikh';

  @override
  String get tripDetailsRelatedNameHurghada => 'Voyage Hurghada';

  @override
  String get tripDetailsRelatedNameLuxorAswan => 'Louxor & Assouan';

  @override
  String get tripDetailsHeroRatingLine => '4.5 (120 avis)';

  @override
  String get tripDetailsHeroLocationShort => 'Dahab, Égypte';

  @override
  String get tripDetailsHeroDaysBadge => '7 jours';

  @override
  String get tripDetailsOut => 'Aller';

  @override
  String get tripDetailsIn => 'Retour';

  @override
  String get tripDetailsOutSummaryLine1 => '21 mai, vendredi';

  @override
  String get tripDetailsOutSummaryLine2 =>
      'Aéroport international du Caire (CAI)';

  @override
  String get tripDetailsInSummaryLine1 => '27 mai, jeudi';

  @override
  String get tripDetailsInSummaryLine2 => 'Dahab, Sud-Sinaï';

  @override
  String get tripDetailsTripDescriptionTitle => 'Description du voyage';

  @override
  String get tripDetailsAmenitiesTitle => 'Équipements';

  @override
  String get tripDetailsAmenityHotelStars => 'Hôtel 4 étoiles';

  @override
  String get tripDetailsAmenityFoodBar => 'Bar de nourriture';

  @override
  String get tripDetailsAmenityBusTrip => 'Voyage en bus';

  @override
  String get tripDetailsAmenityTourGuide => 'Guide';

  @override
  String get tripDetailsAccommodationTitle => 'Hébergement';

  @override
  String get tripDetailsAccommodationHotelNameLabel => 'Nom de l’hôtel';

  @override
  String get tripDetailsHotelName => 'Le Meridien Dahab Resort';

  @override
  String get tripDetailsHotelRatingStars => '5.0';

  @override
  String get tripDetailsAccommodationHotelLocationLabel =>
      'Emplacement de l’hôtel';

  @override
  String get tripDetailsHotelAddress => 'Blue Hole Road, Dahab, Égypte';

  @override
  String get tripDetailsCheckInOut => 'Arrivée 14:00 · Départ 11:00';

  @override
  String get tripDetailsViewMap => 'Voir la carte';

  @override
  String get tripDetailsSeeAllAccommodation => 'Voir tous les hébergements';

  @override
  String get tripDetailsViewFullItinerary => 'Voir l’itinéraire complet';

  @override
  String get tripDetailsFlightDetailsTitle => 'Détails du vol';

  @override
  String get tripDetailsTransportationTitle => 'Transport';

  @override
  String get tripDetailsFlightLegSummary => 'CAI → SSH · EgyptAir · 1 h 10';

  @override
  String get tripDetailsTrainLegSummary => 'Retour · Le Caire · 8 h 30';

  @override
  String get tripDetailsDestinationsTitle => 'Destinations';

  @override
  String get tripDetailsDestinationDahab => 'Dahab';

  @override
  String get tripDetailsDestinationNuweiba => 'Nuweiba';

  @override
  String get tripDetailsDestinationDetailsTitle => 'Détails de la destination';

  @override
  String get tripDetailsDestinationVisaLabel => 'Visa';

  @override
  String get tripDetailsDestinationVisaValue => 'Visa requis';

  @override
  String get tripDetailsDestinationRequiredVaccinesLabel => 'Vaccins requis';

  @override
  String get tripDetailsDestinationRequiredVaccinesValue => '+201026329736';

  @override
  String get tripDetailsDestinationTimeLabel => 'Heure';

  @override
  String get tripDetailsDestinationTimeValue => 'GMT+1';

  @override
  String get tripDetailsDestinationLanguageLabel => 'Langue';

  @override
  String get tripDetailsDestinationLanguageValue => 'Anglais';

  @override
  String get tripDetailsDestinationCurrencyLabel => 'Devise';

  @override
  String get tripDetailsDestinationCurrencyValue => 'Euro (EUR)';

  @override
  String get tripDetailsDestinationTemperatureLabel => 'Température';

  @override
  String get tripDetailsDestinationTemperatureValue => '25°C';

  @override
  String get tripDetailsDestinationPublicTransportationLabel =>
      'Transports publics';

  @override
  String get tripDetailsDestinationPublicTransportationValue => 'Bus';

  @override
  String get tripDetailsDestinationTaxiAppsLabel => 'Applications de taxi';

  @override
  String get tripDetailsDestinationTaxiAppsValue => 'Uber, InDrive';

  @override
  String get tripDetailsIncludesExcludesTitle => 'Inclus & non inclus';

  @override
  String get tripDetailsExcludesTitle => 'Non inclus';

  @override
  String get tripDetailsExcludeVisa => 'Frais de visa';

  @override
  String get tripDetailsExcludeAlcohol => 'Boissons alcoolisées';

  @override
  String get tripDetailsSeeAllPhotos => 'Voir toutes les photos';

  @override
  String get tripDetailsActivityPlansTitle => 'Plans d’activités';

  @override
  String get tripDetailsActivitySnorkel => 'Snorkeling Blue Hole';

  @override
  String get tripDetailsActivitySnorkelPrice => 'EGP 500';

  @override
  String get tripDetailsActivitySafari => 'Safari dans le désert';

  @override
  String get tripDetailsActivitySafariPrice => 'EGP 350';

  @override
  String get tripDetailsActivityDiving => 'Session de plongée d’initiation';

  @override
  String get tripDetailsActivityDivingPrice => 'EGP 800';

  @override
  String get tripDetailsAdd => 'Ajouter';

  @override
  String get tripDetailsAdded => 'Ajouté';

  @override
  String get tripDetailsViewAllActivities => 'Voir toutes les activités';

  @override
  String get tripDetailsActivityRateTitle => 'Note des activités';

  @override
  String get tripDetailsActivityRateLuxury => 'niveau de luxe';

  @override
  String get tripDetailsActivityRateShopping => 'Shopping';

  @override
  String get tripDetailsActivityRateNightOutings => 'Sorties nocturnes';

  @override
  String get tripDetailsSeeAllActivities => 'Voir toutes les activités';

  @override
  String get tripDetailsVisaDetailsTitle => 'Détails du visa';

  @override
  String get tripDetailsTripInstructionsTitle => 'Consignes de voyage';

  @override
  String get tripDetailsSafetyProceduresTitle => 'Procédures de sécurité';

  @override
  String get tripDetailsCompanySectionTitle => 'Entreprise';

  @override
  String get tripDetailsViewAll => 'Voir tout';

  @override
  String get tripDetailsReviewCountry => 'Espagne';

  @override
  String get tripDetailsCompanyRatingValue => '4.9';

  @override
  String get tripDetailsCompanyRatingCount => '112';

  @override
  String get tripDetailsPolicyCancellation => 'Politique d’annulation';

  @override
  String get tripDetailsPolicyInsurance => 'Assurance voyage';

  @override
  String get tripDetailsPolicyTerms => 'Conditions générales';

  @override
  String get tripDetailsPolicyFaqs => 'Questions fréquentes';

  @override
  String get tripDetailsSeeAllReviews => 'Voir tout';

  @override
  String get tripDetailsOrganizerTitle => 'Organisateur';

  @override
  String get tripDetailsOrganizerSubtitle =>
      'Partenaire de confiance sur Trip Marche';

  @override
  String get tripDetailsStartingFrom => 'À partir de';

  @override
  String get tripDetailsBookingFromPrice => 'EGP 5,000';

  @override
  String get tripDetailsItineraryLoc1 => 'Pékin';

  @override
  String get tripDetailsItineraryActs1 =>
      '• Check-in à l’hôtel\n• Marche d’orientation\n• Dîner de bienvenue';

  @override
  String get tripDetailsItineraryLoc2 => 'Hangzhou';

  @override
  String get tripDetailsItineraryActs2 =>
      '• Croisière sur West Lake\n• Visite d’une plantation de thé\n• Soirée libre';

  @override
  String get tripDetailsReviewSampleName => 'Ahmed Hassan';

  @override
  String get tripDetailsReviewSampleDate => 'Déc 2025';

  @override
  String get tripDetailsReviewSampleBody =>
      'Voyage incroyable ! Très bonne organisation et guides sympathiques. La journée snorkeling était inoubliable.';

  @override
  String get bookingTripTermsTitle => 'Conditions générales';

  @override
  String get bookingTripTermsHeader => 'Conditions générales du voyage';

  @override
  String bookingTripTermsLastUpdated(Object date) {
    return 'Dernière mise à jour : $date';
  }

  @override
  String get bookingTripTermsSection1Title => '1. Réservation & paiement';

  @override
  String get bookingTripTermsSection1Body =>
      'En réservant un voyage via Trip Marche, vous acceptez les conditions suivantes. Un acompte de 30% est requis au moment de la réservation pour confirmer votre place. Le solde restant doit être payé au moins 14 jours avant la date de départ. Un retard de paiement peut entraîner l’annulation de la réservation. Tous les paiements sont traités de manière sécurisée via nos partenaires.';

  @override
  String get bookingTripTermsSection2Title => '2. Éligibilité';

  @override
  String get bookingTripTermsSection2Body =>
      'Les participants doivent avoir au moins 18 ans pour réserver de manière autonome. Les voyageurs de moins de 18 ans doivent être accompagnés d’un parent ou tuteur légal. Certaines activités peuvent imposer des exigences d’âge ou de santé. Il est de la responsabilité du voyageur de répondre aux critères et de disposer des documents nécessaires.';

  @override
  String get bookingTripTermsSection3Title => '3. Modifications du voyage';

  @override
  String get bookingTripTermsSection3Body =>
      'Trip Marche se réserve le droit de modifier l’itinéraire en raison des conditions météorologiques, de la sécurité ou d’autres circonstances imprévues. Nous ferons tout notre possible pour proposer des alternatives équivalentes. En cas de changements importants, les voyageurs seront informés et pourront bénéficier d’un remboursement partiel ou d’un crédit.';

  @override
  String get bookingTripTermsSection4Title => '4. Responsabilités du voyageur';

  @override
  String get bookingTripTermsSection4Body =>
      'Les voyageurs sont responsables de posséder des documents de voyage valides, une assurance appropriée et toute vaccination requise. Ils doivent suivre les instructions des guides et respecter les lois et coutumes locales. Trip Marche n’est pas responsable des conséquences liées au non-respect des exigences d’entrée.';

  @override
  String get bookingTripTermsSection5Title => '5. Responsabilité';

  @override
  String get bookingTripTermsSection5Body =>
      'Trip Marche agit en tant qu’organisateur et intermédiaire. Malgré toutes les précautions, nous ne sommes pas responsables des pertes, blessures ou dommages résultant des activités pendant le voyage, d’événements naturels ou des actions de prestataires tiers. La participation se fait aux risques du voyageur. Nous recommandons fortement une assurance voyage complète.';

  @override
  String get bookingTripTermsSection6Title => '6. Confidentialité';

  @override
  String get bookingTripTermsSection6Body =>
      'Les informations personnelles collectées lors de la réservation sont utilisées uniquement pour l’organisation du voyage et la communication. Nous ne partageons pas vos informations avec des tiers sauf si nécessaire pour exécuter la réservation. Pour plus de détails, consultez notre politique de confidentialité.';

  @override
  String get bookingTripTermsSection7Title => '7. Résolution des litiges';

  @override
  String get bookingTripTermsSection7Body =>
      'Tout litige découlant de ces conditions sera résolu par négociation amiable. En cas d’échec, les litiges seront soumis aux tribunaux compétents. Ces conditions sont régies par les lois de la République arabe d’Égypte.';

  @override
  String get bookingTripInstructionsTitle => 'Consignes de voyage';

  @override
  String get bookingTripInstructionsHeader => 'Avant de partir';

  @override
  String get bookingTripInstructionsIntro =>
      'Veuillez lire attentivement les consignes suivantes afin de garantir une expérience de voyage agréable. Une bonne préparation vous aidera à profiter au maximum de votre aventure à Dahab.';

  @override
  String get bookingTripInstructionsWhatToPack => 'Quoi emporter';

  @override
  String get bookingTripInstructionsMeetingPointTime =>
      'Point & heure de rendez-vous';

  @override
  String get bookingTripInstructionsDocumentsToBring => 'Documents à apporter';

  @override
  String get bookingTripInstructionsImportantReminders => 'Rappels importants';

  @override
  String get bookingTripSafetyTitle => 'Sécurité du voyage';

  @override
  String get bookingTripSafetyBanner =>
      'Votre sécurité est notre priorité. Veuillez lire attentivement les consignes suivantes.';

  @override
  String get bookingTripSafetyHeader => 'Procédures de sécurité';

  @override
  String get bookingTripSafetyIntro =>
      'Chez Trip Marche, nous nous engageons à assurer la sécurité et le bien-être de tous nos voyageurs. Nos voyages sont conçus avec des mesures de sécurité complètes et tous nos guides sont formés aux premiers secours et aux procédures d’urgence.';

  @override
  String get bookingTripSafetyWaterTitle => 'Sécurité des activités aquatiques';

  @override
  String get bookingTripSafetyDesertTitle => 'Sécurité dans le désert';

  @override
  String get bookingTripSafetyHealthTitle => 'Santé & médical';

  @override
  String get bookingTripSafetyEmergencyTitle => 'Contacts d’urgence';

  @override
  String get bookingTripSafetyGeneralTipsTitle =>
      'Conseils généraux de sécurité';

  @override
  String get authResetPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get authResetPasswordSubtitle =>
      'Saisissez votre nouveau mot de passe ci-dessous';

  @override
  String get authNewPasswordLabel => 'Nouveau mot de passe';

  @override
  String get authNewPasswordHint => 'Saisissez le nouveau mot de passe';

  @override
  String get authConfirmNewPasswordLabel => 'Confirmer le nouveau mot de passe';

  @override
  String get authConfirmNewPasswordHint => 'Confirmez le nouveau mot de passe';

  @override
  String get authResetPasswordButton => 'Réinitialiser le mot de passe';

  @override
  String get tripDetailsDurationUnit => 'Jours';

  @override
  String get tripDetailsProgramDayPrefix => 'Jour';

  @override
  String get tripDetailsTypeDomestic => 'National';

  @override
  String get tripDetailsPayOnArrival => 'Paiement à l\'arrivée';

  @override
  String get tripDetailsFailedToLoad =>
      'Impossible de charger les détails du voyage.';

  @override
  String get tripDetailsTryAgain => 'Réessayer';

  @override
  String get tripDetailsNoFlights =>
      'Les détails du vol apparaîtront ici lorsqu\'ils seront disponibles.';

  @override
  String get tripDetailsNoTransport =>
      'Les détails de transport terrestre ou maritime apparaîtront ici lorsqu\'ils seront disponibles.';

  @override
  String get tripDetailsVisaAndEntryTitle => 'Visa et entrée';
}
