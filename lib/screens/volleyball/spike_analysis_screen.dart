import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

class SpikeAnalysisScreen extends StatelessWidget {
  const SpikeAnalysisScreen({super.key});

  Widget buildItem(
    IconData icon,
    String title,
    String value,
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

          Icon(
            icon,
            color: AppColors.blue,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              title,
              style: AppTextStyles.body,
            ),
          ),

          Text(
            value,
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
        title: "Spike Analysis",
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "Spike Performance",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 30),

            buildItem(
              Icons.flash_on,
              "Spike Speed",
              "102 km/h",
            ),

            buildItem(
              Icons.gps_fixed,
              "Spike Accuracy",
              "94%",
            ),

            buildItem(
              Icons.trending_up,
              "Jump Height",
              "84 cm",
            ),

            buildItem(
              Icons.sports_volleyball,
              "Successful Spikes",
              "95",
            ),

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
                "Excellent spike power and timing.\n"
                "Focus on improving block positioning and serve consistency.",
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