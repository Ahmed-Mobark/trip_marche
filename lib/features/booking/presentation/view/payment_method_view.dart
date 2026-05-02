import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/payment_option_tile.dart';
import '../../../../core/extensions/localization.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  String _selectedMethod = 'credit_card';
  int _selectedCard = 0;

  final List<Map<String, String>> _savedCards = [
    {'last4': '4242', 'brand': 'Visa', 'expiry': '12/27'},
    {'last4': '8888', 'brand': 'Mastercard', 'expiry': '06/28'},
  ];

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
          context.tr.bookingPaymentMethodTitle,
          style: AppTextStyles.bodyMedium(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentOptionTile(
              value: 'credit_card',
              groupValue: _selectedMethod,
              icon: Iconsax.card,
              title: context.tr.bookingPaymentOptionCreditCard,
              subtitle: context.tr.bookingPaymentOptionCreditCardSubtitle,
              onChanged: (v) => setState(() => _selectedMethod = v!),
            ),
            const SizedBox(height: 10),
            PaymentOptionTile(
              value: 'paypal',
              groupValue: _selectedMethod,
              icon: Iconsax.wallet_3,
              title: context.tr.bookingPaymentOptionPaypal,
              subtitle: context.tr.bookingPaymentOptionPaypalSubtitle,
              onChanged: (v) => setState(() => _selectedMethod = v!),
            ),
            const SizedBox(height: 10),
            PaymentOptionTile(
              value: 'apple_pay',
              groupValue: _selectedMethod,
              icon: Iconsax.mobile,
              title: context.tr.bookingPaymentOptionApplePay,
              subtitle: context.tr.bookingPaymentOptionApplePaySubtitle,
              onChanged: (v) => setState(() => _selectedMethod = v!),
            ),
            if (_selectedMethod == 'credit_card') ...[
              const SizedBox(height: 24),
              Text(
                context.tr.bookingSavedCards,
                style: AppTextStyles.bodyMedium(color: AppColors.darkText),
              ),
              const SizedBox(height: 12),
              ..._buildSavedCards(),
              const SizedBox(height: 12),
              _buildAddNewCard(),
            ],
            const SizedBox(height: 32),
            _buildPayButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSavedCards() {
    return List.generate(_savedCards.length, (index) {
      final card = _savedCards[index];
      final isSelected = _selectedCard == index;
      return GestureDetector(
        onTap: () => setState(() => _selectedCard = index),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [AppColors.primary, AppColors.primary])
                : null,
            color: isSelected ? null : AppColors.inputBg,
            borderRadius: BorderRadius.circular(14),
            border: isSelected ? null : Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.card,
                color: isSelected ? AppColors.onImage : AppColors.greyText,
                size: 24,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${card['brand']} **** ${card['last4']}',
                      style: AppTextStyles.bodyMedium(
                        color: isSelected
                            ? AppColors.onImage
                            : AppColors.darkText,
                      ),
                    ),
                    Text(
                      context.tr.bookingCardExpires(card['expiry'] ?? ''),
                      style: AppTextStyles.bodyMedium(
                        color: isSelected
                            ? AppColors.onImage.withValues(alpha: 0.70)
                            : AppColors.greyText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.onImage : AppColors.greyText,
                    width: 2,
                  ),
                  color: isSelected ? AppColors.onImage : AppColors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAddNewCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.add_circle, color: AppColors.primary, size: 22),
            const SizedBox(width: 8),
            Text(
              context.tr.bookingAddNewCard,
              style: AppTextStyles.bodyMedium(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return GestureDetector(
      onTap: () {},
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
            context.tr.bookingPayNow('779'),
            style: AppTextStyles.button(),
          ),
        ),
      ),
    );
  }
}
