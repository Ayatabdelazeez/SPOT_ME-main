import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import 'volleyball_analysis_screen.dart';

class VolleyballDashboardScreen extends StatelessWidget {
  const VolleyballDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Volleyball Dashboard",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Volleyball Performance",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Track your volleyball statistics.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 25),

            const CustomCard(
              title: "Successful Spikes",
              subtitle: "95",
              icon: Icons.sports_volleyball,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Blocks",
              subtitle: "38",
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
              title: "Jump Height",
              subtitle: "84 cm",
              icon: Icons.trending_up,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "View Analysis",
              icon: Icons.analytics_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const VolleyballAnalysisScreen(),
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