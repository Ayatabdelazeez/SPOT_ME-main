import 'package:flutter/material.dart';
import 'ai_upload_cv_screen.dart';
import 'ai_cv_generator_screen.dart';

class CvChoiceScreen extends StatelessWidget {
  const CvChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B0F19),

      appBar: AppBar(
  backgroundColor: const Color(0xFF111827),
  elevation: 0,
  centerTitle: true,
  automaticallyImplyLeading: false,

  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back_ios_new,
      color: Colors.white,
      size: 25,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

  title: const Text(
    "AI CV Assistant",
    style: TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xff111827),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: Color(0xff1E90FF),
                size: 50,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Do you already have a CV?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Upload your existing CV or\ncreate a new one using AI.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF2D55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UploadCvScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Yes, Upload My CV",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xff1E90FF),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AiCvGeneratorScreen(),
                    ),
                  );
                },
                child: const Text(
                  "No, Create CV with AI",
                  style: TextStyle(
                    color: Color(0xff1E90FF),
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
