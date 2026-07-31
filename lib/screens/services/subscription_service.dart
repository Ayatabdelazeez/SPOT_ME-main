import 'package:shared_preferences/shared_preferences.dart';

import '../../models/subscription_plan.dart';

class SubscriptionService {
  static const String _planIdKey = "subscription_plan_id";
  static const String _durationKey = "subscription_duration";
  static const String _startDateKey = "subscription_start";
  static const String _endDateKey = "subscription_end";

  /// Save Subscription
  Future<void> saveSubscription({
    required String planId,
    required SubscriptionDuration duration,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_planIdKey, planId);
    await prefs.setString(_durationKey, duration.name);
    await prefs.setString(
      _startDateKey,
      startDate.toIso8601String(),
    );
    await prefs.setString(
      _endDateKey,
      endDate.toIso8601String(),
    );
  }

  /// Get Subscription ID
  Future<String?> getSubscriptionId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_planIdKey);
  }

  /// Get Subscription Duration
  Future<SubscriptionDuration> getDuration() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_durationKey);

    switch (value) {
      case "yearly":
        return SubscriptionDuration.yearly;

      case "monthly":
      default:
        return SubscriptionDuration.monthly;
    }
  }

  /// Get Start Date
  Future<DateTime?> getStartDate() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_startDateKey);

    if (value == null) return null;

    return DateTime.tryParse(value);
  }

  /// Get End Date
  Future<DateTime?> getEndDate() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_endDateKey);

    if (value == null) return null;

    return DateTime.tryParse(value);
  }

  /// Check Subscription Status
  Future<bool> isSubscriptionActive() async {
    final endDate = await getEndDate();

    if (endDate == null) {
      return false;
    }

    return DateTime.now().isBefore(endDate);
  }

  /// Remaining Days
  Future<int> getRemainingDays() async {
    final endDate = await getEndDate();

    if (endDate == null) {
      return 0;
    }

    final difference = endDate.difference(DateTime.now());

    if (difference.isNegative) {
      return 0;
    }

    return difference.inDays;
  }

  /// Has Subscription
  Future<bool> hasSubscription() async {
    final planId = await getSubscriptionId();

    return planId != null;
  }

  /// Clear Subscription
  Future<void> clearSubscription() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_planIdKey);
    await prefs.remove(_durationKey);
    await prefs.remove(_startDateKey);
    await prefs.remove(_endDateKey);
  }
}