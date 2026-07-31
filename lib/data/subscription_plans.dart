import 'package:flutter/material.dart';

import '../models/subscription_plan.dart';
import '../utils/app_colors.dart';

class SubscriptionPlans {
  SubscriptionPlans._();

  // ===========================
  // Player Plans
  // ===========================

  static const SubscriptionPlan football = SubscriptionPlan(
    id: "player_football",
    userType: UserType.player,
    sport: SportType.football,
    title: "Football Premium",
    subtitle: "For Football Players",
    monthlyPrice: 350,
    yearlyPrice: 3500,
    icon: Icons.sports_soccer,
    borderColor: AppColors.red,
    isPopular: true,
    features: [
      "Unlimited Video Uploads",
      "Advanced AI Match Analysis",
      "Priority Scout Visibility",
      "Detailed Performance Reports",
      "AI Coach",
    ],
  );

  static const SubscriptionPlan handball = SubscriptionPlan(
    id: "player_handball",
    userType: UserType.player,
    sport: SportType.handball,
    title: "Handball Premium",
    subtitle: "For Handball Players",
    monthlyPrice: 250,
    yearlyPrice: 2500,
    icon: Icons.sports_handball,
    borderColor: AppColors.blue,
    features: [
      "Unlimited Video Uploads",
      "Advanced AI Match Analysis",
      "Performance Reports",
      "AI Coach",
    ],
  );

  /*static const SubscriptionPlan volleyball = SubscriptionPlan(
    id: "player_volleyball",
    userType: UserType.player,
    sport: SportType.volleyball,
    title: "Volleyball Premium",
    subtitle: "For Volleyball Players",
    monthlyPrice: 300,
    yearlyPrice: 3000,
    icon: Icons.sports_volleyball,
    borderColor: AppColors.red,
    features: [
      "Unlimited Video Uploads",
      "Advanced AI Analysis",
      "Priority Scout Visibility",
      "Performance Reports",
    ],
  );

  static const SubscriptionPlan basketball = SubscriptionPlan(
    id: "player_basketball",
    userType: UserType.player,
    sport: SportType.basketball,
    title: "Basketball Premium",
    subtitle: "For Basketball Players",
    monthlyPrice: 300,
    yearlyPrice: 3000,
    icon: Icons.sports_basketball,
    borderColor: AppColors.blue,
    features: [
      "Unlimited Video Uploads",
      "Advanced AI Match Analysis",
      "Priority Scout Visibility",
      "Performance Reports",
      "AI Coach",
    ],
  );
*/
  // ===========================
  // Scout Plans
  // ===========================

  static const SubscriptionPlan scoutFootball = SubscriptionPlan(
    id: "scout_football",
    userType: UserType.scout,
    sport: SportType.football,
    title: "Scout Premium - Football",
    subtitle: "For Football Scouts",
    monthlyPrice: 2000,
    yearlyPrice: 20000,
    icon: Icons.sports_soccer,
    borderColor: AppColors.red,
    isPopular: true,
    features: [
      "Unlimited Football Player Search",
      "Advanced Filters",
      "Contact Players",
      "AI Recommendations",
      "Unlimited Reports",
    ],
  );

  static const SubscriptionPlan scoutHandball = SubscriptionPlan(
    id: "scout_handball",
    userType: UserType.scout,
    sport: SportType.handball,
    title: "Scout Premium - Handball",
    subtitle: "For Handball Scouts",
    monthlyPrice: 1000,
    yearlyPrice: 10000,
    icon: Icons.sports_handball,
    borderColor: AppColors.blue,
    features: [
      "Unlimited Handball Player Search",
      "Advanced Filters",
      "Contact Players",
      "AI Recommendations",
      "Unlimited Reports",
    ],
  );

  // ===========================
  // Lists
  // ===========================

  static const List<SubscriptionPlan> playerPlans = [
    football,
    handball,
    /* volleyball, */
    /* basketball, */
  ];

  static const List<SubscriptionPlan> scoutPlans = [
    scoutFootball,
    scoutHandball,
  ];

  static List<SubscriptionPlan> get allPlans => [
        ...playerPlans,
        ...scoutPlans,
      ];

  static SubscriptionPlan? getPlanById(String id) {
    try {
      return allPlans.firstWhere(
        (plan) => plan.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}