import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

class GoalZoneScreen extends StatelessWidget {
  const GoalZoneScreen({super.key});

  Widget buildZone(
    String zone,
    String percentage,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [

          CircleAvatar(
            backgroundColor: color,
            child: Text(
              zone,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              "Success Rate",
              style: AppTextStyles.body,
            ),
          ),

          Text(
            percentage,
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(
        title: "Goal Zone Analysis",
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "Goal Success By Zone",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 30),

            buildZone("A", "91%", Colors.green),

            buildZone("B", "87%", Colors.orange),

            buildZone("C", "82%", Colors.red),

            buildZone("D", "95%", Colors.blue),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "AI Insight:\n\n"
                "Your highest scoring area is Zone D.\n"
                "Work on improving accuracy in Zone C during fast-break situations.",
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}