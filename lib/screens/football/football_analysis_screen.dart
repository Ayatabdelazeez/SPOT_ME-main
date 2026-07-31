import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import 'football_match_screen.dart';

class FootballAnalysisScreen extends StatelessWidget {
  const FootballAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Football Analysis",
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
                    Icons.auto_awesome,
                    color: AppColors.blue,
                    size: 50,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "AI Football Score",
                    style: AppTextStyles.heading2,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "91 / 100",
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Performance Metrics",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Sprint Speed",
              subtitle: "34 km/h",
              icon: Icons.speed,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Passing Accuracy",
              subtitle: "91%",
              icon: Icons.compare_arrows,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Shooting Accuracy",
              subtitle: "86%",
              icon: Icons.sports_soccer,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Ball Possession",
              subtitle: "67%",
              icon: Icons.sports,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Distance Covered",
              subtitle: "10.8 km",
              icon: Icons.directions_run,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Successful Passes",
              subtitle: "48 / 55",
              icon: Icons.check_circle_outline,
            ),

            const SizedBox(height: 25),

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
                "Excellent passing vision and positioning.\n\n"
                "Improve finishing under pressure and increase weak-foot accuracy."
                "\n\nContinue sprint drills to maintain your top speed.",
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  height: 1.5,
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
                    builder: (_) => const FootballMatchScreen(),
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