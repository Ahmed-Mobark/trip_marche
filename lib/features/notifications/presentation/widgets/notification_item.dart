import 'dart:math' as math;

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
              _NotificationLogo(),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          height: 1.12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
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
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      timestamp,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFC7CBD6),
                        height: 1,
                      ),
                    ),
                  ),
                  if (unreadCount != null && unreadCount! > 0) ...[
                    const SizedBox(height: 30),
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount! > 9 ? '9+' : unreadCount.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ],
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.white,
              width: 26,
            ),
          ),
          Positioned(
            top: 12,
            right: -4,
            child: Transform.rotate(
              angle: math.pi / 16,
              child: ClipPath(
                clipper: _FlagClipper(),
                child: Container(
                  width: 30,
                  height: 14,
                  color: const Color(0xFFFFD84D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
