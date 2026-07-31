import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/subscription_plans.dart';
import '../../models/subscription_plan.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';

import 'payment_screen.dart';

class PlayerSubscriptionScreen extends StatefulWidget {
  const PlayerSubscriptionScreen({super.key});

  @override
  State<PlayerSubscriptionScreen> createState() =>
      _PlayerSubscriptionScreenState();
}

class _PlayerSubscriptionScreenState
    extends State<PlayerSubscriptionScreen> {
  SubscriptionPlan selectedPlan = SubscriptionPlans.football;

  SubscriptionDuration selectedDuration =
      SubscriptionDuration.monthly;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = Provider.of<SubscriptionProvider>(
      context,
      listen: false,
    );

    if (provider.currentPlan != null &&
        provider.currentPlan!.userType == UserType.player) {
      selectedPlan = provider.currentPlan!;
      selectedDuration = provider.duration;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar: _buildBottomButton(provider),

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  30,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [

                    _buildHero(provider),

                    const SizedBox(height: 25),

                    Text(
                      "Subscription Duration",
                      style:
                          AppTextStyles.heading2.copyWith(
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [

                        Expanded(
                          child: _durationCard(
                            "Monthly",
                            SubscriptionDuration.monthly,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: _durationCard(
                            "Yearly",
                            SubscriptionDuration.yearly,
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 30),

                    Text(
                      "Choose Your Sport",
                      style:
                          AppTextStyles.heading2.copyWith(
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ...SubscriptionPlans.playerPlans.map(
                      (plan) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 18),
                        child: _planCard(plan),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      child: Row(
        children: [

          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          const Spacer(),

          Text(
            "Player Premium",
            style:
                AppTextStyles.heading1.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),

          const Spacer(),

          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              gradient: AppColors.redGradient,
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.workspace_premium,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
    Widget _buildHero(
    SubscriptionProvider provider,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.dashboardGradient,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Unlock Player Premium",
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
              fontSize: 28,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Choose your sport and unlock AI analysis, unlimited uploads and better scout visibility.",
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
              height: 1.5,
            ),
          ),

          if (provider.isPremium &&
              provider.currentPlan?.userType == UserType.player) ...[

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  const Icon(
                    Icons.verified,
                    color: Colors.green,
                    size: 40,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    provider.currentPlan!.title,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.red,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    provider.isMonthly
                        ? "Monthly Subscription"
                        : "Yearly Subscription",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),

                  if (provider.endDate != null) ...[
                    const SizedBox(height: 10),

                    Text(
                      "Expires: "
                      "${provider.endDate!.day}/"
                      "${provider.endDate!.month}/"
                      "${provider.endDate!.year}",
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _durationCard(
    String title,
    SubscriptionDuration duration,
  ) {
    final selected = selectedDuration == duration;

    return InkWell(
      onTap: () {
        setState(() {
          selectedDuration = duration;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColors.red
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [

            Text(
              title,
              style: AppTextStyles.heading2.copyWith(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              duration == SubscriptionDuration.monthly
                  ? "Pay Every Month"
                  : "Save More",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _planCard(SubscriptionPlan plan) {
    final bool selected =
        selectedPlan.id == plan.id;

    final double price =
        selectedDuration ==
                SubscriptionDuration.monthly
            ? plan.monthlyPrice
            : plan.yearlyPrice;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPlan = plan;
        });
      },
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected
                ? plan.borderColor
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      plan.borderColor.withOpacity(.15),
                  child: Icon(
                    plan.icon,
                    color: plan.borderColor,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        plan.title,
                        style: AppTextStyles.heading2
                            .copyWith(
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        plan.subtitle,
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: [

                    Text(
                      "$price EGP",
                      style: AppTextStyles.heading2
                          .copyWith(
                        color: plan.borderColor,
                      ),
                    ),

                    Text(
                      selectedDuration ==
                              SubscriptionDuration
                                  .monthly
                          ? "/ Month"
                          : "/ Year",
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Divider(
              color: Colors.white.withOpacity(.08),
            ),

            const SizedBox(height: 15),

            ...plan.features.map(
              (feature) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: plan.borderColor,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        feature,
                        style:
                            AppTextStyles.body.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    Widget _buildBottomButton(
    SubscriptionProvider provider,
  ) {
    final double price =
        selectedDuration == SubscriptionDuration.monthly
            ? selectedPlan.monthlyPrice
            : selectedPlan.yearlyPrice;

    final String durationText =
        selectedDuration == SubscriptionDuration.monthly
            ? "Month"
            : "Year";

    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        20,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: CustomButton(
          text: provider.isPremium &&
                  provider.currentPlan?.userType == UserType.player
              ? "Manage Subscription"
              : "Continue • $price EGP / $durationText",
          onPressed: () async {
            if (provider.isPremium &&
                provider.currentPlan?.userType == UserType.player) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "You already have an active Player Premium subscription.",
                  ),
                ),
              );
              return;
            }

            await provider.selectPlan(
              selectedPlan,
              selectedDuration,
            );

            if (!mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentScreen(
                        selectedSport: selectedPlan.sport!.name,

                ),
              ),
            );
          },
        ),
      ),
    );
  }
}