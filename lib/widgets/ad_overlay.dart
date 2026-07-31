import 'package:flutter/material.dart';

import '../models/ad_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'ad_illustrations.dart';

/// Full-screen sponsored-ad dialog. Call [showAdOverlay] rather than
/// using this widget directly.
class AdOverlay extends StatelessWidget {
  final AdModel ad;

  const AdOverlay({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: ad.color.withOpacity(0.4)),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Sponsored",
                    style: AppTextStyles.body.copyWith(fontSize: 10, color: Colors.white54),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: Colors.white54, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Center(
              child: AdIllustration(visual: ad.visual, color: ad.color, size: 110),
            ),
            const SizedBox(height: 18),
            Text(
              ad.brand,
              style: AppTextStyles.body.copyWith(color: ad.color, fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 6),
            Text(ad.title, style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Text(ad.subtitle, style: AppTextStyles.body.copyWith(color: Colors.white70)),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ad.color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(ad.ctaText, style: AppTextStyles.button.copyWith(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows [ad] as a dismissible full-screen dialog on top of whatever is
/// currently on screen.
void showAdOverlay(BuildContext context, AdModel ad) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black87,
    builder: (_) => AdOverlay(ad: ad),
  );
}