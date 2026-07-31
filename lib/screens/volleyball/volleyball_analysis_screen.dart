import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import 'spike_analysis_screen.dart';

class VolleyballAnalysisScreen extends StatelessWidget {
  const VolleyballAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(
        title: "Volleyball Analysis",
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AI Performance Analysis",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Analyze your volleyball skills and discover strengths, weaknesses, and AI-powered recommendations.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 25),

            const CustomCard(
              title: "AI Volleyball Score",
              subtitle: "93 / 100",
              icon: Icons.auto_awesome,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Spike Power",
              subtitle: "94%",
              icon: Icons.sports_volleyball,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Block Success",
              subtitle: "90%",
              icon: Icons.block,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Serve Accuracy",
              subtitle: "92%",
              icon: Icons.gps_fixed,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Reception",
              subtitle: "89%",
              icon: Icons.sports_handball,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Vertical Jump",
              subtitle: "84 cm",
              icon: Icons.trending_up,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Spike Analysis",
              icon: Icons.show_chart,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SpikeAnalysisScreen(),
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