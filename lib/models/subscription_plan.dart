import 'package:flutter/material.dart';

enum UserType {
  player,
  scout,
}

enum SportType {
  football,
  handball,
  //volleyball,
  basketball,
}

enum SubscriptionDuration {
  monthly,
  yearly,
}

class SubscriptionPlan {
  final String id;

  final UserType userType;

  /// null if the plan belongs to Scout
  final SportType? sport;

  final String title;

  final String subtitle;

  final double monthlyPrice;

  final double yearlyPrice;

  final IconData icon;

  final Color borderColor;

  final List<String> features;

  final bool isPopular;

  const SubscriptionPlan({
    required this.id,
    required this.userType,
    this.sport,
    required this.title,
    required this.subtitle,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.icon,
    required this.borderColor,
    required this.features,
    this.isPopular = false,
  });

  double getPrice(SubscriptionDuration duration) {
    return duration == SubscriptionDuration.monthly
        ? monthlyPrice
        : yearlyPrice;
  }

  String getDurationText(SubscriptionDuration duration) {
    return duration == SubscriptionDuration.monthly
        ? "Month"
        : "Year";
  }

  bool get isPlayer =>
      userType == UserType.player;

  bool get isScout =>
      userType == UserType.scout;
}