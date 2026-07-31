import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomDatePicker extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const CustomDatePicker({
    super.key,
    required this.hint,
    required this.controller,
  });

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      initialDate: DateTime(2005),
    );

    if (date != null) {
      controller.text =
          "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: controller,
      style: AppTextStyles.body,
      onTap: () => _pickDate(context),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.body.copyWith(
          color: Colors.white54,
        ),
        prefixIcon: const Icon(
          Icons.calendar_month_outlined,
          color: AppColors.blue,
        ),
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white70,
        ),
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