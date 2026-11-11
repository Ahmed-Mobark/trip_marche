import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/config/app_colors.dart';

AppBar chatAppBar(
  BuildContext context, {
  required String title,
  String? subtitle,
  List<Widget>? actions,
}) => AppBar(
  toolbarHeight: 78,
  elevation: 0,
  backgroundColor: AppColors.primary,
  foregroundColor: Colors.white,
  leading: IconButton(
    icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
    onPressed: () => Navigator.maybePop(context),
  ),
  flexibleSpace: const SizedBox.expand(
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
        ),
      ),
    ),
  ),
  titleSpacing: 0,
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      if (subtitle != null) ...[
        const SizedBox(height: 4),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    ],
  ),
  actions: actions,
);

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });
  final String title;
  final String? subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Iconsax.messages_2,
              color: AppColors.primary,
              size: 34,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).hintColor,
                height: 1.5,
              ),
            ),
          ],
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    ),
  );
}
