import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/toast/app_toast.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../cubit/add_vendor_review_cubit.dart';
import '../cubit/add_vendor_review_state.dart';

class AddVendorReviewView extends StatefulWidget {
  const AddVendorReviewView({
    super.key,
    required this.vendorId,
    this.title = 'Dahab Trip',
    this.imageUrl = 'https://images.unsplash.com/photo-1528127269322-539801943592?w=900',
    this.routeText = 'Cairo → Dahab',
    this.dateRangeText = '27 Nov → 4 Dec',
    this.ratingValue = '4.9',
    this.ratingCount = '112',
    this.badgeText = 'Best Price',
    this.originalPrice = '\$1000',
    this.discountedPrice = '\$699',
  });

  final int vendorId;
  final String title;
  final String imageUrl;
  final String routeText;
  final String dateRangeText;
  final String ratingValue;
  final String ratingCount;
  final String badgeText;
  final String originalPrice;
  final String discountedPrice;

  @override
  State<AddVendorReviewView> createState() => _AddVendorReviewViewState();
}

class _AddVendorReviewViewState extends State<AddVendorReviewView> {
  int _tripRating = 4;
  int _vendorRating = 4;
  final TextEditingController _tripCommentController = TextEditingController();
  final TextEditingController _vendorCommentController = TextEditingController();

  @override
  void dispose() {
    _tripCommentController.dispose();
    _vendorCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddVendorReviewCubit>(),
      child: BlocConsumer<AddVendorReviewCubit, AddVendorReviewState>(
        listener: (context, state) {
          if (state.status == AddVendorReviewStatus.failure && state.errorMessage != null) {
            appToast(
              context: context,
              type: ToastType.error,
              message: state.errorMessage!,
            );
          } else if (state.status == AddVendorReviewStatus.success) {
            appToast(
              context: context,
              type: ToastType.success,
              message: state.successMessage ?? 'Review submitted successfully!',
            );
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final isLoading = state.status == AddVendorReviewStatus.loading;

          return Scaffold(
            backgroundColor: AppColors.primary,
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Trip Review',
                          style: AppTextStyles.subtitle(color: Colors.white).copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Content Box
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.background(context),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28.r),
                          topRight: Radius.circular(28.r),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28.r),
                          topRight: Radius.circular(28.r),
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(20.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Item Card
                              _ReviewItemHeaderCard(
                                title: widget.title,
                                imageUrl: widget.imageUrl,
                                routeText: widget.routeText,
                                dateRangeText: widget.dateRangeText,
                                ratingValue: widget.ratingValue,
                                ratingCount: widget.ratingCount,
                                badgeText: widget.badgeText,
                                originalPrice: widget.originalPrice,
                                discountedPrice: widget.discountedPrice,
                              ),
                              SizedBox(height: 20.h),

                              // Section 1: Trip Rating
                              Text(
                                'Please write your overall satisfaction level with the trip.',
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.darkText(context),
                                ).copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  _InteractiveStarRating(
                                    rating: _tripRating,
                                    onRatingChanged: (val) {
                                      setState(() => _tripRating = val);
                                    },
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    '$_tripRating/5',
                                    style: AppTextStyles.bodySmall(
                                      color: AppColors.greyText(context),
                                    ).copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                'Write Your Review',
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.darkText(context),
                                ).copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                              ),
                              SizedBox(height: 8.h),
                              _ReviewTextField(controller: _tripCommentController),

                              SizedBox(height: 24.h),

                              // Section 2: Agency (Vendor) Rating
                              Text(
                                'Please Rate the Travel Agency.',
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.darkText(context),
                                ).copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  _InteractiveStarRating(
                                    rating: _vendorRating,
                                    onRatingChanged: (val) {
                                      setState(() => _vendorRating = val);
                                    },
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    '$_vendorRating/5',
                                    style: AppTextStyles.bodySmall(
                                      color: AppColors.greyText(context),
                                    ).copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                'Write Your Review',
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.darkText(context),
                                ).copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                              ),
                              SizedBox(height: 8.h),
                              _ReviewTextField(controller: _vendorCommentController),

                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Actions Bar
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.background(context),
                border: Border(
                  top: BorderSide(color: AppColors.border(context).withValues(alpha: 0.6)),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    // Back Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(999.r),
                      child: Container(
                        width: 52.r,
                        height: 52.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border(context)),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18.sp,
                          color: AppColors.darkText(context),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),

                    // Send Button
                    Expanded(
                      child: SizedBox(
                        height: 52.h,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  final comment = _vendorCommentController.text.isNotEmpty
                                      ? _vendorCommentController.text
                                      : _tripCommentController.text;
                                  context.read<AddVendorReviewCubit>().submitReview(
                                        vendorId: widget.vendorId,
                                        rating: _vendorRating.toDouble(),
                                        comment: comment,
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 22.r,
                                  height: 22.r,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Send',
                                  style: AppTextStyles.bodyMedium(
                                    color: Colors.white,
                                  ).copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ReviewItemHeaderCard extends StatelessWidget {
  const _ReviewItemHeaderCard({
    required this.title,
    required this.imageUrl,
    required this.routeText,
    required this.dateRangeText,
    required this.ratingValue,
    required this.ratingCount,
    required this.badgeText,
    required this.originalPrice,
    required this.discountedPrice,
  });

  final String title;
  final String imageUrl;
  final String routeText;
  final String dateRangeText;
  final String ratingValue;
  final String ratingCount;
  final String badgeText;
  final String originalPrice;
  final String discountedPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: AppCachedNetworkImage(
              imageUrl: imageUrl,
              width: 120.w,
              height: 125.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText(context),
                  ).copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Iconsax.star1, size: 14.sp, color: AppColors.starYellow),
                    SizedBox(width: 4.w),
                    Text(
                      ratingValue,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.darkText(context),
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '($ratingCount)',
                      style: AppTextStyles.bodySmall(
                        color: AppColors.greyText(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                _HeaderInfoLine(icon: Iconsax.location, text: routeText),
                SizedBox(height: 4.h),
                _HeaderInfoLine(icon: Iconsax.calendar_1, text: dateRangeText),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: AppColors.green.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      originalPrice,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.greyText(context),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      discountedPrice,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.darkText(context),
                      ).copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                    ),
                    Text(
                      ' /Person',
                      style: AppTextStyles.caption(color: AppColors.greyText(context)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderInfoLine extends StatelessWidget {
  const _HeaderInfoLine({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColors.greyText(context)),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(color: AppColors.greyText(context)).copyWith(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}

class _InteractiveStarRating extends StatelessWidget {
  const _InteractiveStarRating({
    required this.rating,
    required this.onRatingChanged,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starNumber = index + 1;
        final isSelected = starNumber <= rating;
        return GestureDetector(
          onTap: () => onRatingChanged(starNumber),
          child: Padding(
            padding: EdgeInsets.only(right: 6.w),
            child: Icon(
              isSelected ? Iconsax.star1 : Iconsax.star,
              size: 26.sp,
              color: isSelected ? AppColors.starYellow : AppColors.greyText(context).withValues(alpha: 0.3),
            ),
          ),
        );
      }),
    );
  }
}

class _ReviewTextField extends StatelessWidget {
  const _ReviewTextField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      style: AppTextStyles.bodyMedium(color: AppColors.darkText(context)),
      decoration: InputDecoration(
        hintText: 'Enter your review here',
        hintStyle: AppTextStyles.bodyMedium(color: AppColors.greyText(context).withValues(alpha: 0.6)),
        filled: true,
        fillColor: AppColors.cardBg(context),
        contentPadding: EdgeInsets.all(14.r),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.border(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
