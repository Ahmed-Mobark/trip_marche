import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/presentation/widgets/card_preview.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class AddNewCardView extends StatefulWidget {
  const AddNewCardView({super.key});

  @override
  State<AddNewCardView> createState() => _AddNewCardViewState();
}

class _AddNewCardViewState extends State<AddNewCardView> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardholderNameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  String get _maskedCardNumber {
    final text = _cardNumberController.text.replaceAll(' ', '');
    if (text.length < 4) return '**** **** **** ****';
    final last4 = text.substring(text.length > 4 ? text.length - 4 : 0);
    return '**** **** **** $last4';
  }

  String get _displayName {
    return _cardholderNameController.text.isEmpty
        ? context.tr.bookingCardholderNamePlaceholder
        : _cardholderNameController.text.toUpperCase();
  }

  String get _displayExpiry {
    return _expiryController.text.isEmpty
        ? context.tr.bookingExpiryDateHint
        : _expiryController.text;
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardholderNameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
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
          icon: const Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.bookingAddNewCardTitle,
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
              CardPreview(
                maskedCardNumber: _maskedCardNumber,
                cardholderName: _displayName,
                expiry: _displayExpiry,
              ),
              const SizedBox(height: 32),
              _buildField(
                label: context.tr.bookingCardNumberLabel,
                hint: context.tr.bookingCardNumberHint,
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberFormatter(),
                ],
                icon: Iconsax.card,
              ),
              const SizedBox(height: 20),
              _buildField(
                label: context.tr.bookingCardholderNameLabel,
                hint: context.tr.bookingCardholderNameHint,
                controller: _cardholderNameController,
                keyboardType: TextInputType.name,
                icon: Iconsax.user,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      label: context.tr.bookingExpiryDateLabel,
                      hint: context.tr.bookingExpiryDateHint,
                      controller: _expiryController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        _ExpiryDateFormatter(),
                      ],
                      icon: Iconsax.calendar,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildField(
                      label: context.tr.bookingCvvLabel,
                      hint: context.tr.bookingCvvHint,
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      obscure: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      icon: Iconsax.lock,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _buildSaveButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyMedium()),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          inputFormatters: inputFormatters,
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return context.tr.errorFieldRequired;
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.greyText),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pop(context);
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.primary, AppColors.primary]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(context.tr.bookingSaveCard, style: AppTextStyles.button()),
        ),
      ),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        buffer.write(' ');
      }
    }
    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && i != text.length - 1) {
        buffer.write('/');
      }
    }
    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
