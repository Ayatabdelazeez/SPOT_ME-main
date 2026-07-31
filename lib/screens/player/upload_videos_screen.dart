import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/hidden_sports.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_upload_card.dart';
// import 'player_profile_screen.dart';
import '../navigation/player_navigation_screen.dart';
import '../basketball/basketball_dashboard_screen.dart';
import '../football/football_dashboard_screen.dart';
import '../handball/handball_dashboard_screen.dart';
import '../volleyball/volleyball_dashboard_screen.dart';

class UploadVideosScreen extends StatefulWidget {
  // const UploadVideosScreen({super.key});
  final String selectedSport;

  const UploadVideosScreen({super.key, required this.selectedSport});

  @override
  State<UploadVideosScreen> createState() => _UploadVideosScreenState();
}

class _UploadVideosScreenState extends State<UploadVideosScreen> {
  final ImagePicker picker = ImagePicker();

  String? matchVideo;
  String? trainingVideo;
  String? skillsVideo;

  void navigateToDashboard(BuildContext context) {
    if (HiddenSportsConfig.isHidden(widget.selectedSport)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This sport is temporarily hidden.')),
      );
      return;
    }

    switch (widget.selectedSport) {
      case "Football":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FootballDashboardScreen()),
        );

        break;

      case "Basketball":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BasketballDashboardScreen()),
        );

        break;

      case "Handball":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HandballDashboardScreen()),
        );

        break;

      case "Volleyball":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VolleyballDashboardScreen()),
        );

        break;
    }
  }

  Future<void> pickVideo(int type) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.video_library, color: Colors.white),
                title: const Text(
                  "Choose from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? file = await picker.pickVideo(
                    source: ImageSource.gallery,
                  );

                  if (file != null) {
                    setState(() {
                      if (type == 1) {
                        matchVideo = file.name;
                      } else if (type == 2) {
                        trainingVideo = file.name;
                      } else {
                        skillsVideo = file.name;
                      }
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam, color: Colors.white),
                title: const Text(
                  "Record Video",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? file = await picker.pickVideo(
                    source: ImageSource.camera,
                  );

                  if (file != null) {
                    setState(() {
                      if (type == 1) {
                        matchVideo = file.name;
                      } else if (type == 2) {
                        trainingVideo = file.name;
                      } else {
                        skillsVideo = file.name;
                      }
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Upload Videos"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Show Your Skills", style: AppTextStyles.heading1),

            const SizedBox(height: 8),

            Text(
              "Upload your best highlights and training videos.",
              style: AppTextStyles.body.copyWith(color: Colors.white70),
            ),

            const SizedBox(height: 24),

            CustomUploadCard(
              title: "Match Highlights",
              subtitle: matchVideo ?? "Upload your best match moments",
              icon: Icons.video_library_outlined,
              onTap: () => pickVideo(1),
            ),

            const SizedBox(height: 14),

            CustomUploadCard(
              title: "Training Video",
              subtitle: trainingVideo ?? "Upload training sessions",
              icon: Icons.fitness_center_outlined,
              onTap: () => pickVideo(2),
            ),

            const SizedBox(height: 14),

            CustomUploadCard(
              title: "Skills Video",
              subtitle: skillsVideo ?? "Show your technical abilities",
              icon: Icons.sports,
              onTap: () => pickVideo(3),
            ),

            const Spacer(),

            // CustomButton(
            //   text: "Finish Registration",
            //   icon: Icons.check_circle_outline,
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => PlayerProfileScreen(
            //           selectedSport: widget.selectedSport,
            //         ),
            //       ),
            //     );
            //   },
            // ),
            CustomButton(
              text: "Finish Registration",
              icon: Icons.check_circle_outline,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlayerNavigationScreen(
                      selectedSport: widget.selectedSport,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
