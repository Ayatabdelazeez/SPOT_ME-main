import 'package:flutter/material.dart';

class AppValidators {
  AppValidators._();

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? name(String? value) {
    final requiredCheck = required(value, fieldName: 'Full name');
    if (requiredCheck != null) return requiredCheck;
    if (value!.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredCheck = required(value, fieldName: 'Email');
    if (requiredCheck != null) return requiredCheck;
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Password rule: at least 8 characters, containing letters AND numbers.
  static String? password(String? value) {
    final requiredCheck = required(value, fieldName: 'Password');
    if (requiredCheck != null) return requiredCheck;
    if (value!.length < 8) {
      return 'Password must be at least 8 characters';
    }
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    if (!hasLetter || !hasNumber) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  /// Password rule for Login: numbers only.
  static String? numericPassword(String? value) {
    final requiredCheck = required(value, fieldName: 'Password');
    if (requiredCheck != null) return requiredCheck;
    final numbersOnly = RegExp(r'^[0-9]+$');
    if (!numbersOnly.hasMatch(value!)) {
      return 'Password must contain numbers only';
    }
    return null;
  }

  /// Phone number rule: numbers only (digits, optionally with a leading +).
  static String? phone(String? value) {
    final requiredCheck = required(value, fieldName: 'Phone number');
    if (requiredCheck != null) return requiredCheck;
    final digitsOnly = RegExp(r'^\+?[0-9]+$');
    if (!digitsOnly.hasMatch(value!.trim())) {
      return 'Phone number must contain numbers only';
    }
    if (value.trim().replaceAll('+', '').length < 8) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? Function(String?) confirmPassword(
    TextEditingController passwordController,
  ) {
    return (String? value) {
      final requiredCheck = required(value, fieldName: 'Confirm password');
      if (requiredCheck != null) return requiredCheck;
      if (value != passwordController.text) {
        return 'Passwords do not match';
      }
      return null;
    };
  }
}
