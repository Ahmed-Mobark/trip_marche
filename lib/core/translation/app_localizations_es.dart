// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get errorFieldRequired => 'Este campo es obligatorio';

  @override
  String get errorInvalidName => 'Formato de nombre inválido';

  @override
  String get errorInvalidUrl => 'URL inválida';

  @override
  String get errorInvalidPhoneNumber => 'Número de teléfono inválido';

  @override
  String get errorInvalidEmail => 'Dirección de correo inválida';

  @override
  String get errorInvalidPassword =>
      'La contraseña debe tener al menos 8 caracteres e incluir mayúsculas, minúsculas y caracteres especiales';

  @override
  String get errorPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get errorInvalidNumber => 'Número inválido';

  @override
  String get errorInvalidIban => 'Formato de IBAN inválido';

  @override
  String get errorInvalidMobileNumber => 'Número de móvil inválido';

  @override
  String get errorInvalidStcPayId => 'ID de STC Pay inválido';

  @override
  String get errorInvalidNationalId => 'ID nacional inválido';

  @override
  String get errorInvalidPassport => 'Número de pasaporte inválido';

  @override
  String get sorryMessage => 'Lo sentimos';

  @override
  String get nothingFound => 'No se encontró nada';

  @override
  String errorPhoneValidation(Object length, Object start) {
    return 'El número de teléfono debe comenzar con $start y tener $length dígitos.';
  }

  @override
  String get errorExperienceRequired =>
      'Debes añadir al menos una experiencia.';

  @override
  String get errorIdDocumentRequired =>
      'Debes subir un documento de identidad para verificar tu identidad.';

  @override
  String get errorPhotoRequired => 'Debes subir una foto con fondo blanco';

  @override
  String get updateAvailableTitle => 'Actualización disponible';

  @override
  String get updateMandatoryMessage =>
      'Hay una nueva versión de la app disponible. Actualiza para continuar usando la app.';

  @override
  String get updateOptionalMessage =>
      'Hay una nueva versión de la app disponible. Recomendamos actualizar para una mejor experiencia.';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get skip => 'Saltar';

  @override
  String get chooseImage => 'Subir: elegir imagen';

  @override
  String get takePicture => 'Subir: tomar foto';

  @override
  String get chooseFromFiles => 'Subir: elegir desde archivos';

  @override
  String get updatePleaseUpdateToContinue => 'Actualiza la app para continuar.';

  @override
  String get updateNewVersionAvailableShort =>
      'Hay una nueva versión disponible.';

  @override
  String get authLoginTitle => 'Inicia sesión en tu cuenta';

  @override
  String get authEmailLabel => 'Correo electrónico';

  @override
  String get authEmailHint => 'Introduce tu correo';

  @override
  String get authPasswordLabel => 'Contraseña';

  @override
  String get authPasswordHint => 'Introduce tu contraseña';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authLoginButton => 'Iniciar sesión';

  @override
  String get authNoAccountPrompt => '¿No tienes una cuenta? ';

  @override
  String get authCreateOne => 'Crear una';

  @override
  String get authOrLoginWith => 'O inicia sesión con';

  @override
  String get authContinueWithGoogle => 'Continuar con Google';

  @override
  String get authContinueWithApple => 'Continuar con Apple';

  @override
  String get authTravelAgencyPrompt => '¿Proveedor o agencia de viajes? ';

  @override
  String get authJoinAsTripPartner => 'Únete como proveedor';

  @override
  String get authPartnerPortalTitle => 'Portal de socios';

  @override
  String get authWebViewLoadFailed =>
      'No se pudo cargar esta página. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get authWebViewRetry => 'Reintentar';

  @override
  String get authSignUpTitle => 'Crea tu cuenta';

  @override
  String get authSignUpSubtitle => 'Regístrate para comenzar';

  @override
  String get authFullNameLabel => 'Nombre completo';

  @override
  String get authFullNameHint => 'Introduce tu nombre completo';

  @override
  String get authPhoneLabel => 'Número de teléfono';

  @override
  String get authPhoneHint => 'Introduce tu número de teléfono';

  @override
  String get authConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get authConfirmPasswordHint => 'Confirma tu contraseña';

  @override
  String get authSignUpButton => 'Registrarse';

  @override
  String get authOrSignUpWith => 'O regístrate con';

  @override
  String get authSocialGoogle => 'Google';

  @override
  String get authSocialApple => 'Apple';

  @override
  String get authHaveAccountPrompt => '¿Ya tienes una cuenta? ';

  @override
  String get authLoginAction => 'Iniciar sesión';

  @override
  String get authForgotPasswordTitle => 'Olvidé mi contraseña';

  @override
  String get authForgotPasswordDescription =>
      'Introduce tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.';

  @override
  String get authForgotPasswordSubtitle =>
      '¿La olvidaste? Vamos a solucionarlo.';

  @override
  String get authSendButton => 'Enviar';

  @override
  String get authSendCodeButton => 'Enviar código';

  @override
  String get authVerifyTitle => 'Verifica tu número';

  @override
  String get authVerifyDescription =>
      'Hemos enviado un código OTP a tu número registrado. Introduce el código a continuación.';

  @override
  String get authVerifyButton => 'Verificar';

  @override
  String get authBack => 'Atrás';

  @override
  String get authResendCode => 'Reenviar código';

  @override
  String get authVerifyEmailTitle => 'Verifica tu correo';

  @override
  String get authVerifyEmailSubtitle =>
      'Te enviamos un código de 6 dígitos para verificar tu número';

  @override
  String get authVerificationCodeNotReceived => '¿No recibiste el código?';

  @override
  String get authResendNow => 'Reenviar ahora';

  @override
  String get homeAppTitle => 'TripMarche';

  @override
  String get homeSearchHint => 'Buscar un viaje';

  @override
  String homeSearchHintDestination(Object destination) {
    return 'Buscar un viaje a $destination';
  }

  @override
  String get homeLocationText => 'El Cairo, Egipto';

  @override
  String get homeTrendingDestinations => 'Destinos en tendencia';

  @override
  String get homeTrendingDestinationsSearchHint => 'Buscar destinos';

  @override
  String get homeViewAll => 'Ver todo';

  @override
  String get homePopularTrips => 'Viajes populares';

  @override
  String get homeSponsoredTrips => 'Viajes patrocinados';

  @override
  String get homeDomesticTripsInEgypt => 'Viajes nacionales en Egipto';

  @override
  String get homeInternationalTripsFromEgypt =>
      'Viajes internacionales desde Egipto';

  @override
  String get homeRecommendedForYou => 'Recomendado para ti';

  @override
  String get homeSpecialTrips => 'Viajes especiales';

  @override
  String get homeTopRated => 'Mejor valorados';

  @override
  String get homeFromCairoAlexandria => 'Desde El Cairo y Alejandría';

  @override
  String get homeNewInTripMarche => 'Nuevo en TripMarche';

  @override
  String get homePerPerson => 'Persona';

  @override
  String get homeSeeAll => 'Ver todo';

  @override
  String get wishlistTitle => 'Lista de deseos';

  @override
  String get wishlistSearchHint => 'Buscar un viaje';

  @override
  String get wishlistSortBy => 'Ordenar por';

  @override
  String get wishlistFilters => 'Filtros';

  @override
  String get wishlistNewInTripMarche => 'Nuevo en TripMarche';

  @override
  String get wishlistRecommended => 'Recomendado';

  @override
  String get wishlistBestPrice => 'Mejor precio';

  @override
  String get wishlistEmptyTitle => 'Aún no hay viajes guardados';

  @override
  String get wishlistEmptyDescription =>
      'Toca el icono del corazón en cualquier viaje para\nguardarlo en tu lista de deseos.';

  @override
  String get wishlistFiltersTitle => 'Filtros';

  @override
  String get wishlistFiltersClearAll => 'Borrar todo';

  @override
  String get wishlistFiltersDestination => 'Destino';

  @override
  String get wishlistFiltersSelectDestination => 'Seleccionar';

  @override
  String get wishlistFiltersPriceRange => 'Rango de precios';

  @override
  String get wishlistFiltersTripType => 'Tipo de viaje';

  @override
  String get wishlistFiltersDomestic => 'Nacional';

  @override
  String get wishlistFiltersInternational => 'Internacional';

  @override
  String get wishlistFiltersDepartureCountry => 'País de salida';

  @override
  String get wishlistFiltersDepartureCity => 'Ciudad de salida';

  @override
  String get wishlistFiltersSelectCountry => 'Seleccionar';

  @override
  String get wishlistFiltersSelectCity => 'Seleccionar';

  @override
  String get wishlistFiltersTripMonth => 'Mes del viaje';

  @override
  String get wishlistFiltersSelectMonth => 'Seleccionar';

  @override
  String get wishlistFiltersActions => 'Actividades';

  @override
  String get wishlistFiltersSelectAction => 'Seleccionar';

  @override
  String get wishlistFiltersTravelAgency => 'Agencia de viajes';

  @override
  String get wishlistFiltersAgencyNameHint => 'Nombre de la agencia';

  @override
  String get wishlistFiltersAgencyRating => 'Valoración de la agencia';

  @override
  String get wishlistFiltersOtherCountries => 'Otros países';

  @override
  String get wishlistFiltersOtherCities => 'Otras ciudades';

  @override
  String get wishlistFiltersSelectCountries => 'Seleccionar';

  @override
  String get wishlistFiltersSelectCities => 'Seleccionar';

  @override
  String get wishlistFiltersNumberOfCities => 'Número de ciudades';

  @override
  String get wishlistFiltersNumberOfCountries => 'Número de países';

  @override
  String get wishlistFiltersDuration => 'Duración';

  @override
  String get wishlistFiltersDurationUpTo3 => 'Hasta 3 días';

  @override
  String get wishlistFiltersDurationUpTo7 => 'Hasta 7 días';

  @override
  String get wishlistFiltersDuration7Plus => '+7 días';

  @override
  String get wishlistFiltersGroupSize => 'Tamaño del grupo';

  @override
  String get wishlistFiltersGroupSizeSmall => 'Hasta 10';

  @override
  String get wishlistFiltersGroupSizeUpTo20 => 'Hasta 20';

  @override
  String get wishlistFiltersGroupSize20Plus => '20+';

  @override
  String get wishlistFiltersTripSeason => 'Temporada del viaje';

  @override
  String get wishlistFiltersSeasonSpring => 'Primavera';

  @override
  String get wishlistFiltersSeasonHajj => 'Hajj';

  @override
  String get wishlistFiltersSeasonNewYear => 'Año nuevo';

  @override
  String get wishlistFiltersTripFeatures => 'Características del viaje';

  @override
  String get wishlistFiltersFeatureIncludeFlight => 'Incluye vuelo';

  @override
  String get wishlistFiltersFeatureIncludeHotel => 'Incluye hotel';

  @override
  String get wishlistFiltersFeatureFreeMeal => 'Comida gratis';

  @override
  String get wishlistFiltersFeatureVisaOnArrival => 'Visado a la llegada';

  @override
  String get wishlistFiltersTripRating => 'Valoración del viaje';

  @override
  String get wishlistFiltersDiscountCode =>
      'El viaje aplica código de descuento';

  @override
  String get wishlistFiltersFreeCancellation => 'Cancelación gratuita';

  @override
  String get filterSeeResults => 'Ver resultados';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsNotificationSetting => 'Ajustes de notificaciones';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsCurrency => 'Moneda';

  @override
  String get settingsEnglish => 'Inglés';

  @override
  String get settingsArabic => 'Árabe';

  @override
  String get settingsDarkMode => 'Modo oscuro';

  @override
  String settingsAppVersion(Object version) {
    return 'Versión de la app $version';
  }

  @override
  String get notificationSettingsTitle => 'Ajustes de notificaciones';

  @override
  String get notificationSettingsIntro =>
      'Gestiona tus preferencias de notificación para estar al día de nuevos viajes, ofertas y actualizaciones de reserva.';

  @override
  String get notificationSettingsBookingUpdatesTitle =>
      'Actualizaciones de reserva';

  @override
  String get notificationSettingsBookingUpdatesSubtitle =>
      'Recibe actualizaciones en tiempo real sobre confirmaciones, cancelaciones y cambios en tus reservas.';

  @override
  String get notificationSettingsToursTitle => 'Tours';

  @override
  String get notificationSettingsToursSubtitle =>
      'Recibe notificaciones cuando se añadan nuevos viajes o tours que coincidan con tus intereses.';

  @override
  String get notificationSettingsReviewsTitle => 'Reseñas';

  @override
  String get notificationSettingsReviewsSubtitle =>
      'Recibe avisos cuando alguien responda a tu reseña o cuando te inviten a reseñar un viaje que hayas realizado.';

  @override
  String get notificationSettingsPromotionsSubtitle =>
      'Accede a descuentos especiales, ofertas por tiempo limitado y promociones de temporada.';

  @override
  String get notificationSettingsPush => 'Notificaciones push';

  @override
  String get notificationSettingsEmail => 'Notificaciones por correo';

  @override
  String get notificationSettingsTripUpdates => 'Actualizaciones del viaje';

  @override
  String get notificationSettingsPromotions => 'Promociones';

  @override
  String get notificationSettingsPriceAlerts => 'Alertas de precio';

  @override
  String get profileTitleAccount => 'Cuenta';

  @override
  String get profileTitleSupport => 'Soporte';

  @override
  String get profilePersonalInfo => 'Información personal';

  @override
  String get profilePaymentMethod => 'Método de pago';

  @override
  String get profileMyReviews => 'Mis reseñas';

  @override
  String get profileAddReview => 'Añadir reseña';

  @override
  String get profileReviewLabel => 'Reseña';

  @override
  String get profileProductRatingLabel => 'Valoración del producto';

  @override
  String get profileMyReviewsRoute => 'El Cairo → Dahab';

  @override
  String get profileFollowingCompanies => 'Empresas seguidas';

  @override
  String get profileSettings => 'Ajustes';

  @override
  String get profileCustomerService => 'Atención al cliente';

  @override
  String get profileFaqs => 'Preguntas frecuentes';

  @override
  String get profileTermsAndConditions => 'Términos y condiciones';

  @override
  String get profileDeleteAccount => 'Eliminar cuenta';

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String profileTripsBooked(Object count) {
    return '$count viajes reservados';
  }

  @override
  String get profileDeleteAccountTitle => 'Eliminar cuenta';

  @override
  String get profileDeleteAccountMessage =>
      '¿Seguro que quieres eliminar tu cuenta? Esta acción no se puede deshacer.';

  @override
  String get profileLogoutConfirmTitle => 'Cerrar sesión';

  @override
  String get profileLogoutConfirmMessage =>
      '¿Seguro que quieres cerrar sesión?';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get followingsTitle => 'Mis seguidos';

  @override
  String followingsCountTitle(Object count) {
    return '$count seguidos';
  }

  @override
  String get followingsUnfollow => 'Dejar de seguir';

  @override
  String get followingsEmptyTitle => 'Aún no sigues a nadie';

  @override
  String get followingsEmptyDescription =>
      'Empieza a seguir empresas para ver\nsus viajes aquí.';

  @override
  String get myTripsTitle => 'Mis viajes';

  @override
  String get myTripsTabUpcoming => 'Próximos';

  @override
  String get myTripsTabPast => 'Pasados';

  @override
  String get myTripsSearchHint => 'Buscar un viaje';

  @override
  String get myTripsCatalogTripsOf => 'Viajes a';

  @override
  String myTripsCatalogReviewCountInline(int count) {
    return '($count)';
  }

  @override
  String get myTripsCatalogSaveWishlist => 'Guardar en favoritos';

  @override
  String get myTripsCatalogRemoveWishlist => 'Quitar de favoritos';

  @override
  String get myTripsTabActive => 'Activo';

  @override
  String get myTripsTabPastNew => 'Pasados';

  @override
  String get myTripsTabCanceled => 'Cancelados';

  @override
  String get myTripsStatusActive => 'Activo';

  @override
  String get myTripsStatusPast => 'Pasado';

  @override
  String get myTripsStatusCanceled => 'Cancelado';

  @override
  String get myTripsBookAgain => 'Reservar de nuevo';

  @override
  String get myTripsFromPrefix => 'Desde';

  @override
  String get myTripsViewDetails => 'Ver detalles';

  @override
  String get myTripsViewReceipt => 'Ver recibo';

  @override
  String get myTripsBookingDetails => 'Detalles de la reserva';

  @override
  String get myTripsDownloadPdf => 'Descargar PDF';

  @override
  String get myTripsEmptyTitle => 'Aún no hay viajes';

  @override
  String get myTripsEmptyDescription =>
      'Empieza a explorar y reserva\n¡tu primera aventura!';

  @override
  String get myTripsExploreTrips => 'Explorar viajes';

  @override
  String get navHome => 'Inicio';

  @override
  String get navTrips => 'Viajes';

  @override
  String get navWishlist => 'Lista de deseos';

  @override
  String get navAccount => 'Cuenta';

  @override
  String get bookingContactInfoTitle => 'Información de contacto';

  @override
  String get bookingContactFullNameLabel => 'Nombre completo';

  @override
  String get bookingContactFullNameHint => 'Introduce tu nombre completo';

  @override
  String get bookingContactPhoneLabel => 'Número de teléfono';

  @override
  String get bookingContactPhoneHint => '+20 123 456 7890';

  @override
  String get bookingContactEmailLabel => 'Correo electrónico';

  @override
  String get bookingContactEmailHint => 'email@example.com';

  @override
  String get bookingContactEmergencyLabel => 'Contacto de emergencia';

  @override
  String get bookingContactEmergencyHint => 'Número de contacto de emergencia';

  @override
  String get bookingContactIdPassportLabel => 'Número de ID/Pasaporte';

  @override
  String get bookingContactIdPassportHint =>
      'Introduce tu número de ID o pasaporte';

  @override
  String get bookingContinue => 'Continuar';

  @override
  String get bookingAddNewCardTitle => 'Añadir nueva tarjeta';

  @override
  String get bookingCardNumberLabel => 'Número de tarjeta';

  @override
  String get bookingCardNumberHint => '0000 0000 0000 0000';

  @override
  String get bookingCardholderNameLabel => 'Titular de la tarjeta';

  @override
  String get bookingCardholderNameHint => 'John Doe';

  @override
  String get bookingExpiryDateLabel => 'Fecha de caducidad';

  @override
  String get bookingExpiryDateHint => 'MM/AA';

  @override
  String get bookingCvvLabel => 'CVV';

  @override
  String get bookingCvvHint => '***';

  @override
  String get bookingSaveCard => 'Guardar tarjeta';

  @override
  String get bookingCardholderNamePlaceholder => 'NOMBRE DEL TITULAR';

  @override
  String get bookingPaymentMethodTitle => 'Método de pago';

  @override
  String get bookingPaymentOptionCreditCard => 'Tarjeta de crédito';

  @override
  String get bookingPaymentOptionCreditCardSubtitle =>
      'Paga con Visa, Mastercard';

  @override
  String get bookingPaymentOptionPaypal => 'PayPal';

  @override
  String get bookingPaymentOptionPaypalSubtitle =>
      'Paga con tu cuenta de PayPal';

  @override
  String get bookingPaymentOptionApplePay => 'Apple Pay';

  @override
  String get bookingPaymentOptionApplePaySubtitle => 'Paga con Apple Pay';

  @override
  String get bookingSavedCards => 'Tarjetas guardadas';

  @override
  String get bookingAddNewCard => 'Añadir nueva tarjeta';

  @override
  String bookingPayNow(Object amount) {
    return 'Pagar ahora - $amount';
  }

  @override
  String bookingCardExpires(Object expiry) {
    return 'Caduca $expiry';
  }

  @override
  String get profilePersonalInfoTitle => 'Información personal';

  @override
  String get profileFullNameLabel => 'Nombre completo';

  @override
  String get profileEmailLabel => 'Correo electrónico';

  @override
  String get profilePhoneNumberLabel => 'Número de teléfono';

  @override
  String get profilePasswordLabel => 'Contraseña';

  @override
  String get profileCountryLabel => 'País';

  @override
  String get profileCityLabel => 'Ciudad';

  @override
  String get profileEditAction => 'Editar';

  @override
  String get profileChangePasswordAction => 'Cambiar contraseña';

  @override
  String get profileGender => 'Género';

  @override
  String get profileGenderMale => 'Masculino';

  @override
  String get profileGenderFemale => 'Femenino';

  @override
  String get profileDateOfBirth => 'Fecha de nacimiento';

  @override
  String get profileSaveChanges => 'Guardar cambios';

  @override
  String get companyProfileCompanyName => 'Travel Egypt Co.';

  @override
  String companyProfileReviewsCountShort(Object count) {
    return '($count reseñas)';
  }

  @override
  String get companyProfileFollowing => 'Siguiendo';

  @override
  String get companyProfileFollow => 'Seguir';

  @override
  String get companyProfileStatsTrips => 'Viajes';

  @override
  String get companyProfileStatsReviews => 'Reseñas';

  @override
  String get companyProfileStatsFollowers => 'Seguidores';

  @override
  String get companyProfileAbout => 'Acerca de';

  @override
  String get companyProfileAboutDescription =>
      'Travel Egypt Co. es una empresa líder de viajes especializada en tours y aventuras en Egipto. Ofrecemos experiencias únicas por todo Egipto, desde las antiguas pirámides hasta los hermosos resorts del Mar Rojo.';

  @override
  String get companyProfileTrips => 'Viajes';

  @override
  String get companyProfileReviews => 'Reseñas';

  @override
  String get companyProfileSeeAll => 'Ver todo';

  @override
  String get companyProfileTripName => 'Nombre del viaje';

  @override
  String get companyProfileReviewAuthor => 'John Doe';

  @override
  String get companyProfileReviewDate => 'hace 2 días';

  @override
  String get companyProfileReviewComment =>
      '¡Gran experiencia! El viaje estuvo muy bien organizado y el guía fue muy profesional.';

  @override
  String get filterTitle => 'Filtro';

  @override
  String get filterReset => 'Restablecer';

  @override
  String get filterDuration => 'Duración';

  @override
  String get filterTripType => 'Tipo de viaje';

  @override
  String get filterRating => 'Valoración';

  @override
  String get filterDepartureCity => 'Ciudad de salida';

  @override
  String get filterSelectCity => 'Seleccionar ciudad';

  @override
  String get filterApply => 'Aplicar';

  @override
  String get destinationTitle => 'Destino';

  @override
  String get destinationSearchHint => 'Buscar destinos...';

  @override
  String get destinationRecentSearches => 'Búsquedas recientes';

  @override
  String get destinationClearAll => 'Borrar todo';

  @override
  String get destinationPopularDestinations => 'Destinos populares';

  @override
  String searchTripsFound(Object count) {
    return '$count viajes encontrados';
  }

  @override
  String get searchQueryExample => 'Sharm El Sheikh';

  @override
  String get searchResultTitle => 'Resultados de búsqueda';

  @override
  String get searchResultSearchHint => 'Buscar un viaje';

  @override
  String get searchResultSortBy => 'Ordenar por';

  @override
  String get searchResultFilters => 'Filtros';

  @override
  String get searchResultRating => '4.9';

  @override
  String get searchResultReviews => '(112)';

  @override
  String get searchResultFromCity => 'Desde El Cairo';

  @override
  String get searchResultDateFrom => '27 Nov';

  @override
  String get searchResultDateTo => '4 Dic';

  @override
  String get searchResultLabelNew => 'Nuevo en TripMarche';

  @override
  String get searchResultLabelRecommended => 'Recomendado';

  @override
  String get searchResultLabelBestPrice => 'Mejor precio';

  @override
  String get searchResultOldPrice => '\$1000';

  @override
  String get searchResultDiscountPrice => '\$699';

  @override
  String get searchResultPerPerson => '/Persona';

  @override
  String get tripDetailsTitle => 'Viaje a Dahab';

  @override
  String get tripDetailsHeroCountryTag => 'Indonesia';

  @override
  String get tripDetailsHeroByCompany => 'Por la agencia de viajes';

  @override
  String get tripDetailsHeroFromLocation => 'Desde El Cairo y Alejandría';

  @override
  String get tripDetailsHeroDateRange => '27 nov → 4 dic';

  @override
  String get tripDetailsHeroFromPrefix => 'Desde ';

  @override
  String tripDetailsHeroByCompanyLine(String company) {
    return 'Por $company';
  }

  @override
  String tripDetailsGalleryMoreCount(Object count) {
    return '+$count';
  }

  @override
  String imageGalleryPosition(int current, int total) {
    return '$current de $total';
  }

  @override
  String get tripDetailsOverviewTitle => 'Sobre este viaje';

  @override
  String get tripDetailsOverviewBody =>
      'Vive la impresionante belleza de los Alpes suizos en esta aventura de 7 días. Visita destinos icónicos, disfruta de viajes en tren panorámicos y sumérgete en la cultura suiza. Perfecto para amantes de la naturaleza y la fotografía.';

  @override
  String get tripDetailsWhatsIncludedTitle => 'Qué incluye';

  @override
  String get tripDetailsIncludedFlightTickets => 'Billetes de avión';

  @override
  String get tripDetailsIncludedHotelStay => 'Estancia en hotel';

  @override
  String get tripDetailsIncludedBreakfast => 'Desayuno';

  @override
  String get tripDetailsIncludedAirportTransfer => 'Traslado al aeropuerto';

  @override
  String get tripDetailsDepartureDetailsTitle => 'Detalles de salida';

  @override
  String get tripDetailsMeetingLocationLabel => 'Lugar de encuentro';

  @override
  String get tripDetailsMeetingLocationValue =>
      '18 El Tesen Road, Nueva El Cairo, Egipto';

  @override
  String get tripDetailsReturnLocationLabel => 'Lugar de regreso';

  @override
  String get tripDetailsReturnLocationValue => '54 Ramses, Centro, Egipto';

  @override
  String get tripDetailsMeetingTimeLabel => 'Hora de encuentro';

  @override
  String get tripDetailsMeetingTimeValue => '5:00 PM';

  @override
  String get tripDetailsReturnTimeLabel => 'Hora de regreso';

  @override
  String get tripDetailsReturnTimeValue => '9:30 PM';

  @override
  String get tripDetailsProgramTitle => 'Programa del viaje';

  @override
  String get tripDetailsProgramMealsLabel => 'Comidas';

  @override
  String get tripDetailsProgramDay1 => 'Día 1';

  @override
  String get tripDetailsProgramDay2 => 'Día 2';

  @override
  String get tripDetailsProgramCity1 => 'Pekín';

  @override
  String get tripDetailsProgramCity2 => 'Hangzhou';

  @override
  String get tripDetailsProgramDay1Item1 => 'Llegada al aeropuerto de Changdu';

  @override
  String get tripDetailsProgramDay1Item2 => 'Vuelo doméstico a Pekín';

  @override
  String get tripDetailsProgramDay1Item3 => 'Check-in en el hotel';

  @override
  String get tripDetailsProgramDay1Item4 =>
      'Tour libre por la calle Wangfujing';

  @override
  String get tripDetailsProgramDay2Item1 => 'Tour por la ciudad de Hangzhou';

  @override
  String get tripDetailsProgramDay2Item2 =>
      'Check-in en el hotel y tour nocturno';

  @override
  String get tripDetailsProgramDay2Item3 =>
      'Visita al Lago del Oeste en crucero';

  @override
  String get tripDetailsProgramSeeAll => 'Ver todo el programa';

  @override
  String get tripDetailsAirlineLabel => 'Aerolínea';

  @override
  String get tripDetailsAirlineName => 'Egyptair';

  @override
  String get tripDetailsFlightLeg1FromCity => 'El Cairo';

  @override
  String get tripDetailsFlightLeg1FromTime => '5:00 AM';

  @override
  String get tripDetailsFlightLeg1ToCity => 'París';

  @override
  String get tripDetailsFlightLeg1ToTime => '7:20 AM';

  @override
  String get tripDetailsFlightLeg1Date => '28 abril';

  @override
  String get tripDetailsFlightLeg2FromCity => 'París';

  @override
  String get tripDetailsFlightLeg2FromTime => '8:00 AM';

  @override
  String get tripDetailsFlightLeg2ToCity => 'El Cairo';

  @override
  String get tripDetailsFlightLeg2ToTime => '5:20 AM';

  @override
  String get tripDetailsFlightLeg2Date => '4 mayo';

  @override
  String get tripDetailsTransportLeg1FromCity => 'El Cairo';

  @override
  String get tripDetailsTransportLeg1FromTime => '8:00 AM';

  @override
  String get tripDetailsTransportLeg1ToCity => 'París';

  @override
  String get tripDetailsTransportLeg1ToTime => '5:20 AM';

  @override
  String get tripDetailsTransportLeg1CenterLabel => 'Autobús';

  @override
  String get tripDetailsTransportLeg1Date => '29 mayo';

  @override
  String get tripDetailsTransportLeg2FromCity => 'El Cairo';

  @override
  String get tripDetailsTransportLeg2FromTime => '8:00 AM';

  @override
  String get tripDetailsTransportLeg2ToCity => 'París';

  @override
  String get tripDetailsTransportLeg2ToTime => '5:20 AM';

  @override
  String get tripDetailsTransportLeg2CenterLabel => 'Barco';

  @override
  String get tripDetailsTransportLeg2Date => '29 mayo';

  @override
  String get tripDetailsDestinationHurghada => 'Hurghada';

  @override
  String get tripDetailsDestinationParis => 'París';

  @override
  String get tripDetailsStatCitiesLabel => 'Número de ciudades';

  @override
  String get tripDetailsStatCitiesValue => '7 ciudades';

  @override
  String tripDetailsStatCitiesCount(int count) {
    return '$count ciudades';
  }

  @override
  String get tripDetailsPriceLabel => 'Precio';

  @override
  String get tripDetailsPerPersonSmall => 'por persona';

  @override
  String get tripDetailsBookingPriceDisplay => '1000.00';

  @override
  String get tripDetailsCompanyName => 'Travel Egypt Co.';

  @override
  String get tripDetailsCompanyTagline => 'Agencia de viajes de aventura';

  @override
  String get tripDetailsFollow => 'Seguir';

  @override
  String get tripDetailsDurationValue => '7 días';

  @override
  String get tripDetailsDurationLabel => 'Duración';

  @override
  String get tripDetailsGroupSizeValue => '20-25';

  @override
  String get tripDetailsGroupSizeLabel => 'Tamaño del grupo';

  @override
  String get tripDetailsTypeValue => 'Internacional';

  @override
  String get tripDetailsTypeLabel => 'Tipo';

  @override
  String get tripDetailsPerPerson => '/Persona';

  @override
  String get tripDetailsDescriptionTitle => 'Descripción';

  @override
  String get tripDetailsReadMore => ' Leer más';

  @override
  String get tripDetailsShowLess => ' Ver menos';

  @override
  String get tripDetailsDescriptionBody =>
      'Vive la magia de Dahab, una hermosa ciudad costera en la costa sureste de la península del Sinaí en Egipto. Este viaje de 7 días incluye snorkel en el Blue Hole, safaris por el desierto, paseos en camello y visitas a antiguas aldeas beduinas. Disfruta de los impresionantes arrecifes de coral, aguas cristalinas y paisajes montañosos increíbles. Nuestros guías experimentados garantizarán una aventura inolvidable con alojamiento cómodo y deliciosa comida local.';

  @override
  String get tripDetailsItineraryTitle => 'Itinerario del viaje';

  @override
  String get tripDetailsIncludesTitle => 'Incluye';

  @override
  String get tripDetailsIncludesHotel => 'Hotel';

  @override
  String get tripDetailsIncludesTransportation => 'Transporte';

  @override
  String get tripDetailsIncludesMeals => 'Comidas';

  @override
  String get tripDetailsIncludesActivities => 'Actividades';

  @override
  String get tripDetailsIncludesTourGuide => 'Guía turístico';

  @override
  String get tripDetailsImagesTitle => 'Imágenes del viaje';

  @override
  String get tripDetailsReviewsTitle => 'Reseñas';

  @override
  String tripDetailsReviewsCount(Object count) {
    return '$count reseñas';
  }

  @override
  String get tripDetailsRelatedTripsTitle => 'Viajes relacionados';

  @override
  String get tripDetailsTotalPrice => 'Precio total';

  @override
  String get tripDetailsBookNow => 'Reservar ahora';

  @override
  String tripDetailsPricePerPersonShort(Object price) {
    return '$price/Persona';
  }

  @override
  String get tripDetailsDay1Title => 'Día 1 - Llegada y check-in';

  @override
  String get tripDetailsDay1Desc =>
      'Llegada a Dahab, traslado al hotel, cena de bienvenida y reunión de orientación con el grupo.';

  @override
  String get tripDetailsDay2Title => 'Día 2 - Snorkel en Blue Hole';

  @override
  String get tripDetailsDay2Desc =>
      'Día completo de snorkel en el famoso Blue Hole. Almuerzo en un restaurante junto a la playa. Tarde/noche libre.';

  @override
  String get tripDetailsDay3Title => 'Día 3 - Safari por el desierto';

  @override
  String get tripDetailsDay3Desc =>
      'Safari en jeep por el desierto del Sinaí. Visita a una aldea beduina. Cena bajo las estrellas en el desierto.';

  @override
  String get tripDetailsDay4Title => 'Día 4 - Día libre y actividades';

  @override
  String get tripDetailsDay4Desc =>
      'Elige entre actividades opcionales: buceo, paseos en camello o explorar los mercados locales.';

  @override
  String get tripDetailsDay5Title => 'Día 5 - Caminata al Monte Sinaí';

  @override
  String get tripDetailsDay5Desc =>
      'Caminata temprano al Monte Sinaí para ver el amanecer. Visita al Monasterio de Santa Catalina.';

  @override
  String get tripDetailsDay6Title => 'Día 6 - Deportes acuáticos';

  @override
  String get tripDetailsDay6Desc =>
      'Clases de windsurf y kitesurf. Cena de despedida en un restaurante junto al mar.';

  @override
  String get tripDetailsDay7Title => 'Día 7 - Salida';

  @override
  String get tripDetailsDay7Desc =>
      'Desayuno en el hotel. Check-out y traslado al aeropuerto.';

  @override
  String get tripDetailsRelatedNameSharm => 'Sharm El Sheikh';

  @override
  String get tripDetailsRelatedNameHurghada => 'Viaje a Hurghada';

  @override
  String get tripDetailsRelatedNameLuxorAswan => 'Luxor y Asuán';

  @override
  String get tripDetailsHeroRatingLine => '4.5 (120 reseñas)';

  @override
  String get tripDetailsHeroLocationShort => 'Dahab, Egipto';

  @override
  String get tripDetailsHeroDaysBadge => '7 días';

  @override
  String get tripDetailsOut => 'Ida';

  @override
  String get tripDetailsIn => 'Vuelta';

  @override
  String get tripDetailsOutSummaryLine1 => '21 mayo, viernes';

  @override
  String get tripDetailsOutSummaryLine2 =>
      'Aeropuerto Internacional de El Cairo (CAI)';

  @override
  String get tripDetailsInSummaryLine1 => '27 mayo, jueves';

  @override
  String get tripDetailsInSummaryLine2 => 'Dahab, Sur del Sinaí';

  @override
  String get tripDetailsTripDescriptionTitle => 'Descripción del viaje';

  @override
  String get tripDetailsAmenitiesTitle => 'Servicios';

  @override
  String get tripDetailsAmenityHotelStars => 'Hotel 4 estrellas';

  @override
  String get tripDetailsAmenityFoodBar => 'Bar de comida';

  @override
  String get tripDetailsAmenityBusTrip => 'Viaje en autobús';

  @override
  String get tripDetailsAmenityTourGuide => 'Guía turístico';

  @override
  String get tripDetailsAccommodationTitle => 'Dónde te alojarás';

  @override
  String get tripDetailsAccommodationHotelNameLabel => 'Nombre del hotel';

  @override
  String get tripDetailsHotelName => 'Le Meridien Dahab Resort';

  @override
  String get tripDetailsHotelRatingStars => '5.0';

  @override
  String get tripDetailsAccommodationHotelLocationLabel =>
      'Ubicación del hotel';

  @override
  String get tripDetailsHotelAddress => 'Blue Hole Road, Dahab, Egipto';

  @override
  String get tripDetailsCheckInOut => 'Check-in 2:00 PM · Check-out 11:00 AM';

  @override
  String get tripDetailsViewMap => 'Ver mapa';

  @override
  String get tripDetailsSeeAllAccommodation => 'Ver todos los alojamientos';

  @override
  String get tripDetailsViewFullItinerary => 'Ver itinerario completo';

  @override
  String get tripDetailsFlightDetailsTitle => 'Detalles del vuelo';

  @override
  String get tripDetailsTransportationTitle => 'Transporte';

  @override
  String get tripDetailsFlightLegSummary => 'CAI → SSH · EgyptAir · 1h 10m';

  @override
  String get tripDetailsTrainLegSummary => 'Regreso · El Cairo · 8h 30m';

  @override
  String get tripDetailsDestinationsTitle => 'Destacados del viaje';

  @override
  String get tripDetailsDestinationDahab => 'Dahab';

  @override
  String get tripDetailsDestinationNuweiba => 'Nuweiba';

  @override
  String get tripDetailsDestinationDetailsTitle => 'Detalles del destino';

  @override
  String get tripDetailsDestinationVisaLabel => 'Visado';

  @override
  String get tripDetailsDestinationVisaValue => 'Visado requerido';

  @override
  String get tripDetailsDestinationRequiredVaccinesLabel =>
      'Vacunas requeridas';

  @override
  String get tripDetailsDestinationRequiredVaccinesValue => '+201026329736';

  @override
  String get tripDetailsDestinationTimeLabel => 'Hora';

  @override
  String get tripDetailsDestinationTimeValue => 'GMT+1';

  @override
  String get tripDetailsDestinationLanguageLabel => 'Idioma';

  @override
  String get tripDetailsDestinationLanguageValue => 'Inglés';

  @override
  String get tripDetailsDestinationCurrencyLabel => 'Moneda';

  @override
  String get tripDetailsDestinationCurrencyValue => 'Euro (EUR)';

  @override
  String get tripDetailsDestinationTemperatureLabel => 'Temperatura';

  @override
  String get tripDetailsDestinationTemperatureValue => '25°C';

  @override
  String get tripDetailsDestinationPublicTransportationLabel =>
      'Transporte público';

  @override
  String get tripDetailsDestinationPublicTransportationValue => 'Autobús';

  @override
  String get tripDetailsDestinationTaxiAppsLabel => 'Apps de taxi';

  @override
  String get tripDetailsDestinationTaxiAppsValue => 'Uber, InDrive';

  @override
  String get tripDetailsIncludesExcludesTitle => 'Incluye y excluye';

  @override
  String get tripDetailsExcludesTitle => 'Excluye';

  @override
  String get tripDetailsExcludeVisa => 'Tasas de visado';

  @override
  String get tripDetailsExcludeAlcohol => 'Bebidas alcohólicas';

  @override
  String get tripDetailsSeeAllPhotos => 'Ver todas las fotos';

  @override
  String get tripDetailsActivityPlansTitle => 'Planes de actividad';

  @override
  String get tripDetailsActivitySnorkel => 'Snorkel en Blue Hole';

  @override
  String get tripDetailsActivitySnorkelPrice => 'EGP 500';

  @override
  String get tripDetailsActivitySafari => 'Safari por el desierto';

  @override
  String get tripDetailsActivitySafariPrice => 'EGP 350';

  @override
  String get tripDetailsActivityDiving => 'Sesión de buceo introductoria';

  @override
  String get tripDetailsActivityDivingPrice => 'EGP 800';

  @override
  String get tripDetailsAdd => 'Añadir';

  @override
  String get tripDetailsAdded => 'Añadido';

  @override
  String get tripDetailsViewAllActivities => 'Ver todas las actividades';

  @override
  String get tripDetailsActivityRateTitle => 'Valoración de actividades';

  @override
  String get tripDetailsActivityRateLuxury => 'nivel de lujo';

  @override
  String get tripDetailsActivityRateShopping => 'Compras';

  @override
  String get tripDetailsActivityRateNightOutings => 'Vida nocturna';

  @override
  String get tripDetailsSeeAllActivities => 'Ver todas las actividades';

  @override
  String get tripDetailsVisaDetailsTitle => 'Detalles del visado';

  @override
  String get tripDetailsTripInstructionsTitle => 'Directrices del viaje';

  @override
  String get tripDetailsSafetyProceduresTitle => 'Directrices de seguridad';

  @override
  String get tripDetailsCompanySectionTitle => 'Socio de viaje';

  @override
  String get tripDetailsViewAll => 'Ver todo';

  @override
  String get tripDetailsReviewCountry => 'España';

  @override
  String get tripDetailsCompanyRatingValue => '4.9';

  @override
  String get tripDetailsCompanyRatingCount => '112';

  @override
  String get tripDetailsPolicyCancellation => 'Política de cancelación';

  @override
  String get tripDetailsPolicyInsurance => 'Seguro de viaje';

  @override
  String get tripDetailsPolicyTerms => 'Términos y condiciones';

  @override
  String get tripDetailsPolicyFaqs => 'Preguntas frecuentes';

  @override
  String get tripDetailsSeeAllReviews => 'Ver todo';

  @override
  String get tripDetailsOrganizerTitle => 'Organizador';

  @override
  String get tripDetailsOrganizerSubtitle =>
      'Socio de confianza en Trip Marche';

  @override
  String get tripDetailsStartingFrom => 'Desde';

  @override
  String get tripDetailsBookingFromPrice => 'EGP 5,000';

  @override
  String get tripDetailsItineraryLoc1 => 'Pekín';

  @override
  String get tripDetailsItineraryActs1 =>
      '• Check-in en el hotel\n• Paseo de orientación por la ciudad\n• Cena de bienvenida';

  @override
  String get tripDetailsItineraryLoc2 => 'Hangzhou';

  @override
  String get tripDetailsItineraryActs2 =>
      '• Crucero por el Lago del Oeste\n• Visita a plantación de té\n• Tarde libre';

  @override
  String get tripDetailsReviewSampleName => 'Ahmed Hassan';

  @override
  String get tripDetailsReviewSampleDate => 'Dic 2025';

  @override
  String get tripDetailsReviewSampleBody =>
      '¡Viaje increíble! Gran organización y guías muy amables. El día de snorkel fue inolvidable.';

  @override
  String get bookingTripTermsTitle => 'Términos y condiciones';

  @override
  String get bookingTripTermsHeader => 'Términos y condiciones del viaje';

  @override
  String bookingTripTermsLastUpdated(Object date) {
    return 'Última actualización: $date';
  }

  @override
  String get bookingTripTermsSection1Title => '1. Reserva y pago';

  @override
  String get bookingTripTermsSection1Body =>
      'Al reservar un viaje a través de Trip Marche, aceptas los siguientes términos. Se requiere un depósito del 30% en el momento de la reserva para asegurar tu plaza. El saldo restante debe pagarse al menos 14 días antes de la fecha de salida. No pagar a tiempo puede resultar en la cancelación de tu reserva. Todos los pagos se procesan de forma segura a través de nuestros socios.';

  @override
  String get bookingTripTermsSection2Title => '2. Elegibilidad';

  @override
  String get bookingTripTermsSection2Body =>
      'Los participantes deben tener al menos 18 años para reservar de forma independiente. Los menores de 18 deben ir acompañados por un padre o tutor legal. Algunas actividades pueden tener requisitos adicionales de edad o salud. Es responsabilidad del viajero cumplir con los criterios y contar con los documentos necesarios.';

  @override
  String get bookingTripTermsSection3Title => '3. Modificaciones del viaje';

  @override
  String get bookingTripTermsSection3Body =>
      'Trip Marche se reserva el derecho de modificar el itinerario por condiciones climáticas, motivos de seguridad u otras circunstancias imprevistas. Haremos todo lo posible por ofrecer alternativas equivalentes. En caso de cambios significativos, se notificará a los viajeros y podrán recibir un reembolso parcial o crédito.';

  @override
  String get bookingTripTermsSection4Title =>
      '4. Responsabilidades del viajero';

  @override
  String get bookingTripTermsSection4Body =>
      'Los viajeros son responsables de tener documentos de viaje válidos, un seguro adecuado y cualquier vacuna requerida. Deben seguir las instrucciones de los guías y respetar leyes y costumbres locales. Trip Marche no es responsable de consecuencias por incumplir requisitos de entrada.';

  @override
  String get bookingTripTermsSection5Title => '5. Responsabilidad';

  @override
  String get bookingTripTermsSection5Body =>
      'Trip Marche actúa como organizador e intermediario. Aunque tomamos precauciones, no somos responsables de pérdidas, lesiones o daños derivados de actividades durante el viaje, eventos naturales o acciones de terceros. Los viajeros participan bajo su propio riesgo. Recomendamos un seguro de viaje completo.';

  @override
  String get bookingTripTermsSection6Title => '6. Privacidad';

  @override
  String get bookingTripTermsSection6Body =>
      'La información personal recopilada durante la reserva se usa solo para la organización del viaje y comunicación. No compartimos tu información con terceros salvo lo necesario para completar la reserva. Para más detalles, consulta nuestra Política de privacidad.';

  @override
  String get bookingTripTermsSection7Title => '7. Resolución de disputas';

  @override
  String get bookingTripTermsSection7Body =>
      'Las disputas derivadas de estos términos se resolverán mediante negociación amistosa. Si no se llega a un acuerdo, se someterán a los tribunales competentes. Estos términos se rigen por las leyes de la República Árabe de Egipto.';

  @override
  String get bookingTripInstructionsTitle => 'Instrucciones del viaje';

  @override
  String get bookingTripInstructionsHeader => 'Antes de salir';

  @override
  String get bookingTripInstructionsIntro =>
      'Lee atentamente las siguientes instrucciones para garantizar una experiencia de viaje fluida y agradable. Una buena preparación te ayudará a aprovechar al máximo tu aventura en Dahab.';

  @override
  String get bookingTripInstructionsWhatToPack => 'Qué llevar';

  @override
  String get bookingTripInstructionsMeetingPointTime =>
      'Punto y hora de encuentro';

  @override
  String get bookingTripInstructionsDocumentsToBring => 'Documentos a llevar';

  @override
  String get bookingTripInstructionsImportantReminders =>
      'Recordatorios importantes';

  @override
  String get bookingTripSafetyTitle => 'Seguridad del viaje';

  @override
  String get bookingTripSafetyBanner =>
      'Tu seguridad es nuestra máxima prioridad. Lee atentamente las siguientes pautas.';

  @override
  String get bookingTripSafetyHeader => 'Procedimientos de seguridad';

  @override
  String get bookingTripSafetyIntro =>
      'En Trip Marche, nos comprometemos a garantizar la seguridad y el bienestar de todos los viajeros. Nuestros viajes incluyen medidas de seguridad integrales y todos nuestros guías están formados en primeros auxilios y procedimientos de emergencia.';

  @override
  String get bookingTripSafetyWaterTitle =>
      'Seguridad en actividades acuáticas';

  @override
  String get bookingTripSafetyDesertTitle => 'Seguridad en el desierto';

  @override
  String get bookingTripSafetyHealthTitle => 'Salud y asistencia médica';

  @override
  String get bookingTripSafetyEmergencyTitle => 'Contactos de emergencia';

  @override
  String get bookingTripSafetyGeneralTipsTitle =>
      'Consejos generales de seguridad';

  @override
  String get authResetPasswordTitle => 'Restablecer contraseña';

  @override
  String get authResetPasswordSubtitle =>
      'Introduce tu nueva contraseña a continuación';

  @override
  String get authNewPasswordLabel => 'Nueva contraseña';

  @override
  String get authNewPasswordHint => 'Introduce la nueva contraseña';

  @override
  String get authConfirmNewPasswordLabel => 'Confirmar nueva contraseña';

  @override
  String get authConfirmNewPasswordHint => 'Confirma la nueva contraseña';

  @override
  String get authResetPasswordButton => 'Restablecer contraseña';

  @override
  String get tripDetailsDurationUnit => 'Días';

  @override
  String get tripDetailsProgramDayPrefix => 'Día';

  @override
  String get tripDetailsTypeDomestic => 'Nacional';

  @override
  String get tripDetailsPayOnArrival => 'Pago a la llegada';

  @override
  String get tripDetailsFailedToLoad =>
      'No se pudieron cargar los detalles del viaje.';

  @override
  String get tripDetailsTryAgain => 'Reintentar';

  @override
  String get tripDetailsNoFlights =>
      'Los detalles del vuelo aparecerán aquí cuando estén disponibles.';

  @override
  String get tripDetailsNoTransport =>
      'Los detalles de transporte terrestre o marítimo aparecerán aquí cuando estén disponibles.';

  @override
  String get tripDetailsVisaAndEntryTitle => 'Visa e ingreso';

  @override
  String get csLetsGetInTouch => 'Contáctanos';

  @override
  String get csCall => 'Llamar';

  @override
  String get csSendMessage => 'Enviar mensaje';

  @override
  String get csWhatsApp => 'WhatsApp';
}
