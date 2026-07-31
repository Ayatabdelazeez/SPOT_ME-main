import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final IconData icon;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: AppColors.card,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      style: AppTextStyles.body.copyWith(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: AppTextStyles.body.copyWith(
          color: Colors.white,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.blue,
        ),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.blue,
            width: 1.5,
          ),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}