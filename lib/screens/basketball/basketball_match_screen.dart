import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_card.dart';

class BasketballMatchScreen extends StatelessWidget {
  const BasketballMatchScreen({super.key});

  Widget quarterCard(
    String quarter,
    String points,
    String assists,
    String rebounds,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quarter,
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stat("Points", points),
              _stat("Assists", assists),
              _stat("Rebounds", rebounds),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.blue,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppTextStyles.body.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Basketball Match",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  const Icon(
                    Icons.emoji_events,
                    color: AppColors.blue,
                    size: 55,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Final Score",
                    style: AppTextStyles.heading2,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "96 - 88",
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.blue,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Victory",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Quarter Performance",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 18),

            quarterCard(
              "Quarter 1",
              "18",
              "3",
              "4",
            ),

            quarterCard(
              "Quarter 2",
              "21",
              "4",
              "5",
            ),

            quarterCard(
              "Quarter 3",
              "27",
              "2",
              "3",
            ),

            quarterCard(
              "Quarter 4",
              "30",
              "5",
              "6",
            ),

            const SizedBox(height: 30),

            Text(
              "Match Statistics",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 18),

            const CustomCard(
              title: "Field Goals",
              subtitle: "14 / 24",
              icon: Icons.sports_basketball,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "3-Point Shots",
              subtitle: "6 / 11",
              icon: Icons.filter_3,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Free Throws",
              subtitle: "10 / 11",
              icon: Icons.sports_score,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Steals",
              subtitle: "4",
              icon: Icons.flash_on,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Blocks",
              subtitle: "3",
              icon: Icons.block,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Turnovers",
              subtitle: "2",
              icon: Icons.warning_amber_rounded,
            ),

            const SizedBox(height: 30),

            Text(
              "AI Match Summary",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "You controlled the pace of the game with excellent passing and smart shot selection.\n\n"
                "Your strongest quarter was the fourth, where you created multiple scoring opportunities and maintained defensive pressure.\n\n"
                "The AI recommends continuing transition offense drills and improving defensive rotations for even better performances.",
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}