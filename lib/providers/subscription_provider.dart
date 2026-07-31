import 'package:flutter/material.dart';

import '../data/subscription_plans.dart';
import '../models/subscription_plan.dart';
import '../screens/services/subscription_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  final SubscriptionService _subscriptionService =
      SubscriptionService();

  SubscriptionPlan? _currentPlan;

  SubscriptionDuration _duration =
      SubscriptionDuration.monthly;

  DateTime? _startDate;
  DateTime? _endDate;

  bool _isLoading = false;

  SubscriptionPlan? get currentPlan => _currentPlan;

  SubscriptionDuration get duration => _duration;

  DateTime? get startDate => _startDate;

  DateTime? get endDate => _endDate;

  bool get isLoading => _isLoading;

  bool get isPremium => _currentPlan != null;

  bool get isMonthly =>
      _duration == SubscriptionDuration.monthly;

  bool get isYearly =>
      _duration == SubscriptionDuration.yearly;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    final planId =
        await _subscriptionService.getSubscriptionId();

    _currentPlan = _getPlanById(planId);

    _duration =
        await _subscriptionService.getDuration();

    _startDate =
        await _subscriptionService.getStartDate();

    _endDate =
        await _subscriptionService.getEndDate();

    await checkSubscriptionStatus();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> selectPlan(
    SubscriptionPlan plan,
    SubscriptionDuration duration,
  ) async {
    _currentPlan = plan;
    _duration = duration;

    notifyListeners();
  }

  Future<void> activateSubscription() async {
    if (_currentPlan == null) return;

    _startDate = DateTime.now();

    if (_duration == SubscriptionDuration.monthly) {
      _endDate = _startDate!.add(
        const Duration(days: 30),
      );
    } else {
      _endDate = _startDate!.add(
        const Duration(days: 365),
      );
    }

    await _subscriptionService.saveSubscription(
      planId: _currentPlan!.id,
      duration: _duration,
      startDate: _startDate!,
      endDate: _endDate!,
    );

    notifyListeners();
  }

  Future<void> checkSubscriptionStatus() async {
    if (_currentPlan == null) return;

    final isActive =
        await _subscriptionService.isSubscriptionActive();

    if (!isActive) {
      await cancelSubscription();
    }
  }

  Future<void> cancelSubscription() async {
    _currentPlan = null;

    _startDate = null;
    _endDate = null;

    await _subscriptionService.clearSubscription();

    notifyListeners();
  }

  Future<void> resetSubscription() async {
    await cancelSubscription();
  }

  double get currentPrice {
    if (_currentPlan == null) return 0;

    return _duration == SubscriptionDuration.monthly
        ? _currentPlan!.monthlyPrice
        : _currentPlan!.yearlyPrice;
  }

  bool get isPlayerSubscription =>
      _currentPlan?.userType == UserType.player;

  bool get isScoutSubscription =>
      _currentPlan?.userType == UserType.scout;

  SubscriptionPlan? _getPlanById(String? id) {
    if (id == null) return null;

    final allPlans = [
      ...SubscriptionPlans.playerPlans,
      ...SubscriptionPlans.scoutPlans,
    ];

    try {
      return allPlans.firstWhere(
        (plan) => plan.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}