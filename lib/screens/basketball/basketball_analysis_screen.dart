import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import 'basketball_match_screen.dart';

class BasketballAnalysisScreen extends StatelessWidget {
  const BasketballAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Basketball Analysis",
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
                    size: 55,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "AI Basketball Score",
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "94 / 100",
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Elite Playmaker",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Performance Metrics",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Field Goal Accuracy",
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
              title: "Free Throw Accuracy",
              subtitle: "91%",
              icon: Icons.sports_score,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Assists",
              subtitle: "11",
              icon: Icons.handshake_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Rebounds",
              subtitle: "13",
              icon: Icons.vertical_align_top,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Steals",
              subtitle: "4",
              icon: Icons.flash_on,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Blocks",
              subtitle: "3",
              icon: Icons.block,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Turnovers",
              subtitle: "2",
              icon: Icons.warning_amber_rounded,
            ),

            const SizedBox(height: 30),

            Text(
              "AI Recommendation",
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
                "Excellent court vision and passing decisions.\n\n"
                "Your three-point shooting consistency is impressive, while defensive positioning has improved significantly.\n\n"
                "Focus on reducing turnovers during fast breaks and continue developing your off-ball movement.",
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "View Match Analysis",
              icon: Icons.analytics_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BasketballMatchScreen(),
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