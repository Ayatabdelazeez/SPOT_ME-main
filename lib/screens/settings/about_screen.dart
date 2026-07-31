import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/custom_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "About SpotMe",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: AppColors.dashboardGradient,
                borderRadius: BorderRadius.circular(22),
                boxShadow: AppColors.cardShadow,
              ),
              child: Column(
                children: [
                  const Center(
                    child: AppLogo(
                      logoSize: 90,
                      fontSize: 30,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Version 1.0.0",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "AI-powered sports scouting platform that connects talented players with scouts and clubs.",
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.sports,
                    size: 40,
                    color: AppColors.blue,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Built with Flutter",
                    style: AppTextStyles.heading3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}