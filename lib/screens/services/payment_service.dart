import 'package:flutter/foundation.dart';

import '../subscription/payment_screen.dart';

class PaymentService {
  /// Simulated payment process
  /// Replace later with Stripe / Paymob / PayPal

  Future<bool> processPayment({
    required double amount,
    required PaymentMethod method,
  }) async {
    try {
      debugPrint("========== PAYMENT ==========");
      debugPrint("Amount : $amount");
      debugPrint("Method : ${getPaymentMethodName(method)}");

      // Simulate network delay
      await Future.delayed(
        const Duration(seconds: 2),
      );

    

      debugPrint("Payment Success");

      return true;
    } catch (e) {
      debugPrint("Payment Failed");
      debugPrint(e.toString());

      return false;
    }
  }

  String getPaymentMethodName(
    PaymentMethod method,
  ) {
    switch (method) {
      case PaymentMethod.visa:
        return "Visa";

      case PaymentMethod.masterCard:
        return "MasterCard";
    }
  }

  bool supportsMethod(
    PaymentMethod method,
  ) {
    switch (method) {
      case PaymentMethod.visa:
      case PaymentMethod.masterCard:
        return true;
    }
  }

  Future<void> initializePayment() async {
    debugPrint("Initializing Payment Gateway...");
  }

  Future<void> disposePayment() async {
    debugPrint("Payment Gateway Closed");
  }
}