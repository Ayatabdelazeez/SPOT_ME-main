
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class FootballInformationForm extends StatelessWidget {
  const FootballInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hintText: "Preferred Position",
          prefixIcon: Icons.sports_soccer,
        ),

        const SizedBox(height: 18),

        const CustomTextField(
          hintText: "Dominant Foot",
          prefixIcon: Icons.directions_run_outlined,
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
                hintText: "Speed",
                prefixIcon: Icons.speed,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Acceleration",
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
                hintText: "Dribbling",
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
                hintText: "Shooting",
                prefixIcon: Icons.gps_fixed,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Defending",
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