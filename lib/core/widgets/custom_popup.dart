import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/widgets/app_modal_bottom_sheet.dart';

class CustomPopup {
  static void appShowModalBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) {
    showAppModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      clipBehavior: Clip.hardEdge,
      backgroundColor: Theme.of(context).cardColor,
      builder: builder,
    );
  }

  static void appShowDialog({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) {
    showDialog(context: context, builder: builder);
  }
}
