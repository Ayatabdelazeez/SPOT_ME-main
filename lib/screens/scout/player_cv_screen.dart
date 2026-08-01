import 'package:flutter/material.dart';
import 'package:spotme/models/player_model.dart';
import 'package:spotme/screens/scout/report_dialog.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';

class PlayerCvScreen extends StatelessWidget {
  const PlayerCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyPlayer = PlayerModel(
      name: "Ahmed Mohamed",
      email: "ahmed@example.com",
      phone: "01000000000",
      sport: "Football",
      position: "Forward",
      age: 20,
      height: 182,
      weight: 76,
      score: 91,
      image: "",
      club: "Future FC",
      experienceYears: 7,
      violationsCount: 0, 
      isBlocked: false,
    );
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white), // for back arrow color 
        centerTitle: true,
        title: Text("Player CV" ,
         style: AppTextStyles.heading3),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag_outlined, color: AppColors.red),
            tooltip: "Report Fraud",
            onPressed: () {
              final dummyPlayer = PlayerModel(
                name: "Ahmed Mohamed",
                email: "",
                phone: "",
                sport: "Football",
                position: "Forward",
                age: 20,
                height: 182,
                weight: 76,
                score: 91,
                image: "",
                club: "Future FC",
                experienceYears: 7,
              );
              showReportFraudDialog(context, dummyPlayer);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.blue,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "Ahmed Mohamed",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 5),

            Text(
              "Football Player",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 25),

            buildTrustBadge(dummyPlayer),

            const SizedBox(height: 25),

            const CustomCard(
              title: "Age",
              subtitle: "20 Years",
              icon: Icons.cake_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Position",
              subtitle: "Forward",
              icon: Icons.sports_soccer,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Height",
              subtitle: "182 cm",
              icon: Icons.height,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Weight",
              subtitle: "76 kg",
              icon: Icons.monitor_weight_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Current Club",
              subtitle: "Future FC",
              icon: Icons.shield_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "Experience",
              subtitle: "7 Years",
              icon: Icons.workspace_premium_outlined,
            ),

            const SizedBox(height: 15),

            const CustomCard(
              title: "AI Rating",
              subtitle: "91 / 100",
              icon: Icons.auto_awesome,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Contact Player",
              icon: Icons.chat_outlined,
              onPressed: () {},
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: "Save Player",
              icon: Icons.bookmark_outline,
              onPressed: () {},
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget buildTrustBadge(PlayerModel player) {
    if (player.isBlocked) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.block, color: Colors.red, size: 14),
            SizedBox(width: 4),
            Text("ACCOUNT BLOCKED", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } else if (player.violationsCount > 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning, color: Colors.orange, size: 14),
            SizedBox(width: 4),
            Text("FLAGGED / WARNING", style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified, color: Colors.green, size: 14),
            SizedBox(width: 4),
            Text("VERIFIED", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  }
}
