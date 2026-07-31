import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import 'login_screen.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "icon": Icons.sports_soccer,
      "title": "Discover Your Talent",
      "description":
          "Build your sports profile and showcase your skills to professional scouts.",
    },
    {
      "icon": Icons.analytics_outlined,
      "title": "AI Performance Analysis",
      "description":
          "Receive smart insights to improve your performance and reach your full potential.",
    },
    {
      "icon": Icons.emoji_events_outlined,
      "title": "Get Scouted",
      "description":
          "Upload your highlights and connect with clubs and scouts around the world.",
    },
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  void skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  Widget buildDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 28 : 8,
      decoration: BoxDecoration(
        color: active ? AppColors.blue : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: skip,
                  child: Text(
                    "Skip",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = onboardingData[index];

                  return OnboardingPage(
                    icon: item["icon"],
                    title: item["title"],
                    description: item["description"],
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index == currentIndex),
              ),
            ),

            const SizedBox(height: 35),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                text: currentIndex == onboardingData.length - 1
                    ? "Get Started"
                    : "Next",
                onPressed: nextPage,
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}