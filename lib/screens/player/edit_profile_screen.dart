
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/player_providers.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController cityController;
  late TextEditingController nationalityController;

  final ImagePicker picker = ImagePicker();

  File? profileImage;

  @override
  void initState() {
    super.initState();

    final player = context.read<PlayerProvider>();

    profileImage = player.profileImage;

    nameController =
        TextEditingController(text: player.playerName);

    phoneController =
        TextEditingController(text: player.phone);

    emailController =
        TextEditingController(text: player.email);

    cityController =
        TextEditingController(text: player.city);

    nationalityController =
        TextEditingController(text: player.nationality);
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.blue,
                  ),
                  title: const Text(
                    "Choose from Gallery",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: AppColors.blue,
                  ),
                  title: const Text(
                    "Take Photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cityController.dispose();
    nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "Edit Profile",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: AppColors.blue,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : null,
                      child: profileImage == null
                          ? const Icon(
                              Icons.person,
                              size: 55,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(height: 15),
                    TextButton.icon(
                      onPressed: showImagePicker,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text(
                        "Change Photo",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Text(
                "Personal Information",
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: 8),

              Text(
                "Update your profile information.",
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 25),

              CustomTextField(
                controller: nameController,
                hintText: "Full Name",
                prefixIcon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              CustomTextField(
                controller: phoneController,
                hintText: "Phone Number",
                prefixIcon: Icons.phone_outlined,
              ),

              const SizedBox(height: 18),

              CustomTextField(
                controller: emailController,
                hintText: "Email",
                prefixIcon: Icons.email_outlined,
              ),

              const SizedBox(height: 18),

              CustomTextField(
                controller: cityController,
                hintText: "City",
                prefixIcon:
                    Icons.location_city_outlined,
              ),

              const SizedBox(height: 18),

              CustomTextField(
                controller: nationalityController,
                hintText: "Nationality",
                prefixIcon: Icons.flag_outlined,
              ),

              const SizedBox(height: 35),
                            CustomButton(
                text: "Save Changes",
                icon: Icons.check,
                onPressed: () {
                  context.read<PlayerProvider>().updateProfile(
                        playerName: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        city: cityController.text,
                        nationality: nationalityController.text,
                        profileImage: profileImage,
                      );

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}