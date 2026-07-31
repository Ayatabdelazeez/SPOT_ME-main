import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class HandballInformationForm extends StatelessWidget {
  const HandballInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hintText: "Preferred Position",
          prefixIcon: Icons.sports_handball,
        ),

        const SizedBox(height: 18),

        const CustomTextField(
          hintText: "Dominant Hand",
          prefixIcon: Icons.back_hand_outlined,
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: "Jersey Number",
                prefixIcon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                hintText: "Experience (Years)",
                prefixIcon: Icons.workspace_premium_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        const CustomTextField(
          hintText: "Current Club",
          prefixIcon: Icons.groups_outlined,
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: "Throw Power",
                prefixIcon: Icons.sports_score,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                hintText: "Throw Accuracy",
                prefixIcon: Icons.gps_fixed,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: "Jump Ability",
                prefixIcon: Icons.arrow_upward,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                hintText: "Reaction Speed",
                prefixIcon: Icons.flash_on_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: "Passing",
                prefixIcon: Icons.compare_arrows_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                hintText: "Defense",
                prefixIcon: Icons.shield_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Physical Strength",
          prefixIcon: Icons.fitness_center_outlined,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}