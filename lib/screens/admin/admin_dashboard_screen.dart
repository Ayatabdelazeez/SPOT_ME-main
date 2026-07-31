import 'package:flutter/material.dart';

import '../../models/admin_stats.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/admin_stat_card.dart';
import '../../widgets/custom_app_bar.dart';



class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚠️ أرقام تجريبية (Demo) لحد ما يتربط المشروع بباك اند حقيقي.
    const stats = AdminStats.demo;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "Admin Dashboard",
        showBackButton: false,
        actions: [
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ترحيب
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome, Admin 👋", style: AppTextStyles.heading3),
                      const SizedBox(height: 2),
                      Text(
                        "Here's what's happening in SpotMe",
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 26),

              Text("Overview", style: AppTextStyles.sectionTitle),
              const SizedBox(height: 14),

              // كروت الإحصائيات
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.35,
                children: [
                  AdminStatCard(
                    title: "Total Players",
                    value: "${stats.totalPlayers}",
                    icon: Icons.sports_soccer,
                    gradient: AppColors.blueGradient,
                  ),
                  AdminStatCard(
                    title: "Total Scouts",
                    value: "${stats.totalScouts}",
                    icon: Icons.remove_red_eye_outlined,
                    gradient: AppColors.redGradient,
                  ),
                  AdminStatCard(
                    title: "Active Subscriptions",
                    value: "${stats.activeSubscriptions}",
                    icon: Icons.workspace_premium_outlined,
                    gradient: AppColors.blueGradient,
                  ),
                  AdminStatCard(
                    title: "Pending Reports",
                    value: "${stats.pendingReports}",
                    icon: Icons.flag_outlined,
                    gradient: AppColors.redGradient,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Text("Quick Notes", style: AppTextStyles.sectionTitle),
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Text(
                  "These numbers are demo placeholders. Connect a real "
                  "backend (e.g. an API or database) to replace them with "
                  "live data such as real player/scout sign-ups.",
                  style: AppTextStyles.body.copyWith(color: AppColors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}