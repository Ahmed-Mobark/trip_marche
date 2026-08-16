import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';

import '../../../../core/widgets/app_phone_number_field.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/toast/app_toast.dart';
import '../../../profile/presentation/cubit/update_profile_cubit.dart';
import '../../../profile/presentation/cubit/update_profile_state.dart';

enum EditProfileField { name, phone }

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({
    super.key,
    required this.field,
    this.initialValue = '',
    this.initialCountryCode = '',
    this.initialNumber = '',
  });

  final EditProfileField field;
  final String initialValue;
  final String initialCountryCode;
  final String initialNumber;

  @override
  State<EditProfileBottomSheet> createState() =>
      _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _errorText;
  String _selectedDialCode = '';
  String? _originalCountryCode;
  String? _originalPhoneNumber;

  @override
  void initState() {
    super.initState();
    if (widget.field == EditProfileField.phone) {
      _originalCountryCode = widget.initialCountryCode.trim();
      _selectedDialCode = widget.initialCountryCode.trim();
      _originalPhoneNumber = widget.initialNumber.trim();
      _controller = TextEditingController(text: widget.initialNumber);
    } else {
      _originalPhoneNumber = widget.initialValue.trim();
      _controller = TextEditingController(text: widget.initialValue);
    }
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _title {
    return widget.field == EditProfileField.name
        ? context.tr.profileFullNameLabel
        : context.tr.profilePhoneNumberLabel;
  }

  bool get _isValid {
    final value = _controller.text.trim();
    if (widget.field == EditProfileField.name) {
      return value.isNotEmpty && value.length >= 3;
    }
    if (widget.field == EditProfileField.phone) {
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      return digits.isNotEmpty && digits.length >= 7;
    }
    return false;
  }

  static String _normalizePhone(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '').trim();
  }

  bool get _canSave {
    final originalCountry = _originalCountryCode ?? '';
    final originalNumber = _originalPhoneNumber ?? '';
    if (widget.field == EditProfileField.phone) {
      final currentCountry = _selectedDialCode.trim();
      final currentNumber = _normalizePhone(_controller.text);
      final countryChanged = currentCountry != originalCountry;
      final numberChanged = currentNumber != _normalizePhone(originalNumber);
      return (countryChanged || numberChanged) && _isValid;
    }
    final currentValue = _controller.text.trim();
    final changed = currentValue != originalNumber;
    return changed && _isValid;
  }

  void _validate() {
    final value = _controller.text.trim();
    if (widget.field == EditProfileField.name) {
      if (value.isEmpty) {
        setState(() => _errorText = context.tr.errorFieldRequired);
      } else if (value.length < 3) {
        setState(() => _errorText = 'Minimum 3 characters required');
      } else {
        setState(() => _errorText = null);
      }
    } else if (widget.field == EditProfileField.phone) {
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      if (digits.isEmpty) {
        setState(() => _errorText = context.tr.errorFieldRequired);
      } else if (!RegExp(r'^[0-9]+$').hasMatch(digits) || digits.length < 7) {
        setState(() => _errorText = context.tr.errorInvalidPhoneNumber);
      } else {
        setState(() => _errorText = null);
      }
    }
  }

  String? _apiErrorText(UpdateProfileState state) {
    if (state.status != UpdateProfileStatus.failure) return null;
    final msg = state.errorMessage;
    if (msg == null || msg.isEmpty) return 'Something went wrong';
    return msg;
  }

  Future<void> _submit() async {
    _validate();
    if (!_isValid) return;

    final cubit = context.read<UpdateProfileCubit>();
    final trimmedValue = _controller.text.trim();

    if (widget.field == EditProfileField.phone) {
      await cubit.updateProfile(
        phoneCountryCode: _selectedDialCode.trim(),
        phoneNumber: trimmedValue,
      );
    } else {
      await cubit.updateProfile(name: trimmedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = widget.field == EditProfileField.phone;

    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state.status == UpdateProfileStatus.success) {
          if (widget.field == EditProfileField.phone) {
            _originalCountryCode = _selectedDialCode.trim();
            _originalPhoneNumber = _normalizePhone(_controller.text);
          } else {
            _originalPhoneNumber = _controller.text.trim();
          }
          appToast(
            context: context,
            type: ToastType.success,
            message: 'Profile updated successfully',
          );
          Navigator.pop(context);
        } else if (state.status == UpdateProfileStatus.failure) {
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          top: 12.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
              decoration: BoxDecoration(
                color: AppColors.border(context),
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _title,
                    style: AppTextStyles.heading3(
                      color: AppColors.darkText(context),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: AppColors.darkText(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (isPhone)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppPhoneNumberField(
                    variant: AppPhoneNumberFieldVariant.auth,
                    controller: _controller,
                    hint: context.tr.authPhoneHint,
                    selectedDialCode: _selectedDialCode,
                    initialCountryCode: _selectedDialCode,
                    onDialCodeChanged: (code) {
                      setState(() => _selectedDialCode = code);
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    validator: (_) => _errorText,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                    builder: (context, state) {
                      final apiError = _apiErrorText(state);
                      if (apiError == null) return const SizedBox.shrink();
                      return Padding(
                        padding: EdgeInsetsDirectional.only(top: 8.h),
                        child: Text(
                          apiError,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.error,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextFormField(
                    controller: _controller,
                    hintText: context.tr.authFullNameHint,
                    validator: (_) => _errorText,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                    builder: (context, state) {
                      final apiError = _apiErrorText(state);
                      if (apiError == null) return const SizedBox.shrink();
                      return Padding(
                        padding: EdgeInsetsDirectional.only(top: 8.h),
                        child: Text(
                          apiError,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.error,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            SizedBox(height: 20.h),
            BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
              builder: (context, state) {
                final isLoading = state.status == UpdateProfileStatus.loading;
                return ElevatedButton(
                  onPressed: (!_canSave || isLoading) ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.border(context),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: const CustomLoading(
                            size: 20,
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          context.tr.commonOk,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.onPrimary(context),
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                );
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
