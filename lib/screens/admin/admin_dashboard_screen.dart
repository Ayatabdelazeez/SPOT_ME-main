import 'package:flutter/material.dart';
import 'package:spotme/models/player_model.dart';
//import '../../models/admin_stats.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/admin_stat_card.dart';
import '../../widgets/custom_app_bar.dart';
import 'admin_reports_screen.dart';
import 'admin_users_list_screen.dart';


class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //const stats = AdminStats.demo;

    final List<PlayerModel> allPlayers = [
      PlayerModel(name: "Ahmed Mohamed", email: "", phone: "", sport: "Football", position: "Forward", age: 20, height: 182, weight: 76, score: 91, image: "", club: "Future FC", experienceYears: 7),
      PlayerModel(name: "Khaled Ali", email: "", phone: "", sport: "Football", position: "Midfielder", age: 22, height: 175, weight: 70, score: 85, image: "", club: "Zamalek", experienceYears: 4, violationsCount: 1),
      PlayerModel(name: "Omar Hassan", email: "", phone: "", sport: "Basketball", position: "Guard", age: 19, height: 190, weight: 82, score: 88, image: "", club: "Ahly FC", experienceYears: 3),
    ];

    final List<Map<String, String>> allScouts = [
      {"name": "Captain Mahmoud", "club": "Ahly FC"},
      {" name": "Coach Hazem", "club": "Zamalek Youth"},
      {"name": "Scout Reda", "club": "Pyramids FC"},
    ];

    final pendingReportsCount = allPlayers.where((p) => p.violationsCount > 0 || p.isBlocked).length;

    final totalPlayersCount = allPlayers.length;
    final totalScoutsCount = allScouts.length;
    final activeSubscriptionsCount = 12;

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
                      Text("Welcome, Admin", style: AppTextStyles.heading3),
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

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.35,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminUsersListScreen(roleTitle: "Registered Players"),
                        ),
                      );
                    },
                    child: AdminStatCard(
                      title: "Total Players",
                      value: "$totalPlayersCount",
                      icon: Icons.sports_soccer,
                      gradient: AppColors.blueGradient,
                    ),
                  ),
                  
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminUsersListScreen(roleTitle: "Registered Scouts"),
                        ),
                      );
                    },
                    child: AdminStatCard(
                      title: "Total Scouts",
                      value: "$totalScoutsCount",
                      icon: Icons.remove_red_eye_outlined,
                      gradient: AppColors.redGradient,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Subscriptions: 12 Premium Clubs / 33 Scouts active")),
                      );
                    },
                    child: AdminStatCard(
                      title: "Active Subscriptions",
                      value: "$activeSubscriptionsCount",
                      icon: Icons.workspace_premium_outlined,
                      gradient: AppColors.blueGradient,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminReportsScreen(),
                        ),
                      );
                    },
                    child: AdminStatCard(
                      title: "Pending Reports",
                      value: "$pendingReportsCount",
                      icon: Icons.flag_outlined,
                      gradient: AppColors.redGradient,
                    ),
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
