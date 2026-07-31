import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomProgressStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const CustomProgressStepper({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        totalSteps,
        (index) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            decoration: BoxDecoration(
              color: index < currentStep
                  ? AppColors.blue
                  : Colors.white12,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}