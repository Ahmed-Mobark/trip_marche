// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get errorFieldRequired => 'هذا الحقل مطلوب';

  @override
  String get errorInvalidName => 'تنسيق الاسم غير صحيح';

  @override
  String get errorInvalidUrl => 'عنوان URL غير صالح';

  @override
  String get errorInvalidPhoneNumber => 'رقم الهاتف غير صحيح';

  @override
  String get errorInvalidEmail => 'عنوان البريد الإلكتروني غير صحيح';

  @override
  String get errorInvalidPassword =>
      'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل مع أحرف كبيرة وصغيرة ورموز خاصة';

  @override
  String get errorPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get errorInvalidNumber => 'رقم غير صالح';

  @override
  String get errorInvalidIban => 'تنسيق IBAN غير صالح';

  @override
  String get errorInvalidMobileNumber => 'رقم الجوال غير صالح';

  @override
  String get errorInvalidStcPayId => 'معرف STC Pay غير صالح';

  @override
  String get errorInvalidNationalId => 'رقم الهوية الوطنية غير صالح';

  @override
  String get errorInvalidPassport => 'رقم جواز السفر غير صالح';

  @override
  String get sorryMessage => 'نحن آسفون';

  @override
  String get nothingFound => 'لم يتم العثور على شيء';

  @override
  String errorPhoneValidation(Object length, Object start) {
    return 'يجب أن يبدأ رقم الهاتف بـ $start وأن يكون طوله $length رقم.';
  }

  @override
  String get errorExperienceRequired => 'يجب إضافة تجربة واحدة على الأقل.';

  @override
  String get errorIdDocumentRequired => 'يجب رفع مستند الهوية للتحقق من هويتك.';

  @override
  String get errorPhotoRequired => 'يجب رفع صورة بخلفية بيضاء';

  @override
  String get updateAvailableTitle => 'تحديث متاح';

  @override
  String get updateMandatoryMessage =>
      'يتوفر إصدار جديد من التطبيق. يرجى التحديث للمتابعة في استخدام التطبيق.';

  @override
  String get updateOptionalMessage =>
      'يتوفر إصدار جديد من التطبيق. نوصي بالتحديث للحصول على أفضل تجربة.';

  @override
  String get updateNow => 'تحديث الآن';

  @override
  String get skip => 'تخطي';

  @override
  String get chooseImage => 'تحميل اختيار صورة';

  @override
  String get takePicture => 'تحميل التقط صورة';

  @override
  String get chooseFromFiles => 'تحميل اختيار من الملفات';

  @override
  String get updatePleaseUpdateToContinue => 'يرجى تحديث التطبيق للمتابعة.';

  @override
  String get updateNewVersionAvailableShort => 'يتوفر إصدار جديد.';

  @override
  String get authLoginTitle => 'تسجيل الدخول إلى حسابك';

  @override
  String get authEmailLabel => 'البريد الإلكتروني';

  @override
  String get authEmailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get authPasswordLabel => 'كلمة المرور';

  @override
  String get authPasswordHint => 'أدخل كلمة المرور';

  @override
  String get authForgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get authLoginButton => 'تسجيل الدخول';

  @override
  String get authNoAccountPrompt => 'ليس لديك حساب؟ ';

  @override
  String get authCreateOne => 'إنشاء حساب';

  @override
  String get authOrLoginWith => 'أو سجّل الدخول باستخدام';

  @override
  String get authContinueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get authContinueWithApple => 'المتابعة باستخدام Apple';

  @override
  String get authTravelAgencyPrompt => 'تاجر أو وكالة رحلات؟ ';

  @override
  String get authJoinAsTripPartner => 'انضم كبائع';

  @override
  String get authPartnerPortalTitle => 'بوابة الشركاء';

  @override
  String get authWebViewLoadFailed =>
      'تعذر تحميل هذه الصفحة. تحقق من الاتصال وحاول مرة أخرى.';

  @override
  String get authWebViewRetry => 'إعادة المحاولة';

  @override
  String get authSignUpTitle => 'أنشئ حسابك';

  @override
  String get authSignUpSubtitle => 'سجّل لإنشاء حسابك والبدء';

  @override
  String get authFullNameLabel => 'الاسم الكامل';

  @override
  String get authFullNameHint => 'أدخل اسمك الكامل';

  @override
  String get authPhoneLabel => 'رقم الهاتف';

  @override
  String get authPhoneHint => 'أدخل رقم هاتفك';

  @override
  String get authConfirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get authConfirmPasswordHint => 'أكد كلمة المرور';

  @override
  String get authSignUpButton => 'إنشاء حساب';

  @override
  String get authOrSignUpWith => 'أو أنشئ حسابًا باستخدام';

  @override
  String get authSocialGoogle => 'Google';

  @override
  String get authSocialApple => 'Apple';

  @override
  String get authHaveAccountPrompt => 'لديك حساب بالفعل؟ ';

  @override
  String get authLoginAction => 'تسجيل الدخول';

  @override
  String get authForgotPasswordTitle => 'نسيت كلمة مرورك؟';

  @override
  String get authForgotPasswordDescription =>
      'أدخل بريدك الإلكتروني أدناه وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get authForgotPasswordSubtitle => 'نسيتها؟ دعنا نصلح ذلك.';

  @override
  String get authSendButton => 'إرسال';

  @override
  String get authSendCodeButton => 'إرسال الرمز';

  @override
  String get authVerifyTitle => 'تحقق من رقمك';

  @override
  String get authVerifyDescription =>
      'لقد أرسلنا لك رمز تحقق إلى رقمك المسجل. يرجى إدخال الرمز أدناه.';

  @override
  String get authVerifyButton => 'تحقق';

  @override
  String get authBack => 'رجوع';

  @override
  String get authResendCode => 'إعادة إرسال الرمز';

  @override
  String get authVerifyEmailTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String get authVerifyEmailSubtitle =>
      'أرسلنا لك رمزًا من 6 أرقام للتحقق من رقمك';

  @override
  String get authVerificationCodeNotReceived => 'لم تستلم رمز التحقق؟';

  @override
  String get authResendNow => 'أعد الإرسال الآن';

  @override
  String get homeAppTitle => 'TripMarche';

  @override
  String get homeSearchHint => 'شرم الشيخ';

  @override
  String get homeLocationText => 'مصر، القاهرة، القاهرة الجديدة';

  @override
  String get homeTrendingDestinations => 'الوجهات الرائجة';

  @override
  String get homePopularTrips => 'الرحلات الشائعة';

  @override
  String get homeSponsoredTrips => 'الرحلات الممولة';

  @override
  String get homeDomesticTripsInEgypt => 'رحلات داخلية في مصر';

  @override
  String get homeInternationalTripsFromEgypt => 'رحلات دولية من مصر';

  @override
  String get homeRecommendedForYou => 'موصى بها لك';

  @override
  String get homeSpecialTrips => 'رحلات مميزة';

  @override
  String get homeTopRated => 'الأعلى تقييماً';

  @override
  String get homeFromCairoAlexandria => 'من القاهرة والإسكندرية';

  @override
  String get homeNewInTripMarche => 'جديد في TripMarche';

  @override
  String get homePerPerson => 'للفرد';

  @override
  String get homeSeeAll => 'عرض الكل';

  @override
  String get wishlistTitle => 'المفضلة';

  @override
  String get wishlistSearchHint => 'ابحث عن رحلة';

  @override
  String get wishlistSortBy => 'ترتيب حسب';

  @override
  String get wishlistFilters => 'تصفية';

  @override
  String get wishlistNewInTripMarche => 'جديد في TripMarche';

  @override
  String get wishlistRecommended => 'موصى به';

  @override
  String get wishlistBestPrice => 'أفضل سعر';

  @override
  String get wishlistEmptyTitle => 'لا توجد رحلات محفوظة بعد';

  @override
  String get wishlistEmptyDescription =>
      'اضغط على أيقونة القلب في أي رحلة\nلحفظها في المفضلة.';

  @override
  String get wishlistFiltersTitle => 'التصفية';

  @override
  String get wishlistFiltersClearAll => 'مسح الكل';

  @override
  String get wishlistFiltersDestination => 'الوجهة';

  @override
  String get wishlistFiltersSelectDestination => 'اختر';

  @override
  String get wishlistFiltersPriceRange => 'نطاق السعر';

  @override
  String get wishlistFiltersTripType => 'نوع الرحلة';

  @override
  String get wishlistFiltersDomestic => 'محلي';

  @override
  String get wishlistFiltersInternational => 'دولي';

  @override
  String get wishlistFiltersDepartureCountry => 'بلد المغادرة';

  @override
  String get wishlistFiltersDepartureCity => 'مدينة المغادرة';

  @override
  String get wishlistFiltersSelectCountry => 'اختر';

  @override
  String get wishlistFiltersSelectCity => 'اختر';

  @override
  String get wishlistFiltersTripMonth => 'شهر الرحلة';

  @override
  String get wishlistFiltersSelectMonth => 'اختر';

  @override
  String get wishlistFiltersActions => 'الأنشطة';

  @override
  String get wishlistFiltersSelectAction => 'اختر';

  @override
  String get wishlistFiltersTravelAgency => 'وكالة السفر';

  @override
  String get wishlistFiltersAgencyNameHint => 'اسم وكالة السفر';

  @override
  String get wishlistFiltersAgencyRating => 'تقييم وكالة السفر';

  @override
  String get wishlistFiltersOtherCountries => 'دول أخرى';

  @override
  String get wishlistFiltersOtherCities => 'مدن أخرى';

  @override
  String get wishlistFiltersSelectCountries => 'اختر';

  @override
  String get wishlistFiltersSelectCities => 'اختر';

  @override
  String get wishlistFiltersNumberOfCities => 'عدد المدن';

  @override
  String get wishlistFiltersNumberOfCountries => 'عدد الدول';

  @override
  String get wishlistFiltersDuration => 'المدة';

  @override
  String get wishlistFiltersDurationUpTo3 => 'حتى 3 أيام';

  @override
  String get wishlistFiltersDurationUpTo7 => 'حتى 7 أيام';

  @override
  String get wishlistFiltersDuration7Plus => '+7 أيام';

  @override
  String get wishlistFiltersGroupSize => 'حجم المجموعة';

  @override
  String get wishlistFiltersGroupSizeSmall => 'حتى 10';

  @override
  String get wishlistFiltersGroupSizeUpTo20 => 'حتى 20';

  @override
  String get wishlistFiltersGroupSize20Plus => '+20';

  @override
  String get wishlistFiltersTripSeason => 'موسم الرحلة';

  @override
  String get wishlistFiltersSeasonSpring => 'الربيع';

  @override
  String get wishlistFiltersSeasonHajj => 'الحج';

  @override
  String get wishlistFiltersSeasonNewYear => 'رأس السنة';

  @override
  String get wishlistFiltersTripFeatures => 'مميزات الرحلة';

  @override
  String get wishlistFiltersFeatureIncludeFlight => 'يشمل الطيران';

  @override
  String get wishlistFiltersFeatureIncludeHotel => 'يشمل الفندق';

  @override
  String get wishlistFiltersFeatureFreeMeal => 'وجبة مجانية';

  @override
  String get wishlistFiltersFeatureVisaOnArrival => 'تأشيرة عند الوصول';

  @override
  String get wishlistFiltersTripRating => 'تقييم الرحلة';

  @override
  String get wishlistFiltersDiscountCode => 'الرحلة تطبق كود خصم';

  @override
  String get wishlistFiltersFreeCancellation => 'إلغاء مجاني';

  @override
  String get wishlistFiltersSeeResults => 'عرض +500 نتيجة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsNotificationSetting => 'إعدادات الإشعارات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsCurrency => 'العملة';

  @override
  String get settingsEnglish => 'الإنجليزية';

  @override
  String get settingsArabic => 'العربية';

  @override
  String get settingsDarkMode => 'الوضع الداكن';

  @override
  String settingsAppVersion(Object version) {
    return 'إصدار التطبيق $version';
  }

  @override
  String get notificationSettingsTitle => 'إعدادات الإشعارات';

  @override
  String get notificationSettingsIntro =>
      'قم بإدارة تفضيلات الإشعارات للبقاء على اطلاع على الرحلات الجديدة والعروض وتحديثات الحجز.';

  @override
  String get notificationSettingsBookingUpdatesTitle => 'تحديثات الحجز';

  @override
  String get notificationSettingsBookingUpdatesSubtitle =>
      'استلم تحديثات فورية حول تأكيدات الرحلة والإلغاءات والتغييرات على حجوزاتك.';

  @override
  String get notificationSettingsToursTitle => 'الجولات';

  @override
  String get notificationSettingsToursSubtitle =>
      'سيصلك إشعار عند إضافة رحلات أو جولات جديدة تتوافق مع اهتماماتك.';

  @override
  String get notificationSettingsReviewsTitle => 'التقييمات';

  @override
  String get notificationSettingsReviewsSubtitle =>
      'سيتم تنبيهك عند ردّ شخص ما على تقييمك أو عند دعوتك لتقييم رحلة قمت بها.';

  @override
  String get notificationSettingsPromotionsSubtitle =>
      'احصل على خصومات خاصة وعروض لفترة محدودة وعروض موسمية.';

  @override
  String get notificationSettingsPush => 'إشعارات الدفع';

  @override
  String get notificationSettingsEmail => 'إشعارات البريد الإلكتروني';

  @override
  String get notificationSettingsTripUpdates => 'تحديثات الرحلات';

  @override
  String get notificationSettingsPromotions => 'العروض';

  @override
  String get notificationSettingsPriceAlerts => 'تنبيهات الأسعار';

  @override
  String get profileTitleAccount => 'الحساب';

  @override
  String get profileTitleSupport => 'الدعم';

  @override
  String get profilePersonalInfo => 'المعلومات الشخصية';

  @override
  String get profilePaymentMethod => 'طريقة الدفع';

  @override
  String get profileMyReviews => 'تقييماتي';

  @override
  String get profileAddReview => 'إضافة تقييم';

  @override
  String get profileReviewLabel => 'التقييم';

  @override
  String get profileProductRatingLabel => 'تقييم المنتج';

  @override
  String get profileMyReviewsRoute => 'القاهرة → دهب';

  @override
  String get profileFollowingCompanies => 'الشركات المتابعة';

  @override
  String get profileSettings => 'الإعدادات';

  @override
  String get profileCustomerService => 'خدمة العملاء';

  @override
  String get profileFaqs => 'الأسئلة الشائعة';

  @override
  String get profileTermsAndConditions => 'الشروط والأحكام';

  @override
  String get profileDeleteAccount => 'حذف الحساب';

  @override
  String get profileLogout => 'تسجيل الخروج';

  @override
  String profileTripsBooked(Object count) {
    return 'تم حجز $count رحلة';
  }

  @override
  String get profileDeleteAccountTitle => 'حذف الحساب';

  @override
  String get profileDeleteAccountMessage =>
      'هل أنت متأكد أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get profileLogoutConfirmTitle => 'تسجيل الخروج';

  @override
  String get profileLogoutConfirmMessage =>
      'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDelete => 'حذف';

  @override
  String get followingsTitle => 'الشركات التي أتابعها';

  @override
  String followingsCountTitle(Object count) {
    return '$count متابعة';
  }

  @override
  String get followingsUnfollow => 'إلغاء المتابعة';

  @override
  String get followingsEmptyTitle => 'لا توجد متابعات بعد';

  @override
  String get followingsEmptyDescription =>
      'ابدأ بمتابعة الشركات لتشاهد\nرحلاتها هنا.';

  @override
  String get myTripsTitle => 'رحلاتي';

  @override
  String get myTripsTabUpcoming => 'القادمة';

  @override
  String get myTripsTabPast => 'السابقة';

  @override
  String get myTripsSearchHint => 'ابحث عن رحلة';

  @override
  String get myTripsTabActive => 'نشطة';

  @override
  String get myTripsTabPastNew => 'السابقة';

  @override
  String get myTripsTabCanceled => 'ملغاة';

  @override
  String get myTripsStatusActive => 'نشطة';

  @override
  String get myTripsStatusPast => 'سابقة';

  @override
  String get myTripsStatusCanceled => 'ملغاة';

  @override
  String get myTripsBookAgain => 'احجز مرة أخرى';

  @override
  String get myTripsFromPrefix => 'من';

  @override
  String get myTripsViewDetails => 'عرض التفاصيل';

  @override
  String get myTripsViewReceipt => 'عرض الإيصال';

  @override
  String get myTripsBookingDetails => 'تفاصيل الحجز';

  @override
  String get myTripsDownloadPdf => 'تحميل pdf';

  @override
  String get myTripsEmptyTitle => 'لا توجد رحلات بعد';

  @override
  String get myTripsEmptyDescription => 'ابدأ الاستكشاف واحجز\nمغامرتك الأولى!';

  @override
  String get myTripsExploreTrips => 'استكشف الرحلات';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navTrips => 'الرحلات';

  @override
  String get navWishlist => 'المفضلة';

  @override
  String get navAccount => 'الحساب';

  @override
  String get bookingContactInfoTitle => 'معلومات التواصل';

  @override
  String get bookingContactFullNameLabel => 'الاسم الكامل';

  @override
  String get bookingContactFullNameHint => 'أدخل اسمك الكامل';

  @override
  String get bookingContactPhoneLabel => 'رقم الهاتف';

  @override
  String get bookingContactPhoneHint => '+20 123 456 7890';

  @override
  String get bookingContactEmailLabel => 'البريد الإلكتروني';

  @override
  String get bookingContactEmailHint => 'email@example.com';

  @override
  String get bookingContactEmergencyLabel => 'جهة اتصال للطوارئ';

  @override
  String get bookingContactEmergencyHint => 'رقم جهة اتصال للطوارئ';

  @override
  String get bookingContactIdPassportLabel => 'رقم الهوية/جواز السفر';

  @override
  String get bookingContactIdPassportHint => 'أدخل رقم الهوية أو جواز السفر';

  @override
  String get bookingContinue => 'متابعة';

  @override
  String get bookingAddNewCardTitle => 'إضافة بطاقة جديدة';

  @override
  String get bookingCardNumberLabel => 'رقم البطاقة';

  @override
  String get bookingCardNumberHint => '0000 0000 0000 0000';

  @override
  String get bookingCardholderNameLabel => 'اسم حامل البطاقة';

  @override
  String get bookingCardholderNameHint => 'John Doe';

  @override
  String get bookingExpiryDateLabel => 'تاريخ الانتهاء';

  @override
  String get bookingExpiryDateHint => 'MM/YY';

  @override
  String get bookingCvvLabel => 'CVV';

  @override
  String get bookingCvvHint => '***';

  @override
  String get bookingSaveCard => 'حفظ البطاقة';

  @override
  String get bookingCardholderNamePlaceholder => 'اسم حامل البطاقة';

  @override
  String get bookingPaymentMethodTitle => 'طريقة الدفع';

  @override
  String get bookingPaymentOptionCreditCard => 'بطاقة ائتمان';

  @override
  String get bookingPaymentOptionCreditCardSubtitle =>
      'ادفع باستخدام Visa أو Mastercard';

  @override
  String get bookingPaymentOptionPaypal => 'PayPal';

  @override
  String get bookingPaymentOptionPaypalSubtitle => 'ادفع باستخدام حساب PayPal';

  @override
  String get bookingPaymentOptionApplePay => 'Apple Pay';

  @override
  String get bookingPaymentOptionApplePaySubtitle => 'ادفع باستخدام Apple Pay';

  @override
  String get bookingSavedCards => 'البطاقات المحفوظة';

  @override
  String get bookingAddNewCard => 'إضافة بطاقة جديدة';

  @override
  String bookingPayNow(Object amount) {
    return 'ادفع الآن - $amount';
  }

  @override
  String bookingCardExpires(Object expiry) {
    return 'تنتهي $expiry';
  }

  @override
  String get profilePersonalInfoTitle => 'المعلومات الشخصية';

  @override
  String get profileFullNameLabel => 'الاسم الكامل';

  @override
  String get profileEmailLabel => 'البريد الإلكتروني';

  @override
  String get profilePhoneNumberLabel => 'رقم الهاتف';

  @override
  String get profilePasswordLabel => 'كلمة المرور';

  @override
  String get profileCountryLabel => 'الدولة';

  @override
  String get profileCityLabel => 'المدينة';

  @override
  String get profileEditAction => 'تعديل';

  @override
  String get profileChangePasswordAction => 'تغيير كلمة المرور';

  @override
  String get profileGender => 'الجنس';

  @override
  String get profileGenderMale => 'ذكر';

  @override
  String get profileGenderFemale => 'أنثى';

  @override
  String get profileDateOfBirth => 'تاريخ الميلاد';

  @override
  String get profileSaveChanges => 'حفظ التغييرات';

  @override
  String get companyProfileCompanyName => 'Travel Egypt Co.';

  @override
  String companyProfileReviewsCountShort(Object count) {
    return '($count تقييم)';
  }

  @override
  String get companyProfileFollowing => 'متابع';

  @override
  String get companyProfileFollow => 'متابعة';

  @override
  String get companyProfileStatsTrips => 'الرحلات';

  @override
  String get companyProfileStatsReviews => 'التقييمات';

  @override
  String get companyProfileStatsFollowers => 'المتابعون';

  @override
  String get companyProfileAbout => 'نبذة';

  @override
  String get companyProfileAboutDescription =>
      'Travel Egypt Co. شركة رائدة في مجال السفر متخصصة في الرحلات والمغامرات داخل مصر. نقدم تجارب فريدة في أنحاء مصر من الأهرامات القديمة إلى منتجعات البحر الأحمر الجميلة.';

  @override
  String get companyProfileTrips => 'الرحلات';

  @override
  String get companyProfileReviews => 'التقييمات';

  @override
  String get companyProfileSeeAll => 'عرض الكل';

  @override
  String get companyProfileTripName => 'اسم الرحلة';

  @override
  String get companyProfileReviewAuthor => 'John Doe';

  @override
  String get companyProfileReviewDate => 'منذ يومين';

  @override
  String get companyProfileReviewComment =>
      'تجربة رائعة! كانت الرحلة منظمة جدًا والمرشد كان على معرفة كبيرة.';

  @override
  String get filterTitle => 'تصفية';

  @override
  String get filterReset => 'إعادة ضبط';

  @override
  String get filterDuration => 'المدة';

  @override
  String get filterTripType => 'نوع الرحلة';

  @override
  String get filterRating => 'التقييم';

  @override
  String get filterDepartureCity => 'مدينة المغادرة';

  @override
  String get filterSelectCity => 'اختر مدينة';

  @override
  String get filterApply => 'تطبيق';

  @override
  String get destinationTitle => 'الوجهات';

  @override
  String get destinationSearchHint => 'ابحث عن وجهات...';

  @override
  String get destinationRecentSearches => 'عمليات البحث الأخيرة';

  @override
  String get destinationClearAll => 'مسح الكل';

  @override
  String get destinationPopularDestinations => 'وجهات شائعة';

  @override
  String searchTripsFound(Object count) {
    return 'تم العثور على $count رحلة';
  }

  @override
  String get searchQueryExample => 'شرم الشيخ';

  @override
  String get tripDetailsTitle => 'رحلة دهب';

  @override
  String get tripDetailsHeroCountryTag => 'إندونيسيا';

  @override
  String get tripDetailsHeroByCompany => 'بواسطة شركة السفر';

  @override
  String get tripDetailsHeroFromLocation => 'من القاهرة والإسكندرية';

  @override
  String get tripDetailsHeroDateRange => '27 نوفمبر ← 4 ديسمبر';

  @override
  String tripDetailsGalleryMoreCount(Object count) {
    return '+$count';
  }

  @override
  String imageGalleryPosition(int current, int total) {
    return '$current من $total';
  }

  @override
  String get tripDetailsOverviewTitle => 'نظرة عامة على الرحلة';

  @override
  String get tripDetailsOverviewBody =>
      'استمتع بجمال جبال الألب السويسرية الخلاب في هذه المغامرة لمدة 7 أيام. زر وجهات شهيرة، استمتع برحلات قطار ساحرة، وانغمس في الثقافة السويسرية. مثالي لعشاق الطبيعة وعشاق التصوير.';

  @override
  String get tripDetailsWhatsIncludedTitle => 'ما الذي يتضمنه العرض';

  @override
  String get tripDetailsIncludedFlightTickets => 'تذاكر طيران';

  @override
  String get tripDetailsIncludedHotelStay => 'إقامة فندقية';

  @override
  String get tripDetailsIncludedBreakfast => 'إفطار';

  @override
  String get tripDetailsIncludedAirportTransfer => 'تنقل من/إلى المطار';

  @override
  String get tripDetailsDepartureDetailsTitle => 'تفاصيل المغادرة';

  @override
  String get tripDetailsMeetingLocationLabel => 'مكان التجمع';

  @override
  String get tripDetailsMeetingLocationValue =>
      '18 طريق التسعين، القاهرة الجديدة، مصر';

  @override
  String get tripDetailsReturnLocationLabel => 'مكان العودة';

  @override
  String get tripDetailsReturnLocationValue => '54 رمسيس، وسط البلد، مصر';

  @override
  String get tripDetailsMeetingTimeLabel => 'وقت التجمع';

  @override
  String get tripDetailsMeetingTimeValue => '5:00 م';

  @override
  String get tripDetailsReturnTimeLabel => 'وقت العودة';

  @override
  String get tripDetailsReturnTimeValue => '9:30 م';

  @override
  String get tripDetailsProgramTitle => 'برنامج الرحلة';

  @override
  String get tripDetailsProgramMealsLabel => 'الوجبات';

  @override
  String get tripDetailsProgramDay1 => 'اليوم 1';

  @override
  String get tripDetailsProgramDay2 => 'اليوم 2';

  @override
  String get tripDetailsProgramCity1 => 'بكين';

  @override
  String get tripDetailsProgramCity2 => 'هانغتشو';

  @override
  String get tripDetailsProgramDay1Item1 => 'الوصول إلى مطار تشنغدو';

  @override
  String get tripDetailsProgramDay1Item2 => 'رحلة طيران داخلية إلى بكين';

  @override
  String get tripDetailsProgramDay1Item3 => 'تسجيل الوصول إلى الفندق';

  @override
  String get tripDetailsProgramDay1Item4 => 'جولة حرة في شارع وانغفوجينغ';

  @override
  String get tripDetailsProgramDay2Item1 => 'جولة في مدينة هانغتشو';

  @override
  String get tripDetailsProgramDay2Item2 =>
      'تسجيل الوصول إلى الفندق وجولة مسائية';

  @override
  String get tripDetailsProgramDay2Item3 => 'زيارة بحيرة الغرب برحلة بحرية';

  @override
  String get tripDetailsProgramSeeAll => 'عرض البرنامج كاملًا';

  @override
  String get tripDetailsAirlineLabel => 'شركة الطيران';

  @override
  String get tripDetailsAirlineName => 'مصر للطيران';

  @override
  String get tripDetailsFlightLeg1FromCity => 'القاهرة';

  @override
  String get tripDetailsFlightLeg1FromTime => '5:00 ص';

  @override
  String get tripDetailsFlightLeg1ToCity => 'باريس';

  @override
  String get tripDetailsFlightLeg1ToTime => '7:20 ص';

  @override
  String get tripDetailsFlightLeg1Date => '28 أبريل';

  @override
  String get tripDetailsFlightLeg2FromCity => 'باريس';

  @override
  String get tripDetailsFlightLeg2FromTime => '8:00 ص';

  @override
  String get tripDetailsFlightLeg2ToCity => 'القاهرة';

  @override
  String get tripDetailsFlightLeg2ToTime => '5:20 ص';

  @override
  String get tripDetailsFlightLeg2Date => '4 مايو';

  @override
  String get tripDetailsTransportLeg1FromCity => 'القاهرة';

  @override
  String get tripDetailsTransportLeg1FromTime => '8:00 ص';

  @override
  String get tripDetailsTransportLeg1ToCity => 'باريس';

  @override
  String get tripDetailsTransportLeg1ToTime => '5:20 ص';

  @override
  String get tripDetailsTransportLeg1CenterLabel => 'حافلة';

  @override
  String get tripDetailsTransportLeg1Date => '29 مايو';

  @override
  String get tripDetailsTransportLeg2FromCity => 'القاهرة';

  @override
  String get tripDetailsTransportLeg2FromTime => '8:00 ص';

  @override
  String get tripDetailsTransportLeg2ToCity => 'باريس';

  @override
  String get tripDetailsTransportLeg2ToTime => '5:20 ص';

  @override
  String get tripDetailsTransportLeg2CenterLabel => 'قارب';

  @override
  String get tripDetailsTransportLeg2Date => '29 مايو';

  @override
  String get tripDetailsDestinationHurghada => 'الغردقة';

  @override
  String get tripDetailsDestinationParis => 'باريس';

  @override
  String get tripDetailsStatCitiesLabel => 'عدد المدن';

  @override
  String get tripDetailsStatCitiesValue => '7 مدن';

  @override
  String get tripDetailsPriceLabel => 'السعر';

  @override
  String get tripDetailsPerPersonSmall => 'للفرد';

  @override
  String get tripDetailsBookingPriceDisplay => '1000.00';

  @override
  String get tripDetailsCompanyName => 'Travel Egypt Co.';

  @override
  String get tripDetailsCompanyTagline => 'وكالة سفر مغامرات';

  @override
  String get tripDetailsFollow => 'متابعة';

  @override
  String get tripDetailsDurationValue => '7 أيام';

  @override
  String get tripDetailsDurationLabel => 'المدة';

  @override
  String get tripDetailsGroupSizeValue => '20-25';

  @override
  String get tripDetailsGroupSizeLabel => 'حجم المجموعة';

  @override
  String get tripDetailsTypeValue => 'دولي';

  @override
  String get tripDetailsTypeLabel => 'النوع';

  @override
  String get tripDetailsPerPerson => '/للفرد';

  @override
  String get tripDetailsDescriptionTitle => 'الوصف';

  @override
  String get tripDetailsReadMore => ' اقرأ المزيد';

  @override
  String get tripDetailsShowLess => ' عرض أقل';

  @override
  String get tripDetailsDescriptionBody =>
      'استمتع بسحر دهب، مدينة ساحلية جميلة على الساحل الجنوبي الشرقي لشبه جزيرة سيناء في مصر. تتضمن هذه الرحلة لمدة 7 أيام سنوركلينج في بلو هول، ورحلات سفاري في الصحراء، وركوب الجمال، وزيارات لقرى بدوية قديمة. استمتع بالشعاب المرجانية المذهلة والمياه الصافية والمناظر الجبلية الخلابة. سيضمن لك مرشدونا ذوو الخبرة مغامرة لا تُنسى مع إقامة مريحة ومأكولات محلية شهية.';

  @override
  String get tripDetailsItineraryTitle => 'برنامج الرحلة';

  @override
  String get tripDetailsIncludesTitle => 'تشمل الرحلة';

  @override
  String get tripDetailsIncludesHotel => 'فندق';

  @override
  String get tripDetailsIncludesTransportation => 'مواصلات';

  @override
  String get tripDetailsIncludesMeals => 'وجبات';

  @override
  String get tripDetailsIncludesActivities => 'أنشطة';

  @override
  String get tripDetailsIncludesTourGuide => 'مرشد سياحي';

  @override
  String get tripDetailsImagesTitle => 'صور الرحلة';

  @override
  String get tripDetailsReviewsTitle => 'التقييمات';

  @override
  String tripDetailsReviewsCount(Object count) {
    return '$count تقييم';
  }

  @override
  String get tripDetailsRelatedTripsTitle => 'رحلات مشابهة';

  @override
  String get tripDetailsTotalPrice => 'السعر الإجمالي';

  @override
  String get tripDetailsBookNow => 'احجز الآن';

  @override
  String tripDetailsPricePerPersonShort(Object price) {
    return '$price/للفرد';
  }

  @override
  String get tripDetailsDay1Title => 'اليوم 1 - الوصول وتسجيل الدخول';

  @override
  String get tripDetailsDay1Desc =>
      'الوصول إلى دهب، الانتقال إلى الفندق، عشاء ترحيبي واجتماع تعريفي مع المجموعة.';

  @override
  String get tripDetailsDay2Title => 'اليوم 2 - سنوركلينج بلو هول';

  @override
  String get tripDetailsDay2Desc =>
      'يوم كامل سنوركلينج في بلو هول الشهير. غداء في مطعم على الشاطئ. وقت حر مساءً.';

  @override
  String get tripDetailsDay3Title => 'اليوم 3 - سفاري الصحراء';

  @override
  String get tripDetailsDay3Desc =>
      'سفاري بالجيب عبر صحراء سيناء. زيارة قرية بدوية. عشاء ومراقبة النجوم في الصحراء.';

  @override
  String get tripDetailsDay4Title => 'اليوم 4 - يوم حر وأنشطة';

  @override
  String get tripDetailsDay4Desc =>
      'اختر من الأنشطة الاختيارية: الغوص، ركوب الجمال، أو استكشاف الأسواق المحلية.';

  @override
  String get tripDetailsDay5Title => 'اليوم 5 - رحلة جبل سيناء';

  @override
  String get tripDetailsDay5Desc =>
      'صعود مبكر إلى جبل سيناء لمشاهدة الشروق. زيارة دير سانت كاترين.';

  @override
  String get tripDetailsDay6Title => 'اليوم 6 - الرياضات المائية';

  @override
  String get tripDetailsDay6Desc =>
      'دروس ويندسرفنج وكايتسرفنج. عشاء وداع في مطعم على البحر.';

  @override
  String get tripDetailsDay7Title => 'اليوم 7 - المغادرة';

  @override
  String get tripDetailsDay7Desc =>
      'إفطار في الفندق. تسجيل الخروج والانتقال إلى المطار.';

  @override
  String get tripDetailsRelatedNameSharm => 'شرم الشيخ';

  @override
  String get tripDetailsRelatedNameHurghada => 'رحلة الغردقة';

  @override
  String get tripDetailsRelatedNameLuxorAswan => 'الأقصر وأسوان';

  @override
  String get tripDetailsHeroRatingLine => '4.5 (120 تقييم)';

  @override
  String get tripDetailsHeroLocationShort => 'دهب، مصر';

  @override
  String get tripDetailsHeroDaysBadge => '7 أيام';

  @override
  String get tripDetailsOut => 'ذهاب';

  @override
  String get tripDetailsIn => 'عودة';

  @override
  String get tripDetailsOutSummaryLine1 => '21 مايو، الجمعة';

  @override
  String get tripDetailsOutSummaryLine2 => 'مطار القاهرة الدولي (CAI)';

  @override
  String get tripDetailsInSummaryLine1 => '27 مايو، الخميس';

  @override
  String get tripDetailsInSummaryLine2 => 'دهب، جنوب سيناء';

  @override
  String get tripDetailsTripDescriptionTitle => 'وصف الرحلة';

  @override
  String get tripDetailsAmenitiesTitle => 'وسائل الراحة';

  @override
  String get tripDetailsAmenityHotelStars => 'فندق 4 نجوم';

  @override
  String get tripDetailsAmenityFoodBar => 'بار طعام';

  @override
  String get tripDetailsAmenityBusTrip => 'رحلة بالحافلة';

  @override
  String get tripDetailsAmenityTourGuide => 'مرشد سياحي';

  @override
  String get tripDetailsAccommodationTitle => 'الإقامة';

  @override
  String get tripDetailsAccommodationHotelNameLabel => 'اسم الفندق';

  @override
  String get tripDetailsHotelName => 'لو ميريديان دهب ريزورت';

  @override
  String get tripDetailsHotelRatingStars => '5.0';

  @override
  String get tripDetailsAccommodationHotelLocationLabel => 'موقع الفندق';

  @override
  String get tripDetailsHotelAddress => 'طريق البلو هول، دهب، مصر';

  @override
  String get tripDetailsCheckInOut =>
      'تسجيل الوصول 2:00 مساءً · المغادرة 11:00 صباحًا';

  @override
  String get tripDetailsViewMap => 'عرض الخريطة';

  @override
  String get tripDetailsSeeAllAccommodation => 'عرض كل أماكن الإقامة';

  @override
  String get tripDetailsViewFullItinerary => 'عرض البرنامج كاملًا';

  @override
  String get tripDetailsFlightDetailsTitle => 'تفاصيل الطيران';

  @override
  String get tripDetailsTransportationTitle => 'المواصلات';

  @override
  String get tripDetailsFlightLegSummary => 'CAI → SSH · مصر للطيران · 1س 10د';

  @override
  String get tripDetailsTrainLegSummary => 'عودة · القاهرة · 8س 30د';

  @override
  String get tripDetailsDestinationsTitle => 'الوجهات';

  @override
  String get tripDetailsDestinationDahab => 'دهب';

  @override
  String get tripDetailsDestinationNuweiba => 'نويبع';

  @override
  String get tripDetailsDestinationDetailsTitle => 'تفاصيل الوجهة';

  @override
  String get tripDetailsDestinationVisaLabel => 'التأشيرة';

  @override
  String get tripDetailsDestinationVisaValue => 'التأشيرة مطلوبة';

  @override
  String get tripDetailsDestinationRequiredVaccinesLabel =>
      'التطعيمات المطلوبة';

  @override
  String get tripDetailsDestinationRequiredVaccinesValue => '+201026329736';

  @override
  String get tripDetailsDestinationTimeLabel => 'الوقت';

  @override
  String get tripDetailsDestinationTimeValue => 'GMT+1';

  @override
  String get tripDetailsDestinationLanguageLabel => 'اللغة';

  @override
  String get tripDetailsDestinationLanguageValue => 'الإنجليزية';

  @override
  String get tripDetailsDestinationCurrencyLabel => 'العملة';

  @override
  String get tripDetailsDestinationCurrencyValue => 'يورو (EUR)';

  @override
  String get tripDetailsDestinationTemperatureLabel => 'درجة الحرارة';

  @override
  String get tripDetailsDestinationTemperatureValue => '25°م';

  @override
  String get tripDetailsDestinationPublicTransportationLabel =>
      'المواصلات العامة';

  @override
  String get tripDetailsDestinationPublicTransportationValue => 'حافلة';

  @override
  String get tripDetailsDestinationTaxiAppsLabel => 'تطبيقات التاكسي';

  @override
  String get tripDetailsDestinationTaxiAppsValue => 'Uber, InDrive';

  @override
  String get tripDetailsIncludesExcludesTitle => 'يشمل ولا يشمل';

  @override
  String get tripDetailsExcludesTitle => 'لا يشمل';

  @override
  String get tripDetailsExcludeVisa => 'رسوم التأشيرة';

  @override
  String get tripDetailsExcludeAlcohol => 'المشروبات الكحولية';

  @override
  String get tripDetailsSeeAllPhotos => 'عرض كل الصور';

  @override
  String get tripDetailsActivityPlansTitle => 'الأنشطة الاختيارية';

  @override
  String get tripDetailsActivitySnorkel => 'سنوركلينج البلو هول';

  @override
  String get tripDetailsActivitySnorkelPrice => '500 جنيه';

  @override
  String get tripDetailsActivitySafari => 'سفاري الصحراء';

  @override
  String get tripDetailsActivitySafariPrice => '350 جنيه';

  @override
  String get tripDetailsActivityDiving => 'جلسة غوص تعريفي';

  @override
  String get tripDetailsActivityDivingPrice => '800 جنيه';

  @override
  String get tripDetailsAdd => 'إضافة';

  @override
  String get tripDetailsAdded => 'مضاف';

  @override
  String get tripDetailsViewAllActivities => 'عرض كل الأنشطة';

  @override
  String get tripDetailsActivityRateTitle => 'تقييم الأنشطة';

  @override
  String get tripDetailsActivityRateLuxury => 'مستوى الفخامة';

  @override
  String get tripDetailsActivityRateShopping => 'التسوق';

  @override
  String get tripDetailsActivityRateNightOutings => 'السهرات الليلية';

  @override
  String get tripDetailsSeeAllActivities => 'عرض كل الأنشطة';

  @override
  String get tripDetailsVisaDetailsTitle => 'تفاصيل التأشيرة';

  @override
  String get tripDetailsTripInstructionsTitle => 'تعليمات الرحلة';

  @override
  String get tripDetailsSafetyProceduresTitle => 'إجراءات السلامة';

  @override
  String get tripDetailsCompanySectionTitle => 'الشركة';

  @override
  String get tripDetailsViewAll => 'عرض الكل';

  @override
  String get tripDetailsReviewCountry => 'إسبانيا';

  @override
  String get tripDetailsCompanyRatingValue => '4.9';

  @override
  String get tripDetailsCompanyRatingCount => '112';

  @override
  String get tripDetailsPolicyCancellation => 'سياسة الإلغاء';

  @override
  String get tripDetailsPolicyInsurance => 'تأمين السفر';

  @override
  String get tripDetailsPolicyTerms => 'الشروط والأحكام';

  @override
  String get tripDetailsPolicyFaqs => 'الأسئلة الشائعة';

  @override
  String get tripDetailsSeeAllReviews => 'عرض الكل';

  @override
  String get tripDetailsOrganizerTitle => 'المنظم';

  @override
  String get tripDetailsOrganizerSubtitle => 'شريك موثوق على Trip Marche';

  @override
  String get tripDetailsStartingFrom => 'يبدأ من';

  @override
  String get tripDetailsBookingFromPrice => '5,000 جنيه';

  @override
  String get tripDetailsItineraryLoc1 => 'بكين';

  @override
  String get tripDetailsItineraryActs1 =>
      '• تسجيل الوصول بالفندق\n• جولة تعريفية بالمدينة\n• عشاء ترحيبي';

  @override
  String get tripDetailsItineraryLoc2 => 'هانغتشو';

  @override
  String get tripDetailsItineraryActs2 =>
      '• جولة بحيرة الغرب\n• زيارة مزارع الشاي\n• مساء حر';

  @override
  String get tripDetailsReviewSampleName => 'أحمد حسن';

  @override
  String get tripDetailsReviewSampleDate => 'ديسمبر 2025';

  @override
  String get tripDetailsReviewSampleBody =>
      'رحلة رائعة! تنظيم ممتاز ومرشدون لطفاء. يوم السنوركلينج لا يُنسى.';

  @override
  String get bookingTripTermsTitle => 'الشروط والأحكام';

  @override
  String get bookingTripTermsHeader => 'شروط وأحكام الرحلة';

  @override
  String bookingTripTermsLastUpdated(Object date) {
    return 'آخر تحديث: $date';
  }

  @override
  String get bookingTripTermsSection1Title => '1. الحجز والدفع';

  @override
  String get bookingTripTermsSection1Body =>
      'عند حجز رحلة عبر Trip Marche فإنك توافق على الشروط التالية. يلزم دفع عربون بنسبة 30% عند الحجز لتأكيد مكانك. يجب سداد المبلغ المتبقي قبل موعد انطلاق الرحلة بـ 14 يومًا على الأقل. قد يؤدي عدم السداد في الموعد إلى إلغاء الحجز. تتم معالجة جميع المدفوعات بشكل آمن عبر شركائنا.';

  @override
  String get bookingTripTermsSection2Title => '2. الأهلية';

  @override
  String get bookingTripTermsSection2Body =>
      'يجب أن يكون عمر المشارك 18 عامًا على الأقل للحجز بشكل مستقل. المسافرون دون 18 عامًا يجب أن يكونوا برفقة ولي أمر. قد تتطلب بعض الأنشطة شروطًا إضافية للعمر أو الصحة. تقع مسؤولية التأكد من استيفاء الشروط وتوفر الوثائق اللازمة على المسافر.';

  @override
  String get bookingTripTermsSection3Title => '3. تعديل الرحلة';

  @override
  String get bookingTripTermsSection3Body =>
      'يحق لـ Trip Marche تعديل برنامج الرحلة بسبب الظروف الجوية أو اعتبارات السلامة أو ظروف غير متوقعة. سنسعى لتقديم بدائل مكافئة. في حال حدوث تغييرات كبيرة سيتم إخطار المسافرين وقد يتم تقديم استرداد جزئي أو رصيد.';

  @override
  String get bookingTripTermsSection4Title => '4. مسؤوليات المسافر';

  @override
  String get bookingTripTermsSection4Body =>
      'يتحمل المسافر مسؤولية توفر وثائق السفر السارية وتأمين السفر وأي تطعيمات مطلوبة. يجب اتباع تعليمات المرشدين واحترام القوانين والعادات المحلية. لا تتحمل Trip Marche مسؤولية أي تبعات ناتجة عن عدم الالتزام بمتطلبات الدخول.';

  @override
  String get bookingTripTermsSection5Title => '5. المسؤولية';

  @override
  String get bookingTripTermsSection5Body =>
      'تعمل Trip Marche كمنظم ووسيط. ورغم اتخاذنا جميع الاحتياطات، فإننا لا نتحمل المسؤولية عن أي خسارة أو إصابة أو أضرار ناتجة عن الأنشطة أثناء الرحلة أو الكوارث الطبيعية أو تصرفات مزودي الخدمات من الأطراف الثالثة. المشاركة في الأنشطة تكون على مسؤولية المسافر. نوصي بشدة بشراء تأمين سفر شامل.';

  @override
  String get bookingTripTermsSection6Title => '6. الخصوصية';

  @override
  String get bookingTripTermsSection6Body =>
      'تُستخدم المعلومات الشخصية التي يتم جمعها أثناء الحجز فقط لتنظيم الرحلة والتواصل. لا نشارك معلوماتك مع أطراف ثالثة إلا بقدر ما يلزم لتنفيذ الحجز. لمزيد من التفاصيل يرجى الرجوع إلى سياسة الخصوصية.';

  @override
  String get bookingTripTermsSection7Title => '7. تسوية النزاعات';

  @override
  String get bookingTripTermsSection7Body =>
      'يتم حل أي نزاعات تنشأ عن هذه الشروط عبر التفاوض الودي. وفي حال عدم التوصل إلى حل تُحال النزاعات إلى الجهات القضائية المختصة. تخضع هذه الشروط لقوانين جمهورية مصر العربية.';

  @override
  String get bookingTripInstructionsTitle => 'تعليمات الرحلة';

  @override
  String get bookingTripInstructionsHeader => 'قبل الانطلاق';

  @override
  String get bookingTripInstructionsIntro =>
      'يرجى قراءة التعليمات التالية بعناية لضمان تجربة رحلة سلسة وممتعة. سيساعدك الاستعداد الجيد على الاستفادة القصوى من مغامرة دهب.';

  @override
  String get bookingTripInstructionsWhatToPack => 'ماذا تحزم';

  @override
  String get bookingTripInstructionsMeetingPointTime => 'نقطة ووقت التجمع';

  @override
  String get bookingTripInstructionsDocumentsToBring => 'الوثائق المطلوبة';

  @override
  String get bookingTripInstructionsImportantReminders => 'تذكيرات مهمة';

  @override
  String get bookingTripSafetyTitle => 'سلامة الرحلة';

  @override
  String get bookingTripSafetyBanner =>
      'سلامتك هي أولويتنا. يرجى قراءة الإرشادات التالية بعناية.';

  @override
  String get bookingTripSafetyHeader => 'إجراءات السلامة';

  @override
  String get bookingTripSafetyIntro =>
      'في Trip Marche نلتزم بضمان سلامة وراحة جميع المسافرين. تم تصميم رحلاتنا بإجراءات سلامة شاملة وجميع مرشدينا مدربون على الإسعافات الأولية وإجراءات الطوارئ.';

  @override
  String get bookingTripSafetyWaterTitle => 'سلامة الأنشطة المائية';

  @override
  String get bookingTripSafetyDesertTitle => 'سلامة الصحراء';

  @override
  String get bookingTripSafetyHealthTitle => 'الصحة والرعاية الطبية';

  @override
  String get bookingTripSafetyEmergencyTitle => 'جهات الاتصال في الطوارئ';

  @override
  String get bookingTripSafetyGeneralTipsTitle => 'نصائح سلامة عامة';

  @override
  String get authResetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get authResetPasswordSubtitle => 'أدخل كلمة المرور الجديدة أدناه';

  @override
  String get authNewPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get authNewPasswordHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get authConfirmNewPasswordLabel => 'تأكيد كلمة المرور الجديدة';

  @override
  String get authConfirmNewPasswordHint => 'أكد كلمة المرور الجديدة';

  @override
  String get authResetPasswordButton => 'إعادة تعيين كلمة المرور';

  @override
  String get tripDetailsDurationUnit => 'أيام';

  @override
  String get tripDetailsProgramDayPrefix => 'يوم';

  @override
  String get tripDetailsTypeDomestic => 'محلي';

  @override
  String get tripDetailsPayOnArrival => 'الدفع عند الوصول';

  @override
  String get tripDetailsFailedToLoad => 'تعذر تحميل تفاصيل الرحلة.';

  @override
  String get tripDetailsTryAgain => 'إعادة المحاولة';

  @override
  String get tripDetailsNoFlights =>
      'ستظهر تفاصيل الرحلة الجوية هنا عند توفرها.';

  @override
  String get tripDetailsNoTransport =>
      'ستظهر تفاصيل النقل البري أو البحري هنا عند توفرها.';

  @override
  String get tripDetailsVisaAndEntryTitle => 'التأشيرة والدخول';
}
