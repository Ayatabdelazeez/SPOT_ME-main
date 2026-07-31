import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import 'upload_medical_reports_screen.dart';

class MedicalHistoryScreen extends StatefulWidget {
  // const MedicalHistoryScreen({super.key});
  final String selectedSport;

  const MedicalHistoryScreen({
    super.key,
    required this.selectedSport,
  });
  //

  @override
  State<MedicalHistoryScreen> createState() =>
      _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState
    extends State<MedicalHistoryScreen> {
  String? injury;
  String? surgery;
  String? allergy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Medical History",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              "Medical Information",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Help scouts understand your physical condition.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 30),

            CustomDropdown(
              hint: "Previous Injuries",
              value: injury,
              icon: Icons.healing,
              items: const [
                "No",
                "Yes",
              ],
              onChanged: (value) {
                setState(() {
                  injury = value;   
                });
              },
            ),

            const SizedBox(height: 18),

            CustomDropdown(
              hint: "Previous Surgery",
              value: surgery,
              icon: Icons.local_hospital,
              items: const [
                "No",
                "Yes",
              ],
              onChanged: (value) {
                setState(() {
                  surgery = value;
                });
              },
            ),

            const SizedBox(height: 18),

            CustomDropdown(
              hint: "Any Allergies",
              value: allergy,
              icon: Icons.medication,
              items: const [
                "No",
                "Yes",
              ],
              onChanged: (value) {
                setState(() {
                  allergy = value;
                });
              },
            ),

            const SizedBox(height: 40),

            CustomButton(
              text: "Continue",
              icon: Icons.arrow_forward,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        UploadMedicalReportsScreen(
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