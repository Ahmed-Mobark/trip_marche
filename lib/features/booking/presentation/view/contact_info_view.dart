import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/contact_info_figma_tokens.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/bottom_booking_bar.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/traveler_contact.dart';
import '../widgets/traveler_contact_card.dart';
import 'select_activities_view.dart';

class _TravelerFormControllers {
  _TravelerFormControllers() : countryCode = '+20';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String countryCode;

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
  }
}

class ContactInfoView extends StatefulWidget {
  const ContactInfoView({
    required this.travelersCount,
    required this.flowContext,
    super.key,
  });

  final int travelersCount;
  final BookingFlowContext flowContext;

  @override
  State<ContactInfoView> createState() => _ContactInfoViewState();
}

class _ContactInfoViewState extends State<ContactInfoView> {
  final _formKey = GlobalKey<FormState>();
  late final List<_TravelerFormControllers> _travelerForms;
  late final int _effectiveTravelersCount;
  bool _validateOnSubmit = false;

  @override
  void initState() {
    super.initState();
    _effectiveTravelersCount = widget.travelersCount < 1 ? 1 : widget.travelersCount;
    _travelerForms = List.generate(
      _effectiveTravelersCount,
      (_) => _TravelerFormControllers(),
    );
  }

  @override
  void dispose() {
    for (final form in _travelerForms) {
      form.dispose();
    }
    super.dispose();
  }

  AutovalidateMode get _autovalidateMode =>
      _validateOnSubmit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled;

  void _onContinue() {
    setState(() => _validateOnSubmit = true);
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final contacts = List<TravelerContact>.generate(
      _travelerForms.length,
      (index) {
        final form = _travelerForms[index];
        return TravelerContact(
          fullName: form.nameController.text.trim(),
          phoneNumber: form.phoneController.text.trim(),
          countryCode: form.countryCode,
        );
      },
    );

    sl<AppNavigator>().push(
      screen: SelectActivitiesView(
        travelers: contacts,
        flowContext: widget.flowContext,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: ContactInfoFigmaTokens.screenBackground,
      ),
      child: Scaffold(
        backgroundColor: ContactInfoFigmaTokens.screenBackground,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: ContactInfoFigmaTokens.titleTop,
                  bottom: ContactInfoFigmaTokens.titleBottom,
                ),
                child: Text(
                  tr.bookingContactInfoTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3(
                    color: AppColors.tripDetailsFigmaBlack,
                  ).copyWith(
                    fontSize: ContactInfoFigmaTokens.titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView.separated(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      ContactInfoFigmaTokens.screenPadding,
                      0,
                      ContactInfoFigmaTokens.screenPadding,
                      16.h,
                    ),
                    itemCount: _travelerForms.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: ContactInfoFigmaTokens.cardGap),
                    itemBuilder: (context, index) {
                      final form = _travelerForms[index];
                      return TravelerContactCard(
                        travelerTitle: tr.bookingTravelerTitle(index + 1),
                        fullNameLabel: tr.bookingContactFullNameLabel,
                        fullNameHint: tr.bookingContactFullNameHint,
                        phoneLabel: tr.bookingContactPhoneLabel,
                        phoneHint: tr.bookingContactPhoneNumberHint,
                        nameController: form.nameController,
                        phoneController: form.phoneController,
                        countryCode: form.countryCode,
                        onCountryCodeChanged: (code) {
                          setState(() => form.countryCode = code);
                        },
                        requiredErrorText: tr.errorFieldRequired,
                        autovalidateMode: _autovalidateMode,
                      );
                    },
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: BottomBookingBar(
                  backButtonCircular: true,
                  onBack: () => Navigator.pop(context),
                  onContinue: _onContinue,
                  continueLabel: tr.bookingContinue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
