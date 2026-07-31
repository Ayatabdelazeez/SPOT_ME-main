import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';

class PlayerCvScreen extends StatelessWidget {
  const PlayerCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white), // for back arrow color 
        centerTitle: true,
        title: Text("Player CV" ,
         style: AppTextStyles.heading3),
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
}
