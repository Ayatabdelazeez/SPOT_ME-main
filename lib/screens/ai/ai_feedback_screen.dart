import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

class AiFeedbackScreen extends StatelessWidget {
  const AiFeedbackScreen({super.key});

  Widget _buildScoreCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: AppColors.cardShadow,
        
      ),
      

      child: Column(
        children: [
          Text("AI Performance Score", style: AppTextStyles.heading3),
          

          const SizedBox(height: 20),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: CircularProgressIndicator(
                  value: 0.89,
                  strokeWidth: 14,
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                ),
              ),

              Column(
                children: [
                  Text(
                    "89",
                    style: AppTextStyles.heading1.copyWith(fontSize: 42),
                  ),

                  const Text("/100", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text("Excellent Performance", style: AppTextStyles.titleLarge),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard({
    required IconData icon,
    required Color color,
    required String title,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(.15),

                child: Icon(icon, color: color),
              ),

              const SizedBox(width: 12),

              Text(title, style: AppTextStyles.heading4),
            ],
          ),

          const SizedBox(height: 15),

          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(Icons.check_circle, size: 18, color: color),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.body.copyWith(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation() {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: AppColors.dashboardGradient,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: AppColors.blue.withOpacity(.3)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.blue),

              const SizedBox(width: 10),

              Text("AI Recommendation", style: AppTextStyles.heading4),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            "Focus on finishing drills and "
            "decision making exercises to increase "
            "your attacking impact.",
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
              height: 1.6,
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

      appBar: const CustomAppBar(title: "AI Feedback"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            _buildScoreCard(),

            const SizedBox(height: 25),

            Text("Player Analysis", style: AppTextStyles.heading2),

            const SizedBox(height: 15),

            _buildFeedbackCard(
              icon: Icons.trending_up,

              color: Colors.green,

              title: "Strengths",

              items: [
                "Excellent speed and acceleration",

                "Strong decision making",

                "Good stamina during matches",
              ],
            ),

            const SizedBox(height: 18),

            _buildFeedbackCard(
              icon: Icons.warning_amber,

              color: AppColors.red,

              title: "Needs Improvement",

              items: [
                "Improve finishing accuracy",

                "Work on weak foot control",

                "Increase passing consistency",
              ],
            ),

            const SizedBox(height: 20),

            _buildRecommendation(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
