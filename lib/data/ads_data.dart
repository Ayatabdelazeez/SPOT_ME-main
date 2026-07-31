import 'package:flutter/material.dart';

import '../models/ad_model.dart';
import '../utils/app_colors.dart';
import '../widgets/ad_illustrations.dart';

/// Static "house ads" content — energy drinks & sportswear, aimed at
/// players. Every visual is an original code-drawn illustration (see
/// ad_illustrations.dart), so there's no real product photo or logo
/// involved. Swap this list out later for a real ad-network SDK
/// without touching the screens that show these.
class AdsData {
  static const List<AdModel> all = [
    AdModel(
      brand: "SURGE Energy",
      title: "Fuel your next match",
      subtitle: "Zero sugar. Pure focus. Try SURGE before kickoff.",
      ctaText: "Learn More",
      icon: Icons.bolt,
      color: AppColors.red,
      visual: AdVisual.energyCan,
      sportTags: ["Football", "Basketball", "Handball", "Volleyball"],
    ),
    AdModel(
      brand: "ProKick Boots",
      title: "New Football Cleats Just Dropped",
      subtitle: "Lighter, faster, built for grip on any pitch.",
      ctaText: "Shop Now",
      icon: Icons.sports_soccer,
      color: AppColors.blue,
      visual: AdVisual.cleats,
      sportTags: ["Football"],
    ),
    AdModel(
      brand: "AirBounce",
      title: "Own the Court",
      subtitle: "Basketball shoes engineered for vertical explosiveness.",
      ctaText: "Shop Now",
      icon: Icons.sports_basketball,
      color: AppColors.blue,
      visual: AdVisual.sneaker,
      sportTags: ["Basketball"],
    ),
    AdModel(
      brand: "GripFit Gear",
      title: "Performance Handball Jerseys",
      subtitle: "Breathable fabric that moves the way you do.",
      ctaText: "Shop Now",
      icon: Icons.sports_handball,
      color: AppColors.red,
      visual: AdVisual.jersey,
      sportTags: ["Handball"],
    ),
    AdModel(
      brand: "SpikeZone",
      title: "Volleyball Season Sale",
      subtitle: "Knee pads, shoes & jerseys — up to 30% off.",
      ctaText: "Shop Now",
      icon: Icons.sports_volleyball,
      color: AppColors.blue,
      visual: AdVisual.jersey,
      sportTags: ["Volleyball"],
    ),
    AdModel(
      brand: "HydroPeak",
      title: "Recover Faster",
      subtitle: "Electrolyte drink mix trusted by pro athletes.",
      ctaText: "Learn More",
      icon: Icons.water_drop,
      color: AppColors.red,
      visual: AdVisual.waterBottle,
      sportTags: [],
    ),
    AdModel(
      brand: "FitLine Apparel",
      title: "Train In Comfort",
      subtitle: "New activewear collection, made for every sport.",
      ctaText: "Shop Now",
      icon: Icons.checkroom,
      color: AppColors.blue,
      visual: AdVisual.jersey,
      sportTags: [],
    ),
  ];

  /// Returns ads relevant to [sport] first, falling back to general ads
  /// if none match. Never returns an empty list.
  static List<AdModel> forSport(String sport) {
    final matching =
        all.where((ad) => ad.sportTags.contains(sport)).toList();
    final general = all.where((ad) => ad.sportTags.isEmpty).toList();

    final pool = [...matching, ...general];
    return pool.isEmpty ? all : pool;
  }
}