import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  final double logoSize;
  final double fontSize;

  const AppLogo({
    super.key,
    this.logoSize = 55,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "lib/assets/images/logo.png",
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
        ),

        const SizedBox(width: 10),

        RichText(
          text: TextSpan(
            style: AppTextStyles.heading1.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(
                text: "Spot",
                style: TextStyle(
                  color: AppColors.blue,
                ),
              ),
              TextSpan(
                text: "Me",
                style: TextStyle(
                  color: AppColors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}