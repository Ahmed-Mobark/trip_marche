import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/widgets/app_text_form_field.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import '../../../../features/profile/presentation/cubit/change_password_cubit.dart';
import '../../../../features/profile/presentation/cubit/change_password_state.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  State<ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final FocusNode _currentPasswordFocus;
  late final FocusNode _newPasswordFocus;

  bool _obscureCurrent = true;
  bool _obscureNew = true;

  String? _currentError;
  String? _newError;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _currentPasswordFocus = FocusNode();
    _newPasswordFocus = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentPasswordFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    super.dispose();
  }

  bool get _isCurrentValid =>
      _currentPasswordController.text.trim().isNotEmpty;

  bool get _isNewValid {
    final value = _newPasswordController.text.trim();
    return value.isNotEmpty && value.length >= 8;
  }

  bool get _canSubmit => _isCurrentValid && _isNewValid;

  void _validateCurrent() {
    final value = _currentPasswordController.text.trim();
    setState(() {
      _currentError = value.isEmpty ? context.tr.errorFieldRequired : null;
    });
  }


  void _validateNew() {
    final value = _newPasswordController.text.trim();
    setState(() {
      if (value.isEmpty) {
        _newError = context.tr.errorFieldRequired;
      } else if (value.length < 8) {
        _newError = context.tr.errorPasswordMinLength;
      } else {
        _newError = null;
      }
    });
  }

  String? _apiErrorText(ChangePasswordState state) {
    if (state.status != ChangePasswordStatus.failure) return null;
    final msg = state.errorMessage;
    if (msg == null || msg.isEmpty) return context.tr.somethingWentWrong;
    return msg;
  }

  Future<void> _submit() async {
    _validateCurrent();
    _validateNew();
    if (!_canSubmit) return;

    final cubit = context.read<ChangePasswordCubit>();
    await cubit.changePassword(
      currentPassword: _currentPasswordController.text.trim(),
      password: _newPasswordController.text.trim(),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    required String? errorText,
    required VoidCallback onChanged,
    required VoidCallback onValidate,
    TextInputAction? textInputAction,
    FocusNode? nextFocus,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextFormField(
          controller: controller,
          focusNode: focusNode,
          hintText: hint,
          obscureText: obscure,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: textInputAction,
          autofillHints: const [AutofillHints.password],
          onChanged: (_) => onChanged(),
          validator: (_) => errorText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: (_) {
            if (nextFocus != null) {
              nextFocus.requestFocus();
            } else {
              onValidate();
            }
          },
          suffixWidget: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              size: 20.sp,
              color: Theme.of(context).hintColor,
            ),
            onPressed: onToggle,
          ),
        ),
        BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          builder: (context, state) {
            final apiError = _apiErrorText(state);
            if (apiError == null) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsetsDirectional.only(top: 8.h),
              child: Text(
                apiError,
                style: AppTextStyles.bodySmall(color: AppColors.error),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.status == ChangePasswordStatus.success) {
          appToast(
            context: context,
            type: ToastType.success,
            message: context.tr.passwordUpdatedSuccessfully,
          );
          Navigator.pop(context);
        } else if (state.status == ChangePasswordStatus.failure) {
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
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.border(context),
                  borderRadius: BorderRadius.circular(999.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.tr.profileChangePasswordTitle,
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
            _passwordField(
              controller: _currentPasswordController,
              focusNode: _currentPasswordFocus,
              hint: context.tr.profileCurrentPasswordLabel,
              obscure: _obscureCurrent,
              onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
              errorText: _currentError,
              onChanged: () => setState(() {}),
              onValidate: _validateCurrent,
              textInputAction: TextInputAction.next,
              nextFocus: _newPasswordFocus,
            ),
            SizedBox(height: 16.h),
            _passwordField(
              controller: _newPasswordController,
              focusNode: _newPasswordFocus,
              hint: context.tr.profileNewPasswordLabel,
              obscure: _obscureNew,
              onToggle: () => setState(() => _obscureNew = !_obscureNew),
              errorText: _newError,
              onChanged: () => setState(() {}),
              onValidate: _validateNew,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20.h),
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              builder: (context, state) {
                final isLoading =
                    state.status == ChangePasswordStatus.loading;
                return ElevatedButton(
                  onPressed: (!_canSubmit || isLoading) ? null : _submit,
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
                          context.tr.profileUpdatePasswordAction,
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
