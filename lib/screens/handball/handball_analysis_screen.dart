import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import 'goal_zone_screen.dart';

class HandballAnalysisScreen extends StatelessWidget {
  const HandballAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Handball Analysis",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AI Match Analysis",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Review your latest handball performance and discover areas for improvement.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 25),

            const CustomCard(
              title: "AI Handball Score",
              subtitle: "90 / 100",
              icon: Icons.auto_awesome,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Throw Speed",
              subtitle: "108 km/h",
              icon: Icons.speed,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Throw Power",
              subtitle: "93%",
              icon: Icons.fitness_center,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Shot Accuracy",
              subtitle: "89%",
              icon: Icons.gps_fixed,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Defensive Rating",
              subtitle: "84%",
              icon: Icons.shield_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Reaction Time",
              subtitle: "0.34 sec",
              icon: Icons.flash_on,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Goal Zone Analysis",
              icon: Icons.sports_score,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GoalZoneScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}