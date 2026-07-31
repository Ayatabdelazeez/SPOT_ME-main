import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_validators.dart';
import 'custom_text_field.dart';

class BasicInformationForm extends StatefulWidget {
  const BasicInformationForm({super.key});

  @override
  State<BasicInformationForm> createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {

  final TextEditingController _genderController = TextEditingController();
 
  @override
  void dispose() {
    _genderController.dispose();
    super.dispose();
  }
 
  void _pickGender() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.male, color: AppColors.blue),
                title: Text("Male", style: AppTextStyles.body.copyWith(color: Colors.white)),
                onTap: () {
                  setState(() => _genderController.text = "Male");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.female, color: AppColors.blue),
                title: Text("Female", style: AppTextStyles.body.copyWith(color: Colors.white)),
                onTap: () {
                  setState(() => _genderController.text = "Female");
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: "Full Name",
          prefixIcon: Icons.person_outline,
          validator: AppValidators.name,
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Email Address",
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: AppValidators.email,
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Password",
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: AppValidators.password,
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Confirm Password",
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (value) =>
              AppValidators.required(value, fieldName: 'Confirm password'),
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Phone Number",
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: AppValidators.phone,
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Date of Birth",
          prefixIcon: Icons.calendar_today_outlined,
          validator: (value) =>
              AppValidators.required(value, fieldName: 'Date of birth'),
        ),

        const SizedBox(height: 18),

       CustomTextField(
          hintText: "Gender",
          prefixIcon: Icons.wc_outlined,
          controller: _genderController,
          readOnly: true,
          onTap: _pickGender,
          validator: (value) =>
              AppValidators.required(value, fieldName: 'Gender'),
        ),
 

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: "Height (cm)",
                prefixIcon: Icons.height,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    AppValidators.required(value, fieldName: 'Height'),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Weight (kg)",
                prefixIcon: Icons.monitor_weight_outlined,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    AppValidators.required(value, fieldName: 'Weight'),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Nationality",
          prefixIcon: Icons.flag_outlined,
          validator: (value) =>
              AppValidators.required(value, fieldName: 'Nationality'),
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "City",
          prefixIcon: Icons.location_city_outlined,
          validator: (value) =>
              AppValidators.required(value, fieldName: 'City'),
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Current Club / Academy",
          prefixIcon: Icons.groups_outlined,
          validator: (value) => AppValidators.required(
            value,
            fieldName: 'Current club / academy',
          ),
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Years of Experience",
          prefixIcon: Icons.workspace_premium_outlined,
          keyboardType: TextInputType.number,
          validator: (value) =>
              AppValidators.required(value, fieldName: 'Years of experience'),
        ),
      ],
    );
  }
}
