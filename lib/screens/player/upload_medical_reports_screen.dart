import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_upload_card.dart';
import 'upload_videos_screen.dart';


class UploadMedicalReportsScreen extends StatefulWidget {
  // const UploadMedicalReportsScreen({super.key});
  final String selectedSport;

  const UploadMedicalReportsScreen({
    super.key,
    required this.selectedSport,
  });
//
  @override
  State<UploadMedicalReportsScreen> createState() =>
      _UploadMedicalReportsScreenState();
}

class _UploadMedicalReportsScreenState
    extends State<UploadMedicalReportsScreen> {
  String? medicalReport;
  String? xRay;
  String? mri;

  Future<void> pickFile(int type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'jpeg',
        'png',
      ],
    );

    if (result != null) {
      setState(() {
        if (type == 1) {
          medicalReport = result.files.single.name;
        } else if (type == 2) {
          xRay = result.files.single.name;
        } else {
          mri = result.files.single.name;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Medical Reports",
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
              "Upload Medical Documents",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Upload your medical reports if available.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 24),

            CustomUploadCard(
              title: "Medical Report",
              subtitle: medicalReport ?? "Upload PDF or Image",
              icon: Icons.description_outlined,
              onTap: () => pickFile(1),
            ),

            const SizedBox(height: 14),

            CustomUploadCard(
              title: "X-Ray",
              subtitle: xRay ?? "Upload X-Ray Images",
              icon: Icons.image_outlined,
              onTap: () => pickFile(2),
            ),

            const SizedBox(height: 14),

            CustomUploadCard(
              title: "MRI / Scan",
              subtitle: mri ?? "Upload MRI or Scan",
              icon: Icons.document_scanner_outlined,
              onTap: () => pickFile(3),
            ),

            const Spacer(),

            CustomButton(
              text: "Continue",
              icon: Icons.arrow_forward,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        UploadVideosScreen(
                          //
                          selectedSport: widget.selectedSport,

                          //
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