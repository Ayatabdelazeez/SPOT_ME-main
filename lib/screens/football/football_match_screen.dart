import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_card.dart';

class FootballMatchScreen extends StatelessWidget {
  const FootballMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Match Statistics",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Text(
            "Last Match",
            style: AppTextStyles.heading1,
          ),

          const SizedBox(height: 20),

          const CustomCard(
            title: "Opponent",
            subtitle: "Al Ahly SC",
            icon: Icons.shield_outlined,
          ),

          const SizedBox(height: 15),

          const CustomCard(
            title: "Final Score",
            subtitle: "3 - 1",
            icon: Icons.scoreboard_outlined,
          ),

          const SizedBox(height: 15),

          const CustomCard(
            title: "Goals",
            subtitle: "2",
            icon: Icons.sports_soccer,
          ),

          const SizedBox(height: 15),

          const CustomCard(
            title: "Assists",
            subtitle: "1",
            icon: Icons.assistant,
          ),

          const SizedBox(height: 15),

          const CustomCard(
            title: "Shots on Target",
            subtitle: "5",
            icon: Icons.gps_fixed,
          ),

          const SizedBox(height: 15),

          const CustomCard(
            title: "Successful Passes",
            subtitle: "48",
            icon: Icons.compare_arrows,
          ),

          const SizedBox(height: 15),

          const CustomCard(
            title: "Distance Covered",
            subtitle: "10.8 km",
            icon: Icons.directions_run,
          ),

          const SizedBox(height: 15),

          const CustomCard(
            title: "Player Rating",
            subtitle: "9.2 / 10",
            icon: Icons.star,
          ),
        ],
      ),
    );
  }
}