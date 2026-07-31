import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/empty_state.dart';

enum ScoutNotificationType { player, recommendation, trial, message, system }

enum ScoutNotificationFilter { all, unread, players, trials }

class ScoutNotificationItem {
  final String id;
  final String title;
  final String body;
  final String time;
  final ScoutNotificationType type;
  bool isRead;

  ScoutNotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

class ScoutNotificationsScreen extends StatefulWidget {
  const ScoutNotificationsScreen({super.key});

  @override
  State<ScoutNotificationsScreen> createState() =>
      _ScoutNotificationsScreenState();
}

class _ScoutNotificationsScreenState extends State<ScoutNotificationsScreen> {
  ScoutNotificationFilter selectedFilter = ScoutNotificationFilter.all;

  late List<ScoutNotificationItem> notifications;

  @override
  void initState() {
    super.initState();
    notifications = [
      ScoutNotificationItem(
        id: "1",
        title: "New AI recommendation",
        body:
            "Lamine Yamal matches your midfielder criteria with 94% fit score.",
        time: "2m ago",
        type: ScoutNotificationType.recommendation,
      ),
      ScoutNotificationItem(
        id: "2",
        title: "Trial confirmed",
        body: "Omar Hassan accepted your trial invite for Thursday 6:00 PM.",
        time: "25m ago",
        type: ScoutNotificationType.trial,
      ),
      ScoutNotificationItem(
        id: "3",
        title: "Player responded",
        body: "Sara Ali replied to your shortlist invitation.",
        time: "1h ago",
        type: ScoutNotificationType.message,
      ),
      ScoutNotificationItem(
        id: "4",
        title: "New player match",
        body: "3 football players in Cairo match your search filters.",
        time: "3h ago",
        type: ScoutNotificationType.player,
      ),
      ScoutNotificationItem(
        id: "5",
        title: "Trial reminder",
        body: "You have 2 trials booked this week. Review your schedule.",
        time: "Yesterday",
        type: ScoutNotificationType.trial,
        isRead: true,
      ),
      ScoutNotificationItem(
        id: "6",
        title: "Shortlist update",
        body: "Youssef Nabil was added to Al Ahly shortlist by your team.",
        time: "Yesterday",
        type: ScoutNotificationType.system,
        isRead: true,
      ),
      ScoutNotificationItem(
        id: "7",
        title: "Profile viewed",
        body: "A club manager viewed 5 players from your recommendations.",
        time: "2d ago",
        type: ScoutNotificationType.system,
        isRead: true,
      ),
    ];
  }

  int get unreadCount =>
      notifications.where((n) => !n.isRead).length;

  List<ScoutNotificationItem> get filteredNotifications {
    switch (selectedFilter) {
      case ScoutNotificationFilter.unread:
        return notifications.where((n) => !n.isRead).toList();
      case ScoutNotificationFilter.players:
        return notifications
            .where(
              (n) =>
                  n.type == ScoutNotificationType.player ||
                  n.type == ScoutNotificationType.recommendation,
            )
            .toList();
      case ScoutNotificationFilter.trials:
        return notifications
            .where((n) => n.type == ScoutNotificationType.trial)
            .toList();
      case ScoutNotificationFilter.all:
        return notifications;
    }
  }

  void markAllAsRead() {
    setState(() {
      for (final item in notifications) {
        item.isRead = true;
      }
    });
  }

  void markAsRead(ScoutNotificationItem item) {
    if (item.isRead) return;
    setState(() => item.isRead = true);
  }

  void clearAll() {
    setState(() => notifications.clear());
  }

  IconData _iconFor(ScoutNotificationType type) {
    switch (type) {
      case ScoutNotificationType.player:
        return Icons.person_search_rounded;
      case ScoutNotificationType.recommendation:
        return Icons.auto_awesome;
      case ScoutNotificationType.trial:
        return Icons.event_available_rounded;
      case ScoutNotificationType.message:
        return Icons.chat_bubble_outline_rounded;
      case ScoutNotificationType.system:
        return Icons.info_outline_rounded;
    }
  }

  Color _colorFor(ScoutNotificationType type) {
    switch (type) {
      case ScoutNotificationType.player:
        return AppColors.blue;
      case ScoutNotificationType.recommendation:
        return AppColors.blue;
      case ScoutNotificationType.trial:
        return AppColors.red;
      case ScoutNotificationType.message:
        return AppColors.red;
      case ScoutNotificationType.system:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredNotifications;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "Notifications",
        actions: [
          if (notifications.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.white),
              color: AppColors.card,
              onSelected: (value) {
                if (value == "read") markAllAsRead();
                if (value == "clear") clearAll();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: "read",
                  child: Text(
                    "Mark all as read",
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
                const PopupMenuItem(
                  value: "clear",
                  child: Text(
                    "Clear all",
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unreadCount == 0
                            ? "You're all caught up"
                            : "$unreadCount unread",
                        style: AppTextStyles.heading3.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Player matches, trials, and scout updates",
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (unreadCount > 0)
                  TextButton(
                    onPressed: markAllAsRead,
                    child: const Text(
                      "Mark all",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [
                _filterChip("All", ScoutNotificationFilter.all),
                _filterChip("Unread", ScoutNotificationFilter.unread),
                _filterChip("Players", ScoutNotificationFilter.players),
                _filterChip("Trials", ScoutNotificationFilter.trials),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: items.isEmpty
                ? EmptyState(
                    icon: Icons.notifications_none_rounded,
                    title: selectedFilter == ScoutNotificationFilter.unread
                        ? "No unread alerts"
                        : "No notifications",
                    subtitle: selectedFilter == ScoutNotificationFilter.unread
                        ? "New player matches and trial updates will show here."
                        : "You're all clear. Check back later for scout updates.",
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return _notificationCard(items[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, ScoutNotificationFilter filter) {
    final selected = selectedFilter == filter;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = filter),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.blue.withValues(alpha: 0.18) : AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.blue : Colors.white10,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.blue : AppColors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _notificationCard(ScoutNotificationItem item) {
    final accent = _colorFor(item.type);

    return GestureDetector(
      onTap: () => markAsRead(item),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: item.isRead
              ? AppColors.card
              : AppColors.blue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border(
            left: BorderSide(color: accent, width: 3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(_iconFor(item.type), color: accent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight:
                                item.isRead ? FontWeight.w500 : FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        item.time,
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.body,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (!item.isRead) ...[
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
