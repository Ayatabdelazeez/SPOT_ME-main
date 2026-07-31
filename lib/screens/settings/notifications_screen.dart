import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationsScreen extends StatefulWidget {
  final bool isScout;

  const NotificationsScreen({super.key, this.isScout = false});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool push = true;
  bool ai = true;
  bool scout = true;
  bool training = false;
  bool playerMatches = true;
  bool trialAlerts = true;
  bool playerReplies = true;

  Widget _sectionTitle(String title, Color accent) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget notificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Color accent,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: AppColors.white,
            activeTrackColor: accent,
            inactiveThumbColor: AppColors.grey,
            inactiveTrackColor: Colors.white12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isScout = widget.isScout;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Notifications"),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            isScout ? "Scout Alerts" : "Notification Settings",
            style: AppTextStyles.heading3,
          ),
          const SizedBox(height: 6),
          Text(
            isScout
                ? "Choose which scout updates you want to receive."
                : "Control what updates you want to receive from SpotMe.",
            style: AppTextStyles.body.copyWith(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 22),
          _sectionTitle("General", AppColors.blue),
          const SizedBox(height: 10),
          notificationCard(
            icon: Icons.notifications_rounded,
            title: "Push Notifications",
            subtitle: "General updates and alerts",
            value: push,
            accent: AppColors.blue,
            onChanged: (v) => setState(() => push = v),
          ),
          const SizedBox(height: 8),
          _sectionTitle(
            isScout ? "Scouting" : "Activity",
            AppColors.red,
          ),
          const SizedBox(height: 10),
          if (isScout) ...[
            notificationCard(
              icon: Icons.auto_awesome,
              title: "AI Recommendations",
              subtitle: "New players matching your criteria",
              value: ai,
              accent: AppColors.blue,
              onChanged: (v) => setState(() => ai = v),
            ),
            notificationCard(
              icon: Icons.person_search_rounded,
              title: "Player Matches",
              subtitle: "New players from your saved filters",
              value: playerMatches,
              accent: AppColors.red,
              onChanged: (v) => setState(() => playerMatches = v),
            ),
            notificationCard(
              icon: Icons.event_available_rounded,
              title: "Trial Alerts",
              subtitle: "Trial confirmations and reminders",
              value: trialAlerts,
              accent: AppColors.blue,
              onChanged: (v) => setState(() => trialAlerts = v),
            ),
            notificationCard(
              icon: Icons.chat_bubble_outline_rounded,
              title: "Player Replies",
              subtitle: "Messages and invite responses",
              value: playerReplies,
              accent: AppColors.red,
              onChanged: (v) => setState(() => playerReplies = v),
            ),
          ] else ...[
            notificationCard(
              icon: Icons.analytics_rounded,
              title: "AI Analysis",
              subtitle: "Performance analysis results",
              value: ai,
              accent: AppColors.blue,
              onChanged: (v) => setState(() => ai = v),
            ),
            notificationCard(
              icon: Icons.chat_rounded,
              title: "Scout Messages",
              subtitle: "Messages from scouts and clubs",
              value: scout,
              accent: AppColors.red,
              onChanged: (v) => setState(() => scout = v),
            ),
            notificationCard(
              icon: Icons.fitness_center_rounded,
              title: "Training Reminders",
              subtitle: "Daily training notifications",
              value: training,
              accent: AppColors.blue,
              onChanged: (v) => setState(() => training = v),
            ),
          ],
        ],
      ),
    );
  }
}
