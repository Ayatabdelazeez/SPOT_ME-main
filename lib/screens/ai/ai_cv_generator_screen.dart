
import 'package:flutter/material.dart';
import 'package:spotme/utils/app_routes.dart';

// import '../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';

class AiCvGeneratorScreen extends StatelessWidget {
  const AiCvGeneratorScreen({super.key});

  Widget buildField(String label,
      {int maxLines = 1, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon:
              icon != null ? Icon(icon, color: Color(0xff1E90FF)) : null,
          labelText: label,
          labelStyle:
              const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xff111827),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xff1E90FF),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xffFF2D55),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B0F19),

      appBar: const CustomAppBar(
  title: "AI CV Generator",
),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xff111827),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Color(0xffFF2D55),
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Create Your CV with AI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Fill in your information and let AI generate a professional CV.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 30),

            buildField(
              "Full Name",
              icon: Icons.person,
            ),

            buildField(
              "Email",
              icon: Icons.email,
            ),

            buildField(
              "Phone Number",
              icon: Icons.phone,
            ),

            buildField(
              "Education",
              icon: Icons.school,
            ),

            buildField(
              "Skills",
              maxLines: 3,
              icon: Icons.psychology,
            ),

            buildField(
              "Experience",
              maxLines: 4,
              icon: Icons.work,
            ),

            buildField(
              "Projects",
              maxLines: 4,
              icon: Icons.folder,
            ),

            buildField(
              "Languages",
              icon: Icons.language,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xffFF2D55),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.subscription,
                        );
                },
                icon: const Icon(Icons.auto_awesome,
                    color: Colors.white),
                label: const Text(
                  "Generate CV",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
