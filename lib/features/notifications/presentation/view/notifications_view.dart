import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/notification/notification_api.dart';
import '../../../../core/notification/notification_navigation_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../data/app_notification.dart';
import '../widgets/notification_item.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  late Future<List<AppNotification>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<AppNotification>> _load() async {
    final items = await sl<NotificationApi>().fetchNotifications();
    return items.map(AppNotification.fromJson).toList();
  }

  Future<void> _refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AppNotification>>(
      future: _future,
      builder: (context, snapshot) {
        final notifications = snapshot.data ?? const <AppNotification>[];
        return Scaffold(
          backgroundColor: const Color(0xFFFBF9FC),
          appBar: const _NotificationsAppBar(),
          body: _buildBody(context, snapshot, notifications),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncSnapshot<List<AppNotification>> snapshot,
    List<AppNotification> notifications,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CustomLoading(top: 40, bottom: 40));
    }
    if (snapshot.hasError) {
      return Center(
        child: Text(
          'Unable to load notifications',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    if (notifications.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height:
                  MediaQuery.sizeOf(context).height -
                  kToolbarHeight -
                  MediaQuery.paddingOf(context).top -
                  MediaQuery.paddingOf(context).bottom,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Iconsax.notification_bing,
                        color: AppColors.primary.withValues(alpha: 0.85),
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'No notifications yet',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    final sections = _sectionsFor(notifications);
    final unreadCount = notifications.where((item) => !item.isRead).length;
    final firstItem = notifications.first;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(0, 18, 0, 28),
        children: [
          for (final section in sections) ...[
            _SectionHeader(title: section.title),
            const SizedBox(height: 16),
            for (final item in section.items)
              NotificationItem(
                title: item.title,
                description: item.body,
                timestamp: item.createdAtHuman,
                isRead: item.isRead,
                highlighted: identical(item, firstItem),
                unreadCount: identical(item, firstItem) && unreadCount > 0
                    ? unreadCount
                    : null,
                onTap: () async {
                  await sl<NotificationApi>().markAsRead(item.id);
                  await sl<NotificationNavigationService>().open(item.payload);
                  await _refresh();
                },
              ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  List<_NotificationSection> _sectionsFor(List<AppNotification> notifications) {
    final grouped = <String, List<AppNotification>>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final notification in notifications) {
      final createdAt = notification.createdAt?.toLocal();
      final title = createdAt == null
          ? 'Earlier'
          : _sectionTitleFor(createdAt, today, yesterday);
      grouped.putIfAbsent(title, () => <AppNotification>[]).add(notification);
    }

    return grouped.entries
        .map((entry) => _NotificationSection(entry.key, entry.value))
        .toList();
  }

  String _sectionTitleFor(
    DateTime createdAt,
    DateTime today,
    DateTime yesterday,
  ) {
    final date = DateTime(createdAt.year, createdAt.month, createdAt.day);
    if (date == today) return 'Today';
    if (date == yesterday) return 'Yesterday';
    return '${_monthName(date.month)} ${date.day}';
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

class _NotificationsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _NotificationsAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      height: preferredSize.height + topPadding,
      color: const Color(0xFFFBF9FC),
      padding: EdgeInsets.only(top: topPadding),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: const EdgeInsets.only(left: 10, right: 18),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF7B8391),
                size: 25,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Text(
            'Notification',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: const Color(0xFF16161A),
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 20),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color(0xFF566184),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(child: Divider(color: Color(0xFFE8E8F0), height: 1)),
        ],
      ),
    );
  }
}

class _NotificationSection {
  const _NotificationSection(this.title, this.items);

  final String title;
  final List<AppNotification> items;
}
