import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotme/screens/auth/register_screen.dart';

import '../../providers/player_providers.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/hidden_sports.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../navigation/scout_navigation_screen.dart';
import 'player_information_screen.dart';

class ChooseSportScreen extends StatefulWidget {
  final bool forScout;

  const ChooseSportScreen({super.key, this.forScout = false});

  @override
  State<ChooseSportScreen> createState() => _ChooseSportScreenState();
}

class _ChooseSportScreenState extends State<ChooseSportScreen> {
  int selectedSport = -1;

  final List<Map<String, dynamic>> sports =
      [
            {
              "name": "Football",
              "icon": Icons.sports_soccer,
              "description": "Show your football skills and performance.",
            },
            {
              "name": "Basketball",
              "icon": Icons.sports_basketball,
              "description": "Display your basketball abilities.",
            },
            {
              "name": "Handball",
              "icon": Icons.sports_handball,
              "description": "Create your professional handball profile.",
            },
            {
              "name": "Volleyball",
              "icon": Icons.sports_volleyball,
              "description": "Build your volleyball player profile.",
            },
          ]
          .where(
            (sport) => !HiddenSportsConfig.isHidden(sport['name'] as String),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Choose Sport"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),

              const SizedBox(height: 30),

              Text("Choose Your Sport", style: AppTextStyles.heading2),

              const SizedBox(height: 8),

              Text(
                widget.forScout
                    ? "Select the sport you want to scout players for."
                    : "Select your primary sport to personalize your profile.",
                style: AppTextStyles.body.copyWith(color: Colors.white70),
              ),

              if (!widget.forScout) ...[
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const LinearProgressIndicator(
                    value: 0.16,
                    minHeight: 8,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation(AppColors.blue),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Step 1 of 6",
                  style: AppTextStyles.body.copyWith(color: Colors.white60),
                ),
              ],

              const SizedBox(height: 28),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: sports.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 18),
                  itemBuilder: (context, index) {
                    final sport = sports[index];
                    final selected = selectedSport == index;

                    return InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () {
                        setState(() {
                          selectedSport = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: selected ? AppColors.blue : Colors.white12,
                            width: selected ? 2 : 1,
                          ),
                          boxShadow: AppColors.cardShadow,
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.blue.withValues(alpha: 0.15)
                                    : Colors.white10,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                sport["icon"],
                                color: selected ? AppColors.blue : Colors.white,
                                size: 34,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sport["name"],
                                    style: AppTextStyles.heading3,
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    sport["description"],
                                    style: AppTextStyles.body.copyWith(
                                      color: Colors.white60,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: selected
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppColors.blue,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.circle_outlined,
                                      color: Colors.white30,
                                      size: 28,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Continue",
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () {
                    if (selectedSport == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select your sport."),
                        ),
                      );
                      return;
                    }

                    final sportName = sports[selectedSport]["name"] as String;

                    if (widget.forScout) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RegisterScreen(),
                        ),
                      );
                      return;
                    }

                    context.read<PlayerProvider>().updateSport(sportName);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PlayerInformationScreen(selectedSport: sportName),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
