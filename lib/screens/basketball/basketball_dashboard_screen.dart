import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import 'basketball_analysis_screen.dart';

class BasketballDashboardScreen extends StatelessWidget {
  const BasketballDashboardScreen({super.key});

  Widget statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.blue,
              size: 30,
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.blue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Basketball Dashboard",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.sports_basketball,
                    color: AppColors.blue,
                    size: 60,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Overall AI Rating",
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "94",
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Outstanding Performance",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Season Statistics",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                statCard(
                  icon: Icons.emoji_events,
                  title: "Games",
                  value: "18",
                ),
                const SizedBox(width: 15),
                statCard(
                  icon: Icons.sports_score,
                  title: "PPG",
                  value: "24.6",
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                statCard(
                  icon: Icons.handshake_outlined,
                  title: "Assists",
                  value: "8.3",
                ),
                const SizedBox(width: 15),
                statCard(
                  icon: Icons.vertical_align_top,
                  title: "Rebounds",
                  value: "10.1",
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              "Performance Overview",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Shooting Accuracy",
              subtitle: "58%",
              icon: Icons.track_changes,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "3-Point Accuracy",
              subtitle: "42%",
              icon: Icons.filter_3,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Free Throws",
              subtitle: "91%",
              icon: Icons.sports_score,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Defensive Rating",
              subtitle: "88 / 100",
              icon: Icons.shield_outlined,
            ),

            const SizedBox(height: 30),

            Text(
              "AI Insights",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "• Excellent vision when creating scoring opportunities.\n\n"
                "• Strong rebounding performance on both ends of the court.\n\n"
                "• Maintain your shooting rhythm with regular spot-up drills.\n\n"
                "• Improve defensive footwork against faster guards.",
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Open AI Analysis",
              icon: Icons.analytics_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BasketballAnalysisScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}