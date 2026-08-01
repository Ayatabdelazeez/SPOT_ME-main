import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'ai_chat_screen.dart';
import 'ai_feedback_screen.dart';
import 'performance_graphs_screen.dart';

import 'physical_coach_screen.dart';

// import 'ai_cv_generator_screen.dart';
import 'cv_chat_screen.dart';

class AiDashboardScreen extends StatelessWidget {
  const AiDashboardScreen({super.key});

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: iconColor.withOpacity(.15),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: iconColor,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
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
        title: "AI Dashboard",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back",
                style: AppTextStyles.heading1,
              ),

              const SizedBox(height: 8),

              Text(
                "Track your performance with AI insights.",
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.dashboardGradient,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blue.withOpacity(.15),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppColors.blue,
                        size: 34,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "Overall AI Score",
                      style: AppTextStyles.titleMedium,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "89",
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 54,
                        color: AppColors.blue,
                      ),
                    ),

                    Text(
                      "/100",
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(.15),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Excellent Performance",
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Quick Statistics",
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.speed,
                      iconColor: AppColors.blue,
                      value: "92%",
                      title: "Speed",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.favorite,
                      iconColor: AppColors.red,
                      value: "90%",
                      title: "Stamina",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.psychology,
                      iconColor: Colors.orange,
                      value: "95%",
                      title: "Decision",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.sports_soccer,
                      iconColor: Colors.green,
                      value: "87%",
                      title: "Accuracy",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              Text(
                "AI Tools",
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: 18),

              CustomButton(
                text: "AI Feedback",
                icon: Icons.analytics_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AiFeedbackScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              CustomButton(
                text: "Performance Graphs",
                icon: Icons.show_chart,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PerformanceGraphsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              CustomButton(
                text: "AI Coach Chat",
                icon: Icons.smart_toy_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AiChatScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),

CustomButton(
                text: "Physical Coach",
                icon: Icons.sports_gymnastics_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PhysicalCoachScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),

CustomButton(
  text: "AI CV Generator",
  icon: Icons.description_outlined,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CVChatScreen(),
      ),
    );
  },
),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}




