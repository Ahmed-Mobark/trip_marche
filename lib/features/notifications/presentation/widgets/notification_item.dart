import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;
  final bool isRead;
  final bool highlighted;
  final int? unreadCount;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isRead = true,
    this.highlighted = false,
    this.unreadCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Material(
      color: highlighted ? AppColors.cardBg(context) : Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      elevation: highlighted ? 8 : 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: highlighted ? 20 : 0,
            vertical: highlighted ? 18 : 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _NotificationLogo(),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 1.12,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            timestamp,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFC7CBD6),
                                  height: 1,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF566184),
                          height: 1.55,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (highlighted) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: content,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: content,
    );
  }
}

class _NotificationLogo extends StatelessWidget {
  const _NotificationLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 58,
      child: Container(
        width: 58,
        height: 58,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/icons/logo.png',
          width: 36,
          height: 36,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
