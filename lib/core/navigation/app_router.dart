import 'package:flutter/material.dart';
import 'package:trip_marche/features/splash/presentation/view/splash_view.dart';
import 'package:trip_marche/features/auth/presentation/view/login_view.dart';
import 'package:trip_marche/features/auth/presentation/view/sign_up_view.dart';
import 'package:trip_marche/features/auth/presentation/view/forgot_password_view.dart';
import 'package:trip_marche/features/auth/presentation/view/verify_number_view.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';
import 'package:trip_marche/features/search/presentation/view/search_result_view.dart';
import 'package:trip_marche/features/search/presentation/view/destination_view.dart';
import 'package:trip_marche/features/filter/presentation/view/filter_view.dart';
import 'package:trip_marche/features/booking/presentation/view/trip_options_view.dart';
import 'package:trip_marche/features/booking/presentation/view/contact_info_view.dart';
import 'package:trip_marche/features/booking/presentation/view/select_activities_view.dart';
import 'package:trip_marche/features/booking/presentation/view/review_view.dart';
import 'package:trip_marche/features/booking/presentation/view/payment_method_view.dart';
import 'package:trip_marche/features/booking/presentation/view/add_new_card_view.dart';
import 'package:trip_marche/features/booking/presentation/view/visa_details_view.dart';
import 'package:trip_marche/features/booking/presentation/view/trip_instructions_view.dart';
import 'package:trip_marche/features/booking/presentation/view/trip_safety_view.dart';
import 'package:trip_marche/features/booking/presentation/view/trip_terms_view.dart';
import 'package:trip_marche/features/booking/presentation/view/trip_cancellation_view.dart';
import 'package:trip_marche/features/profile/presentation/view/profile_view.dart';
import 'package:trip_marche/features/profile/presentation/view/personal_info_view.dart';
import 'package:trip_marche/features/profile/presentation/view/my_reviews_view.dart';
import 'package:trip_marche/features/profile/presentation/view/write_review_view.dart';
import 'package:trip_marche/features/profile/presentation/view/my_followings_view.dart';
import 'package:trip_marche/features/company_profile/presentation/view/company_profile_view.dart';
import 'package:trip_marche/features/my_trips/presentation/view/my_trips_view.dart';
import 'package:trip_marche/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:trip_marche/features/notifications/presentation/view/notifications_view.dart';
import 'package:trip_marche/features/settings/presentation/view/settings_view.dart';
import 'package:trip_marche/features/settings/presentation/view/notification_settings_view.dart';
import 'package:trip_marche/features/settings/presentation/view/language_view.dart';
import 'package:trip_marche/features/settings/presentation/view/faqs_view.dart';
import 'package:trip_marche/features/settings/presentation/view/customer_service_view.dart';
import 'package:trip_marche/features/settings/presentation/view/cancellation_policy_view.dart';
import 'package:trip_marche/features/settings/presentation/view/terms_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String verifyNumber = '/verify';

  static const String home = '/home';
  static const String tripDetails = '/trip-details';
  static const String searchResult = '/search-result';
  static const String filter = '/filter';
  static const String destination = '/destination';

  static const String tripOptions = '/trip-options';
  static const String contactInfo = '/contact-info';
  static const String selectActivities = '/select-activities';
  static const String review = '/review';
  static const String paymentMethod = '/payment-method';
  static const String addNewCard = '/add-new-card';

  static const String profile = '/profile';
  static const String personalInfo = '/personal-info';
  static const String myReviews = '/my-reviews';
  static const String writeReview = '/write-review';
  static const String myFollowings = '/my-followings';
  static const String companyProfile = '/company-profile';

  static const String myTrips = '/my-trips';
  static const String wishlist = '/wishlist';
  static const String notifications = '/notifications';

  static const String settings = '/settings';
  static const String notificationSettings = '/notification-settings';
  static const String language = '/language';

  static const String faqs = '/faqs';
  static const String customerService = '/customer-service';
  static const String cancellationPolicy = '/cancellation-policy';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String visaDetails = '/visa-details';
  static const String tripInstructions = '/trip-instructions';
  static const String tripSafety = '/trip-safety';
  static const String tripTerms = '/trip-terms';
  static const String tripCancellation = '/trip-cancellation';
}

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _build(settings, const SplashView());
      case AppRoutes.login:
        return _build(settings, const LoginView());
      case AppRoutes.signUp:
        return _build(settings, const SignUpView());
      case AppRoutes.forgotPassword:
        return _build(settings, const ForgotPasswordView());
      case AppRoutes.verifyNumber:
        return _build(settings, const VerifyNumberView());
      case AppRoutes.home:
        return _build(settings, const MainNavView());
      case AppRoutes.tripDetails:
        return _build(settings, const TripDetailsView());
      case AppRoutes.searchResult:
        return _build(settings, const SearchResultView());
      case AppRoutes.filter:
        return _build(settings, const FilterView());
      case AppRoutes.destination:
        return _build(settings, const DestinationView());
      case AppRoutes.tripOptions:
        return _build(settings, const TripOptionsView());
      case AppRoutes.contactInfo:
        return _build(settings, const ContactInfoView());
      case AppRoutes.selectActivities:
        return _build(settings, const SelectActivitiesView());
      case AppRoutes.review:
        return _build(settings, const ReviewView());
      case AppRoutes.paymentMethod:
        return _build(settings, const PaymentMethodView());
      case AppRoutes.addNewCard:
        return _build(settings, const AddNewCardView());
      case AppRoutes.profile:
        return _build(settings, const ProfileView());
      case AppRoutes.personalInfo:
        return _build(settings, const PersonalInfoView());
      case AppRoutes.myReviews:
        return _build(settings, const MyReviewsView());
      case AppRoutes.writeReview:
        return _build(settings, const WriteReviewView());
      case AppRoutes.myFollowings:
        return _build(settings, const MyFollowingsView());
      case AppRoutes.companyProfile:
        return _build(settings, const CompanyProfileView());
      case AppRoutes.myTrips:
        return _build(settings, const MyTripsView());
      case AppRoutes.wishlist:
        return _build(settings, const WishlistView());
      case AppRoutes.notifications:
        return _build(settings, const NotificationsView());
      case AppRoutes.settings:
        return _build(settings, const SettingsView());
      case AppRoutes.notificationSettings:
        return _build(settings, const NotificationSettingsView());
      case AppRoutes.language:
        return _build(settings, const LanguageView());
      case AppRoutes.faqs:
        return _build(settings, const FaqsView());
      case AppRoutes.customerService:
        return _build(settings, const CustomerServiceView());
      case AppRoutes.cancellationPolicy:
        return _build(settings, const CancellationPolicyView());
      case AppRoutes.termsAndConditions:
        return _build(settings, const TermsView());
      case AppRoutes.visaDetails:
        return _build(settings, const VisaDetailsView());
      case AppRoutes.tripInstructions:
        return _build(settings, const TripInstructionsView());
      case AppRoutes.tripSafety:
        return _build(settings, const TripSafetyView());
      case AppRoutes.tripTerms:
        return _build(settings, const TripTermsView());
      case AppRoutes.tripCancellation:
        return _build(settings, const TripCancellationView());
      default:
        return _build(
          settings,
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static MaterialPageRoute _build(RouteSettings settings, Widget page) {
    return MaterialPageRoute(settings: settings, builder: (_) => page);
  }
}
