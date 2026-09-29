import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_empty_screen.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../domain/entities/currency_entity.dart';
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

class _CurrencyViewBody extends StatelessWidget {
  const _CurrencyViewBody();

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
              return _CurrencyTile(
                currency: currency,
                selected: currency.code == state.selectedCode,
                onTap: () =>
                    context.read<CurrencyCubit>().selectCurrency(currency),
              );
            },
          );
        },
      ),
    );
  }
}

class _CurrencyTile extends StatelessWidget {
  const _CurrencyTile({
    required this.currency,
    required this.selected,
    required this.onTap,
  });

  final CurrencyEntity currency;
  final bool selected;
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
              width: 1.5,
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
            ],
          ),
        ),
      ),
    );
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
