import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MyTripsViewBody();
  }
}

class _MyTripsViewBody extends StatelessWidget {
  const _MyTripsViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: MyTripsFigmaTokens.padH,
                    end: MyTripsFigmaTokens.padH,
                    top: MyTripsFigmaTokens.headerPadTop,
                    bottom: MyTripsFigmaTokens.headerPadBottom,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.onImage,
                            size: 20.sp,
                          ),
                        ),
                        Text(
                          context.tr.searchResultTitle,
                          style: AppTextStyles.heading3(
                            color: AppColors.onImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(MyTripsFigmaTokens.sheetTopRadius),
                    ),
                  ),
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    slivers: [],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
