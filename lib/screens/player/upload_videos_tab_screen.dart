import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_upload_card.dart';

class UploadVideosTabScreen extends StatefulWidget {
  final String selectedSport;

  const UploadVideosTabScreen({
    super.key,
    required this.selectedSport,
  });

  @override
  State<UploadVideosTabScreen> createState() =>
      _UploadVideosTabScreenState();
}

class _UploadVideosTabScreenState extends State<UploadVideosTabScreen> {
  final ImagePicker picker = ImagePicker();

  String? matchVideo;
  String? trainingVideo;
  String? skillsVideo;

  Future<void> pickVideo(int type) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.video_library,
                  color: Colors.white,
                ),
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
                      switch (type) {
                        case 1:
                          matchVideo = file.name;
                          break;
                        case 2:
                          trainingVideo = file.name;
                          break;
                        case 3:
                          skillsVideo = file.name;
                          break;
                      }
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.videocam,
                  color: Colors.white,
                ),
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
                      switch (type) {
                        case 1:
                          matchVideo = file.name;
                          break;
                        case 2:
                          trainingVideo = file.name;
                          break;
                        case 3:
                          skillsVideo = file.name;
                          break;
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

  void uploadVideos() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Videos uploaded successfully!"),
      ),
    );

    // هنا بعدين هتضيفي API رفع الفيديوهات.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Upload Videos",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload Your Videos",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Share your latest matches, training sessions and skills with scouts.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 24),

            CustomUploadCard(
              title: "Match Highlights",
              subtitle:
                  matchVideo ?? "Upload your best match moments",
              icon: Icons.video_library_outlined,
              onTap: () => pickVideo(1),
            ),

            const SizedBox(height: 14),

            CustomUploadCard(
              title: "Training Video",
              subtitle:
                  trainingVideo ?? "Upload training sessions",
              icon: Icons.fitness_center_outlined,
              onTap: () => pickVideo(2),
            ),

            const SizedBox(height: 14),

            CustomUploadCard(
              title: "Skills Video",
              subtitle:
                  skillsVideo ?? "Show your technical abilities",
              icon: Icons.sports,
              onTap: () => pickVideo(3),
            ),

            const Spacer(),

            CustomButton(
              text: "Upload Videos",
              icon: Icons.cloud_upload_outlined,
              onPressed: uploadVideos,
            ),
          ],
        ),
      ),
    );
  }
}
