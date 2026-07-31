
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class BasketballInformationForm extends StatelessWidget {
  const BasketballInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hintText: "Preferred Position",
          prefixIcon: Icons.sports_basketball,
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
                hintText: "Vertical Jump (cm)",
                prefixIcon: Icons.arrow_upward,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Wingspan (cm)",
                prefixIcon: Icons.straighten,
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
                hintText: "3-Point Shooting",
                prefixIcon: Icons.sports_score,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Free Throw",
                prefixIcon: Icons.adjust,
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
                hintText: "Ball Handling",
                prefixIcon: Icons.sports,
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
                hintText: "Rebounding",
                prefixIcon: Icons.sports_handball,
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
      ],
    );
  }
}