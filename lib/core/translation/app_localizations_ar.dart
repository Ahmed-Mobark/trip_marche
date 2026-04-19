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
  String get authTravelAgencyPrompt => 'وكالة سفر؟ ';

  @override
  String get authJoinAsTripPartner => 'انضم كشريك رحلات';

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
  String get authForgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get authForgotPasswordDescription =>
      'أدخل بريدك الإلكتروني أدناه وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get authSendButton => 'إرسال';

  @override
  String get authVerifyTitle => 'تحقق من رقمك';

  @override
  String get authVerifyDescription =>
      'لقد أرسلنا لك رمز تحقق إلى رقمك المسجل. يرجى إدخال الرمز أدناه.';

  @override
  String get authVerifyButton => 'تحقق';

  @override
  String get authResendCode => 'إعادة إرسال الرمز';

  @override
  String get wishlistTitle => 'المفضلة';

  @override
  String get wishlistEmptyTitle => 'لا توجد رحلات محفوظة بعد';

  @override
  String get wishlistEmptyDescription =>
      'اضغط على أيقونة القلب في أي رحلة\nلحفظها في المفضلة.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsNotificationSetting => 'إعدادات الإشعارات';

  @override
  String get settingsLanguage => 'اللغة';

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
  String get followingsTitle => 'الشركات التي أتابعها';

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
  String get tripDetailsGroupSizeValue => '20 شخص';

  @override
  String get tripDetailsGroupSizeLabel => 'حجم المجموعة';

  @override
  String get tripDetailsTypeValue => 'مختلط';

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
}
