import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/enums/media_type.dart';
import 'package:trip_marche/core/services/media_service/media_services.dart';
import 'package:trip_marche/core/services/media_service/media_service_exceptions.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/toast/app_toast.dart';

Future<File?> showImageSourceBottomSheet(BuildContext context) async {
  final result = await showModalBottomSheet<File>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardBg(context),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) => const _ImageSourceBottomSheet(),
  );
  return result;
}

class _ImageSourceBottomSheet extends StatelessWidget {
  const _ImageSourceBottomSheet();

  Future<void> _pick(BuildContext context, AppImageSource source) async {
    try {
      final mediaService = sl<MediaService>();
      final picked = await mediaService.uploadImage(context, source);
      if (!context.mounted) return;
      if (picked != null) {
        Navigator.pop(context, picked);
      }
    } on PermissionException catch (_) {
      if (!context.mounted) return;
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.profilePhotoPermissionRequired,
      );
    } on CameraUnavailableException catch (_) {
      if (!context.mounted) return;
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.profilePhotoCameraUnavailable,
      );
    } on InvalidFileException catch (_) {
      if (!context.mounted) return;
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.profilePhotoInvalidFile,
      );
    } on FileTooLargeException catch (_) {
      if (!context.mounted) return;
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.profilePhotoTooLarge,
      );
    } catch (_) {
      if (!context.mounted) return;
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.profilePhotoPickFailed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleColor = AppColors.darkText(context);
    final subtitleColor = AppColors.greyText(context).withValues(alpha: 0.8);
    final dividerColor = AppColors.border(context);

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(20.w, 10.h, 20.w, 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
            decoration: BoxDecoration(
              color: dividerColor,
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            context.tr.profileChangePhotoTitle,
            style: AppTextStyles.heading3(color: titleColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            context.tr.profileChangePhotoSubtitle,
            style: AppTextStyles.bodyMedium(color: subtitleColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          _SourceTile(
            icon: Icons.camera_alt_rounded,
            label: context.tr.profilePhotoFromCamera,
            onTap: () => _pick(context, AppImageSource.camera),
          ),
          Divider(height: 1, thickness: 1, color: dividerColor),
          _SourceTile(
            icon: Icons.photo_library_rounded,
            label: context.tr.profilePhotoFromGallery,
            onTap: () => _pick(context, AppImageSource.gallery),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                backgroundColor: AppColors.inputBg(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                context.tr.commonCancel,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.greyText(context),
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = AppColors.primary;
    final textColor = AppColors.darkText(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: iconColor),
            SizedBox(width: 16.w),
            Text(label, style: AppTextStyles.bodyMedium(color: textColor)),
          ],
        ),
      ),
    );
  }
}
