import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import 'handball_analysis_screen.dart';

class HandballDashboardScreen extends StatelessWidget {
  const HandballDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Handball Dashboard",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Handball Performance",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Monitor your handball statistics.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 25),

            const CustomCard(
              title: "Goals Scored",
              subtitle: "46 Goals",
              icon: Icons.sports_handball,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Assist Passes",
              subtitle: "21 Assists",
              icon: Icons.handshake_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Throw Accuracy",
              subtitle: "88%",
              icon: Icons.gps_fixed,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Jump Reach",
              subtitle: "72 cm",
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
                        const HandballAnalysisScreen(),
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