import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/my_trips/presentation/view/trending_destenation_view.dart';

import '../cubit/trending_destinations_items_cubit.dart';
import '../cubit/trending_destinations_items_state.dart';
import '../view/trending_destinations_list_view.dart';
import 'trending_destination_card.dart';

class HomeTrendingDestinationsSection extends StatelessWidget {
  const HomeTrendingDestinationsSection({
    super.key,
    required this.sectionTitleStyle,
    required this.actionStyle,
  });

  final TextStyle sectionTitleStyle;
  final TextStyle actionStyle;

  void _onScrollNotification(
    BuildContext context,
    TrendingDestinationsItemsState state,
    ScrollNotification n,
  ) {
    if (n.metrics.axis != Axis.horizontal) {
      return;
    }
    final m = n.metrics;
    if (m.pixels >= m.maxScrollExtent - 120) {
      context.read<TrendingDestinationsItemsCubit>().loadMore();
    }
  }

  String _titleWithContext(
    BuildContext context,
    TrendingDestinationsItemsState state,
  ) {
    final fromApi = state.meta?.sectionTitle?.trim() ?? '';
    if (fromApi.isNotEmpty) {
      return fromApi;
    }
    return context.tr.homeTrendingDestinations;
  }

  void _onViewAllTap() {
    sl<AppNavigator>().push(screen: const TrendingDestinationsListView());
  }

  Widget _buildTitleRow(BuildContext context, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: sectionTitleStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _onViewAllTap,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 8.w, top: 2.h),
            child: Text(context.tr.homeViewAll, style: actionStyle),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingDestinationsItemsCubit,
        TrendingDestinationsItemsState>(
      builder: (context, state) {
        final title = _titleWithContext(context, state);

        final showLoadingShell =
            state.status == TrendingDestinationsItemsStatus.initial ||
                (state.status == TrendingDestinationsItemsStatus.loading &&
                    state.destinations.isEmpty);

        if (showLoadingShell) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              _buildTitleRow(context, title),
              SizedBox(height: 12.h),
              SizedBox(height: 110.h, child: CustomLoading(strokeWidth: 2.5)),
              SizedBox(height: 22.h),
            ],
          );
        }

        if (state.status == TrendingDestinationsItemsStatus.failure &&
            state.destinations.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              _buildTitleRow(context, title),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.errorMessage ?? context.tr.nothingFound,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    FilledButton(
                      onPressed: () => context
                          .read<TrendingDestinationsItemsCubit>()
                          .loadInitial(),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onImage,
                      ),
                      child: Text(context.tr.tripDetailsTryAgain),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.h),
            ],
          );
        }

        if (state.destinations.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              _buildTitleRow(context, title),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  context.tr.nothingFound,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.greyText(context),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
            ],
          );
        }

        final itemCount = state.destinations.length +
            (state.status == TrendingDestinationsItemsStatus.loadingMore
                ? 1
                : 0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            _buildTitleRow(context, title),
            SizedBox(height: 12.h),
            SizedBox(
              height: 110.h,
              child: NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  _onScrollNotification(context, state, n);
                  return false;
                },
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (index >= state.destinations.length) {
                      return Padding(
                        padding: EdgeInsetsDirectional.only(start: 8.w),
                        child: Center(
                          child: CustomLoading(size: 28, strokeWidth: 2),
                        ),
                      );
                    }
                    final dest = state.destinations[index];
                    return TrendingDestinationCard(
                      name: dest.name,
                      imageUrl: dest.image,
                      rank: dest.trendingRank,
                      onTap: dest.id <= 0
                          ? null
                          : () {
                              sl<AppNavigator>().push(
                                screen: TrendingDestinationView(
                                  catalogDestinationId: dest.id,
                                  destinationBrowseTitle: dest.name,
                                  catalogDestinationImageUrl: dest.image,
                                  catalogDestinationCountry: dest.country,
                                ),
                              );
                            },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 22.h),
          ],
        );
      },
    );
  }
}
