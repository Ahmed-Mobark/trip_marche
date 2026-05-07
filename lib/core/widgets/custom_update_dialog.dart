import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../extensions/localization.dart';

class CustomUpdateDialog extends StatelessWidget {
  const CustomUpdateDialog({super.key, required this.onUpdateNow, this.onSkip});

  final VoidCallback onUpdateNow;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    final bool isMandatory = onSkip == null;

    return PopScope(
      canPop: isMandatory ? false : true,
      child: Dialog(
        backgroundColor: AppColors.cardBg(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.system_update,
                size: 70,
                color: AppColors.primary,
              ),
              const SizedBox(height: 20),
              Text(
                context.tr.updateAvailableTitle,
                style: AppTextStyles.heading2(color: AppColors.bodyText(context)),
              ),
              const SizedBox(height: 20),
              Text(
                isMandatory
                    ? context.tr.updateMandatoryMessage
                    : context.tr.updateOptionalMessage,
                textAlign: TextAlign.center,
                style: AppTextStyles.body(color: AppColors.bodyText(context)),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  if (!isMandatory)
                    Expanded(
                      flex: 4,
                      child: OutlinedButton(
                        onPressed: onSkip,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 50),
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          context.tr.skip,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  if (!isMandatory) const SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onUpdateNow,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 50),
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        context.tr.updateNow,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.onPrimary(context),
                        ),
                      ),
                    ),
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
