import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class VolleyballInformationForm extends StatelessWidget {
  const VolleyballInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hintText: "Preferred Position",
          prefixIcon: Icons.sports_volleyball,
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
                hintText: "Serve Accuracy",
                prefixIcon: Icons.gps_fixed,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Serve Power",
                prefixIcon: Icons.sports_score,
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
                hintText: "Spike Power",
                prefixIcon: Icons.flash_on_outlined,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Spike Accuracy",
                prefixIcon: Icons.track_changes,
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
                hintText: "Blocking",
                prefixIcon: Icons.block,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Receiving",
                prefixIcon: Icons.pan_tool_alt_outlined,
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
                hintText: "Setting",
                prefixIcon: Icons.compare_arrows_outlined,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CustomTextField(
                hintText: "Jump Height",
                prefixIcon: Icons.arrow_upward,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        CustomTextField(
          hintText: "Overall Volleyball Skills",
          prefixIcon: Icons.emoji_events_outlined,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}