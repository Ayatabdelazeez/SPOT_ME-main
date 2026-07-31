import 'package:flutter/material.dart';
import 'package:spotme/screens/auth/register_screen.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_app_bar.dart';
// import '../scout/scout_dashboard_screen.dart';
import '../player/choose_sport_screen.dart';

import '../subscription/scout_subscription_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/subscription_provider.dart';


class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  int selectedRole = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Who Are You?"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              const AppLogo(logoSize: 85),

              const SizedBox(height: 40),

              Text("Who Are You?", style: AppTextStyles.heading1),

              const SizedBox(height: 10),

              Text(
                "Choose how you want to use SpotMe.",
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: Colors.white70),
              ),

              const SizedBox(height: 45),

              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRole = 1;
                  });
                },
                child: _roleCard(
                  icon: Icons.sports_soccer,
                  title: "Player",
                  subtitle: "Create your profile and get discovered.",
                  selected: selectedRole == 1,
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRole = 2;
                  });
                },
                child: _roleCard(
                  icon: Icons.manage_search,
                  title: "Scout",
                  subtitle: "Search and evaluate talented players.",
                  selected: selectedRole == 2,
                ),
              ),

              const Spacer(),

              CustomButton(
                text: "Continue",
                onPressed: () async {
                  if (selectedRole == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select your role.")),
                    );
                    return;
                  }

                  if (selectedRole == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChooseSportScreen(),
                      ),
                    );
                  } else if (selectedRole == 2) {
  final subscription =
      context.read<SubscriptionProvider>();

  await subscription.initialize();

  if (subscription.isScoutSubscription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChooseSportScreen(
          forScout: true,
        ),
      ),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
             const RegisterScreen(),
      ),
    );
  }
}
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: selected ? AppColors.blue.withOpacity(.18) : AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? AppColors.blue : Colors.white10,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.blue.withOpacity(.15),
            child: Icon(icon, color: AppColors.blue, size: 30),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading2),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: AppTextStyles.body.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),

          if (selected) const Icon(Icons.check_circle, color: AppColors.blue),
        ],
      ),
    );
  }
}
