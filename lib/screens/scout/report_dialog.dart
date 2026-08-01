import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/player_model.dart';

void showReportFraudDialog(BuildContext context, PlayerModel player) {
  final reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.red),
          const SizedBox(width: 8),
          Text(
            "Report ${player.name}",
            style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select or describe the discrepancy (e.g. Age fraud, forged docs):",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: reasonController,
            maxLines: 3,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: "Enter details here...",
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text("Cancel", style: TextStyle(color: Colors.white60)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
          onPressed: () {
            if (reasonController.text.trim().isEmpty) return;

            Navigator.pop(dialogContext);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Report submitted for ${player.name}. Admin will review it."),
                backgroundColor: AppColors.blue,
              ),
            );
          },
          child: const Text("Submit Report", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
