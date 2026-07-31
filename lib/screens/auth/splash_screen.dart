import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/app_routes.dart';
import '../../widgets/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/assets/images/logo.png",
                  width: 140,
                  height: 140,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.sports, size: 100, color: AppColors.blue);
                  },
                ),

                const SizedBox(height: 30),

                Text("SpotMe", style: AppTextStyles.heading1),

                const SizedBox(height: 10),

                Text(
                  "Find Your Next Opportunity",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(color: Colors.white70),
                ),

                const SizedBox(height: 45),

                CustomButton(
                  text: "Get Started",
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.onboarding,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
