import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_card.dart';

class PlayerStatisticsScreen extends StatelessWidget {
  const PlayerStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Player Statistics",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Performance Overview",
            style: AppTextStyles.heading1,
          ),

          const SizedBox(height: 8),

          Text(
            "Review your overall performance and match statistics.",
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          const CustomCard(
            title: "Overall Rating",
            subtitle: "89 / 100",
            icon: Icons.star,
          ),

          const SizedBox(height: 18),

          const CustomCard(
            title: "Matches Played",
            subtitle: "25",
            icon: Icons.sports,
          ),

          const SizedBox(height: 18),

          const CustomCard(
            title: "Goals / Points",
            subtitle: "18",
            icon: Icons.emoji_events,
          ),

          const SizedBox(height: 18),

          const CustomCard(
            title: "Assists",
            subtitle: "12",
            icon: Icons.assistant,
          ),

          const SizedBox(height: 18),

          const CustomCard(
            title: "Performance",
            subtitle: "Excellent",
            icon: Icons.trending_up,
          ),
        ],
      ),
    );
  }
}