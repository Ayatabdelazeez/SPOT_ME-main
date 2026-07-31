import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';

import '../../widgets/basic_information_form.dart';
import '../../widgets/football_information_form.dart';
import '../../widgets/basketball_information_form.dart';
import '../../widgets/handball_information_form.dart';
import '../../widgets/volleyball_information_form.dart';

import 'medical_history_screen.dart';

class PlayerInformationScreen extends StatefulWidget {
  final String selectedSport;

  const PlayerInformationScreen({super.key, required this.selectedSport});

  @override
  State<PlayerInformationScreen> createState() =>
      _PlayerInformationScreenState();
}

class _PlayerInformationScreenState extends State<PlayerInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget _buildSportForm() {
    switch (widget.selectedSport) {
      case "Football":
        return const FootballInformationForm();

      case "Basketball":
        return const BasketballInformationForm();

      case "Handball":
        return const HandballInformationForm();

      case "Volleyball":
        return const VolleyballInformationForm();

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

              const SizedBox(height: 16),

              const AppLogo(),

              const SizedBox(height: 30),

              Text("Player Information", style: AppTextStyles.heading2),

              const SizedBox(height: 8),

              Text(
                "Complete your personal information before continuing.",
                style: AppTextStyles.body.copyWith(color: Colors.white70),
              ),

              const SizedBox(height: 20),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: const LinearProgressIndicator(
                  value: .33,
                  minHeight: 8,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation(AppColors.blue),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Step 2 of 6",
                style: AppTextStyles.body.copyWith(color: Colors.white60),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: AppColors.card,

                  borderRadius: BorderRadius.circular(24),

                  boxShadow: AppColors.cardShadow,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_outline, color: AppColors.blue),

                        const SizedBox(width: 10),

                        Text(
                          "Basic Information",
                          style: AppTextStyles.heading3,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const BasicInformationForm(),

                    const SizedBox(height: 35),

                    Divider(color: Colors.white.withOpacity(.08), thickness: 1),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        const Icon(Icons.sports, color: AppColors.red),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            "${widget.selectedSport} Information",
                            style: AppTextStyles.heading3,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildSportForm(),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,

                      child: CustomButton(
                        text: "Continue",
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MedicalHistoryScreen(
                                  selectedSport: widget.selectedSport,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

 
