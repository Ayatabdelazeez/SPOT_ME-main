import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_button.dart';
import 'football_match_screen.dart';

class FootballDashboardScreen extends StatelessWidget {
  const FootballDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Football Dashboard",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Football Performance",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Track your football statistics.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 25),

            const CustomCard(
              title: "Goals",
              subtitle: "18 Goals",
              icon: Icons.sports_soccer,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Assists",
              subtitle: "11 Assists",
              icon: Icons.handshake_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Pass Accuracy",
              subtitle: "91%",
              icon: Icons.track_changes,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Minutes Played",
              subtitle: "2,180 Minutes",
              icon: Icons.timer_outlined,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "View Match Statistics",
              icon: Icons.bar_chart,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const FootballMatchScreen(),
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