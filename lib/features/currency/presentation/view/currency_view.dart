import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_empty_screen.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/services/currency_converter.dart';
import '../cubit/currency_cubit.dart';
import '../cubit/currency_state.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({super.key});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  @override
  void initState() {
    super.initState();
    sl<CurrencyCubit>().loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<CurrencyCubit>(),
      child: const _CurrencyViewBody(),
    );
  }
}

class _CurrencyViewBody extends StatefulWidget {
  const _CurrencyViewBody();

  @override
  State<_CurrencyViewBody> createState() => _CurrencyViewBodyState();
}

class _CurrencyViewBodyState extends State<_CurrencyViewBody> {
  final TextEditingController _amountController = TextEditingController();
  double? _amount;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged(String value) {
    setState(() {
      _amount = double.tryParse(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final background = AppColors.background(context);
    final textColor = AppColors.bodyText(context);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.settingsCurrency,
          style: AppTextStyles.subtitle(color: textColor),
        ),
      ),
      body: BlocBuilder<CurrencyCubit, CurrencyState>(
        builder: (context, state) {
          if (state.status == CurrencyStatus.loading &&
              state.currencies.isEmpty) {
            return const Center(child: CustomLoading(top: 40, bottom: 40));
          }
          if (state.status == CurrencyStatus.failure &&
              state.currencies.isEmpty) {
            return _CurrencyError(
              message: state.errorMessage ?? context.tr.sorryMessage,
              onRetry: context.read<CurrencyCubit>().loadCurrencies,
            );
          }
          if (state.status == CurrencyStatus.empty) {
            return AppEmptyScreen(
              title: context.tr.settingsCurrency,
              description: context.tr.nothingFound,
            );
          }

          return ListView.separated(
            padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 24.h),
            itemCount: state.currencies.length,
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final currency = state.currencies[index];
              final egpCurrency = _findEgpCurrency(state.currencies);
              return _CurrencyTile(
                currency: currency,
                egpCurrency: egpCurrency,
                selected: currency.code == state.selectedCode,
                amountController: _amountController,
                amount: _amount,
                onAmountChanged: _onAmountChanged,
                onTap: () =>
                    context.read<CurrencyCubit>().selectCurrency(currency),
              );
            },
          );
        },
      ),
    );
  }

  CurrencyEntity? _findEgpCurrency(List<CurrencyEntity> currencies) {
    for (final currency in currencies) {
      if (currency.code == 'EGP' && currency.isBase) return currency;
    }
    for (final currency in currencies) {
      if (currency.code == 'EGP') return currency;
    }
    return null;
  }
}

class _CurrencyTile extends StatelessWidget {
  const _CurrencyTile({
    required this.currency,
    required this.egpCurrency,
    required this.selected,
    required this.amountController,
    required this.amount,
    required this.onAmountChanged,
    required this.onTap,
  });

  final CurrencyEntity currency;
  final CurrencyEntity? egpCurrency;
  final bool selected;
  final TextEditingController amountController;
  final double? amount;
  final ValueChanged<String> onAmountChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleColor = AppColors.bodyText(context);
    final muted = AppColors.greyText(context);

    return Material(
      color: AppColors.cardBg(context),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border(context),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      currency.symbol.isEmpty ? currency.code : currency.symbol,
                      style: AppTextStyles.bodyMedium(color: AppColors.primary),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currency.name,
                          style: AppTextStyles.bodyMedium(color: titleColor),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          currency.code,
                          style: AppTextStyles.bodySmall(color: muted),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: selected ? AppColors.primary : muted,
                  ),
                ],
              ),
              if (selected) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  child: Divider(height: 1, color: AppColors.border(context)),
                ),
                _CurrencyConversion(
                  currency: currency,
                  egpCurrency: egpCurrency,
                  controller: amountController,
                  amount: amount,
                  onChanged: onAmountChanged,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyConversion extends StatelessWidget {
  const _CurrencyConversion({
    required this.currency,
    required this.egpCurrency,
    required this.controller,
    required this.amount,
    required this.onChanged,
  });

  final CurrencyEntity currency;
  final CurrencyEntity? egpCurrency;
  final TextEditingController controller;
  final double? amount;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final converted = amount == null || egpCurrency == null
        ? null
        : CurrencyConverter.toEgp(
            amount: amount!,
            selectedRate: currency.rate,
            egpRate: egpCurrency!.rate,
          );
    if (kDebugMode && amount != null) {
      debugPrint('Selected currency: ${currency.code}');
      debugPrint('Selected currency rate: ${currency.rate}');
      debugPrint('Base currency: ${egpCurrency?.code ?? 'not found'}');
      debugPrint('Base currency rate: ${egpCurrency?.rate ?? 'not found'}');
      debugPrint('Entered amount: $amount');
      debugPrint('Conversion formula used: amount * selectedRate / egpRate');
      debugPrint('Calculated EGP amount: ${converted ?? 'unavailable'}');
    }
    final suffix = currency.symbol.isEmpty
        ? currency.code
        : '${currency.symbol}  ${currency.code}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${currency.name} (${currency.code})',
          style: AppTextStyles.bodySmall(
            color: AppColors.bodyText(context),
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: context.tr.currencyAmountLabel,
            hintText: '0.00',
            suffixText: suffix,
            filled: true,
            fillColor: AppColors.background(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.border(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.border(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          context.tr.currencyEquivalentEgp,
          style: AppTextStyles.bodySmall(color: AppColors.greyText(context)),
        ),
        SizedBox(height: 4.h),
        Text(
          '${_formatAmount(converted)} EGP',
          style: AppTextStyles.subtitle(color: AppColors.primary),
        ),
      ],
    );
  }

  String _formatAmount(double? value) {
    if (value == null || !value.isFinite) return '—';
    final fixed = value.toStringAsFixed(2);
    return fixed.replaceFirst(RegExp(r'\.00$'), '');
  }
}

class _CurrencyError extends StatelessWidget {
  const _CurrencyError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: AppColors.bodyText(context),
              ),
            ),
            SizedBox(height: 12.h),
            IconButton.filled(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
