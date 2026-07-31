import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading1 = GoogleFonts.sora(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static TextStyle heading2 = GoogleFonts.sora(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle heading3 = GoogleFonts.sora(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle heading4 = GoogleFonts.sora(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle titleLarge = GoogleFonts.sora(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle titleMedium = GoogleFonts.sora(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle titleSmall = GoogleFonts.sora(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle bodyLarge = GoogleFonts.sora(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.sora(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.sora(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.7),
    height: 1.4,
  );

  static TextStyle body = bodyMedium;

  static TextStyle button = GoogleFonts.sora(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static TextStyle cardTitle = GoogleFonts.sora(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle cardSubtitle = GoogleFonts.sora(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.7),
  );

  static TextStyle statTitle = GoogleFonts.sora(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle statValue = GoogleFonts.sora(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.blue,
  );

  static TextStyle statPercentage = GoogleFonts.sora(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.red,
  );

  static TextStyle appBarTitle = GoogleFonts.sora(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle sectionTitle = GoogleFonts.sora(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle sectionSubtitle = GoogleFonts.sora(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.7),
  );
}