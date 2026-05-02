import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';

class ContactInfoView extends StatefulWidget {
  const ContactInfoView({super.key});

  @override
  State<ContactInfoView> createState() => _ContactInfoViewState();
}

class _ContactInfoViewState extends State<ContactInfoView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _idPassportController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _emergencyContactController.dispose();
    _idPassportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.bookingContactInfoTitle,
          style: AppTextStyles.bodyMedium(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: context.tr.bookingContactFullNameLabel,
                hint: context.tr.bookingContactFullNameHint,
                controller: _fullNameController,
                icon: Iconsax.user,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: context.tr.bookingContactPhoneLabel,
                hint: context.tr.bookingContactPhoneHint,
                controller: _phoneController,
                icon: Iconsax.call,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: context.tr.bookingContactEmailLabel,
                hint: context.tr.bookingContactEmailHint,
                controller: _emailController,
                icon: Iconsax.sms,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: context.tr.bookingContactEmergencyLabel,
                hint: context.tr.bookingContactEmergencyHint,
                controller: _emergencyContactController,
                icon: Iconsax.call_calling,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: context.tr.bookingContactIdPassportLabel,
                hint: context.tr.bookingContactIdPassportHint,
                controller: _idPassportController,
                icon: Iconsax.card,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 40),
              _buildContinueButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyMedium()),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.tr.errorFieldRequired;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              color: AppColors.greyText,
            ),
            prefixIcon: Icon(icon, color: AppColors.greyText, size: 20),
            filled: true,
            fillColor: AppColors.inputBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          // Navigate to next screen
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            context.tr.bookingContinue,
            style: AppTextStyles.button(),
          ),
        ),
      ),
    );
  }
}
