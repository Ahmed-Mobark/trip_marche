import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_destination.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_cubit.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_state.dart';
import 'package:trip_marche/features/filter/presentation/view/search_result_view.dart';
import 'package:trip_marche/features/my_trips/domain/entities/trips_catalog_filters.dart';

/// Typeable search entry-point (#50). Users land here from the home search
/// bar, type a destination, and either submit the free-text query or pick a
/// suggestion. Both paths push [SearchResultView] which renders results +
/// the sort/filter row (#51, #52).
class DestinationSearchView extends StatelessWidget {
  const DestinationSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilterCubit>(
      create: (_) => sl<FilterCubit>()..loadDestinations(),
      child: const _DestinationSearchScaffold(),
    );
  }
}

class _DestinationSearchScaffold extends StatefulWidget {
  const _DestinationSearchScaffold();

  @override
  State<_DestinationSearchScaffold> createState() =>
      _DestinationSearchScaffoldState();
}

class _DestinationSearchScaffoldState
    extends State<_DestinationSearchScaffold> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    // Defer autofocus so the bottom sheet transition finishes first.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void _onTextChanged() {
    final next = _controller.text;
    if (next == _query) {
      return;
    }
    setState(() => _query = next);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitQuery() {
    final trimmed = _controller.text.trim();
    if (trimmed.isEmpty) {
      return;
    }
    _openSearchResults(TripsCatalogFilters(search: trimmed));
  }

  void _openDestination(FilterDestination destination) {
    _openSearchResults(
      TripsCatalogFilters(
        search: destination.name,
      ),
    );
  }

  void _openSearchResults(TripsCatalogFilters filters) {
    FocusManager.instance.primaryFocus?.unfocus();
    sl<AppNavigator>().push(screen: SearchResultView(filters: filters));
  }

  List<FilterDestination> _filterDestinations(List<FilterDestination> all) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) {
      return all;
    }
    return all
        .where(
          (d) =>
              d.name.toLowerCase().contains(q) ||
              d.country.toLowerCase().contains(q),
        )
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.background(context),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        appBar: AppBar(
          backgroundColor: AppColors.background(context),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.darkText(context),
              size: 20.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            context.tr.destinationTitle,
            style: AppTextStyles.heading3(
              color: AppColors.darkText(context),
            ).copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.w, 8.h, 16.w, 16.h),
                child: _SearchInput(
                  controller: _controller,
                  focusNode: _focusNode,
                  onSubmitted: _submitQuery,
                ),
              ),
              Expanded(
                child: BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    if (state.destinationsStatus ==
                            FilterDestinationsStatus.loading &&
                        state.availableDestinations.isEmpty) {
                      return Center(
                        child: CustomLoading(top: 8.h, size: 32, strokeWidth: 2.5),
                      );
                    }
                    if (state.destinationsStatus ==
                            FilterDestinationsStatus.failure &&
                        state.availableDestinations.isEmpty) {
                      return _ErrorState(
                        message: state.destinationsErrorMessage ??
                            context.tr.tripDetailsFailedToLoad,
                        onRetry: () =>
                            context.read<FilterCubit>().loadDestinations(),
                        retryLabel: context.tr.tripDetailsTryAgain,
                      );
                    }
                    final filtered =
                        _filterDestinations(state.availableDestinations);
                    if (filtered.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Text(
                            context.tr.nothingFound,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.secondaryText(context),
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.w,
                        4.h,
                        16.w,
                        24.h + MediaQuery.paddingOf(context).bottom,
                      ),
                      itemCount: filtered.length + 1,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        thickness: 0.5,
                        color: AppColors.border(context).withValues(alpha: 0.6),
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _SectionHeader(
                            label: _query.trim().isEmpty
                                ? context.tr.destinationPopularDestinations
                                : '${filtered.length} ${context.tr.destinationPopularDestinations.toLowerCase()}',
                          );
                        }
                        final destination = filtered[index - 1];
                        return _DestinationRow(
                          destination: destination,
                          onTap: () => _openDestination(destination),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchInput extends StatefulWidget {
  const _SearchInput({
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSubmitted;

  @override
  State<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTick);
  }

  void _onTick() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTick);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hint = context.tr.destinationSearchHint;
    final showClear = widget.controller.text.isNotEmpty;
    return Container(
      height: 48.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.inputBg(context),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal_1,
            size: 20.sp,
            color: AppColors.greyText(context),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => widget.onSubmitted(),
              cursorColor: AppColors.primary,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.darkText(context),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyText(context),
                ),
                // Suppress every border state so the global input theme's
                // outlined pill doesn't render an inner "field-inside-field"
                // ring when this TextField gains focus.
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (showClear) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: () {
                widget.controller.clear();
                widget.focusNode.requestFocus();
              },
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Iconsax.close_circle,
                size: 18.sp,
                color: AppColors.greyText(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 4.h, bottom: 10.h),
      child: Text(
        label,
        style: AppTextStyles.bodyMedium(
          color: AppColors.darkText(context),
        ).copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _DestinationRow extends StatelessWidget {
  const _DestinationRow({required this.destination, required this.onTap});

  final FilterDestination destination;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 12.h, horizontal: 4.w),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.location,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      destination.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.darkText(context),
                      ).copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                    ),
                    if (destination.country.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        destination.country,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption(
                          color: AppColors.secondaryText(context),
                        ).copyWith(fontSize: 12.sp),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
                color: AppColors.greyText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
    required this.retryLabel,
  });

  final String message;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.warning_2,
              size: 42.sp,
              color: AppColors.greyText(context),
            ),
            SizedBox(height: 10.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: AppColors.secondaryText(context),
              ),
            ),
            SizedBox(height: 14.h),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onImage,
              ),
              child: Text(retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
