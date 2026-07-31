import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subscription_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

import '../screens/subscription/player_subscription_screen.dart';
import '../screens/subscription/scout_subscription_screen.dart';

class PremiumLock extends StatelessWidget {
  final Widget child;

  final String featureName;

  /// لو الميزة خاصة بالـ Scout خليها true
  final bool isScout;

  const PremiumLock({
    super.key,
    required this.child,
    required this.featureName,
    this.isScout = false,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionProvider>();

    if (provider.isPremium) {
      return child;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.red.withOpacity(.4),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    gradient: AppColors.redGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Premium Feature",
                  style: AppTextStyles.heading1.copyWith(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "$featureName is available only for Premium members.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => isScout
                              ? const ScoutSubscriptionScreen()
                              : const PlayerSubscriptionScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Upgrade to Premium",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Maybe Later",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}