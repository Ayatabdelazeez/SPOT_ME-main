import 'package:flutter/material.dart';

import '../widgets/ad_illustrations.dart';

class AdModel {
  final String brand;
  final String title;
  final String subtitle;
  final String ctaText;
  final IconData icon;
  final Color color;

  /// Original, code-drawn product illustration (no photos/logos — see
  /// ad_illustrations.dart) shown instead of a plain icon.
  final AdVisual visual;

  /// Sports this ad is relevant to. Empty list = shown to everyone.
  final List<String> sportTags;

  const AdModel({
    required this.brand,
    required this.title,
    required this.subtitle,
    required this.ctaText,
    required this.icon,
    required this.color,
    required this.visual,
    this.sportTags = const [],
  });
}