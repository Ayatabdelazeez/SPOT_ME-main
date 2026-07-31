import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotme/screens/scout/home.dart';

import '../../models/subscription_plan.dart';
import '../../providers/subscription_provider.dart';
import '../services/payment_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';

import '../player/choose_sport_screen.dart';
import '../player/player_home_screen.dart';
import '../navigation/scout_navigation_screen.dart';
// import '../scout/scout_dashboard_screen.dart';

// import '../scout/home.dart';

enum PaymentMethod { visa, masterCard }

class PaymentScreen extends StatefulWidget {
  // const PaymentScreen({super.key});

  final String selectedSport;

  const PaymentScreen({super.key, required this.selectedSport});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.visa;

  bool _isProcessing = false;

  final cardNumberController = TextEditingController();

  final cardNameController = TextEditingController();

  final expiryController = TextEditingController();

  final cvvController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardNameController.dispose();
    expiryController.dispose();
    cvvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);

    final plan = provider.currentPlan;

    if (plan == null) {
      return const Scaffold(
        body: Center(child: Text("No subscription selected")),
      );
    }

    final bool isMonthly = provider.duration == SubscriptionDuration.monthly;

    final double amount = isMonthly ? plan.monthlyPrice : plan.yearlyPrice;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.card,

        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          "Payment",

          style: AppTextStyles.heading1.copyWith(color: Colors.white),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: AppColors.card,

                  borderRadius: BorderRadius.circular(24),
                ),

                child: Column(
                  children: [
                    Icon(plan.icon, color: plan.borderColor, size: 60),

                    const SizedBox(height: 15),

                    Text(
                      plan.title,

                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,

                        fontSize: 28,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "$amount EGP",

                      style: AppTextStyles.heading1.copyWith(
                        color: AppColors.red,

                        fontSize: 38,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      isMonthly
                          ? "Monthly Subscription"
                          : "Yearly Subscription",

                      style: AppTextStyles.body.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Payment Method",

                  style: AppTextStyles.heading2.copyWith(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),
              _paymentTile(PaymentMethod.visa, Icons.credit_card, "Visa"),

              _paymentTile(
                PaymentMethod.masterCard,
                Icons.credit_card,
                "MasterCard",
              ),

              if (_selectedMethod == PaymentMethod.visa ||
                  _selectedMethod == PaymentMethod.masterCard)
                _buildCardForm(),

              const SizedBox(height: 30),

              CustomButton(
                text: _isProcessing
                    ? "Processing..."
                    : "Pay ${amount.toStringAsFixed(0)} EGP",

                onPressed: _isProcessing
                    ? null
                    : () async {
                        if ((_selectedMethod == PaymentMethod.visa ||
                                _selectedMethod == PaymentMethod.masterCard) &&
                            (cardNumberController.text.isEmpty ||
                                cardNameController.text.isEmpty ||
                                expiryController.text.isEmpty ||
                                cvvController.text.isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please complete card information"),
                            ),
                          );

                          return;
                        }

                        setState(() {
                          _isProcessing = true;
                        });

                        final paymentSuccess = await PaymentService()
                            .processPayment(
                              amount: amount,

                              method: _selectedMethod,
                            );

                        if (paymentSuccess) {
                          await provider.activateSubscription();
                        }

                        setState(() {
                          _isProcessing = false;
                        });

                        if (!mounted) return;

                        if (paymentSuccess) {
                          showDialog(
                            context: context,

                            builder: (_) => AlertDialog(
                              backgroundColor: AppColors.card,

                              title: const Text(
                                "Payment Successful",

                                style: TextStyle(color: Colors.white),
                              ),

                              content: Text(
                                "${plan.title} has been activated successfully.",

                                style: const TextStyle(color: Colors.white70),
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // يقفل الـ Dialog

                                    final isScout =
                                        provider.currentPlan?.userType ==
                                        UserType.scout;

                                    Navigator.pop(context);

                                    if (isScout) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ScoutNavigationScreen(
                                            selectedSport: widget.selectedSport,
                                          ),
                                        ),
                                        (route) => false,
                                      );
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PlayerHomeScreen(
                                            selectedSport: widget.selectedSport,
                                          ),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  },

                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Payment Failed")),
                          );
                        }
                      },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentTile(PaymentMethod method, IconData icon, String title) {
    final selected = _selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        margin: const EdgeInsets.only(bottom: 15),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: AppColors.card,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: selected ? AppColors.red : Colors.transparent,

            width: 2,
          ),
        ),

        child: Row(
          children: [
            Icon(icon, color: selected ? AppColors.red : Colors.white70),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,

                style: AppTextStyles.body.copyWith(
                  color: Colors.white,

                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Radio<PaymentMethod>(
              value: method,

              groupValue: _selectedMethod,

              activeColor: AppColors.red,

              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SizedBox(height: 20),

        Text(
          "Card Information",

          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),

        const SizedBox(height: 15),

        _textField(
          controller: cardNumberController,

          hint: "Card Number",

          icon: Icons.credit_card,
        ),

        const SizedBox(height: 15),

        _textField(
          controller: cardNameController,

          hint: "Card Holder Name",

          icon: Icons.person,
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: _textField(
                controller: expiryController,

                hint: "MM/YY",

                icon: Icons.date_range,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: _textField(
                controller: cvvController,

                hint: "CVV",

                icon: Icons.lock,

                obscure: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _textField({
    required TextEditingController controller,

    required String hint,

    required IconData icon,

    bool obscure = false,
  }) {
    return TextField(
      controller: controller,

      obscureText: obscure,

      keyboardType: hint == "Card Number" || hint == "CVV"
          ? TextInputType.number
          : TextInputType.text,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(color: Colors.white54),

        prefixIcon: Icon(icon, color: AppColors.red),

        filled: true,

        fillColor: AppColors.card,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
