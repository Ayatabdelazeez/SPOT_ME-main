import 'package:flutter/material.dart';
import 'package:spotme/screens/subscription/scout_subscription_screen.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_app_bar.dart';
import 'login_screen.dart';
import '../../utils/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Register"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),

              const SizedBox(height: 35),

              Text("Create scout Account", style: AppTextStyles.heading3),

              const SizedBox(height: 6),

              Text(
                "Create your scout account to start discovering talents.",
                style: AppTextStyles.body.copyWith(color: Colors.white70),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Column(
                  children: [
                    const CustomTextField(
                      hintText: "Full Name",
                      prefixIcon: Icons.person_outline,
                    ),

                    const SizedBox(height: 18),

                    const CustomTextField(
                      hintText: "Email Address",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),
 
                    const CustomTextField(
                      hintText: "Nationality",
                      prefixIcon: Icons.flag_outlined,
                    ),

                     const SizedBox(height: 18),
 
                    const CustomTextField(
                      hintText: "Current Club",
                      prefixIcon: Icons.groups_outlined,
                    ),

                    const SizedBox(height: 18),

                    const CustomTextField(
                      hintText: "Password",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 18),

                    const CustomTextField(
                      hintText: "Confirm Password",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 30),

                    CustomButton(
                      text: "Create Account",
                      icon: Icons.person_add_alt_1,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.scoutSubscription,
                        );
                      },
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppTextStyles.body.copyWith(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
