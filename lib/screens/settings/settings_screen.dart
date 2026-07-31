// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/player_providers.dart';
// import '../../providers/scout_providers.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/app_routes.dart';
// import '../../utils/app_text_styles.dart';
// import '../../widgets/custom_app_bar.dart';
// // import 'dart:io';
// import '../player/edit_profile_screen.dart';
// import '../scout/scout_edit_profile_screen.dart';
// import 'notifications_screen.dart';

// class SettingsScreen extends StatelessWidget {
//   final bool isScout;

//   const SettingsScreen({super.key, this.isScout = false});

//   Widget sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, bottom: 12),
//       child: Text(
//         title,
//         style: AppTextStyles.body.copyWith(
//           color: Colors.white54,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 1,
//         ),
//       ),
//     );
//   }

//   Widget settingsTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     VoidCallback? onTap,
//     Color iconColor = AppColors.blue,
//     bool logout = false,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: AppColors.card,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: ListTile(
//         onTap: onTap,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//         leading: CircleAvatar(
//           backgroundColor: iconColor.withOpacity(0.15),
//           child: Icon(icon, color: iconColor),
//         ),
//         title: Text(
//           title,
//           style: AppTextStyles.body.copyWith(
//             fontWeight: FontWeight.w600,
//             color: logout ? AppColors.red : Colors.white,
//           ),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: AppTextStyles.body.copyWith(
//             color: Colors.white54,
//             fontSize: 13,
//           ),
//         ),
//         trailing: Icon(
//           logout ? Icons.logout_rounded : Icons.arrow_forward_ios_rounded,
//           size: 18,
//           color: logout ? AppColors.red : Colors.white38,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final player = isScout ? null : context.watch<PlayerProvider>();
//     final scout = isScout ? context.watch<ScoutProvider>() : null;

//     final displayName = isScout ? scout!.scoutName : player!.playerName;
//     final displaySubtitle = isScout ? "Scout" : "Football Player";
//     final displayImage = isScout ? scout!.profileImage : player!.profileImage;

//     return Scaffold(
//       backgroundColor: AppColors.background,

//       appBar: const CustomAppBar(title: "Settings"),

//       body: ListView(
//         padding: const EdgeInsets.all(20),

//         children: [
//           Container(
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(
//               gradient: AppColors.dashboardGradient,
//               borderRadius: BorderRadius.circular(22),
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 32,
//                   backgroundColor: AppColors.blue,
//                   backgroundImage: displayImage != null
//                       ? FileImage(displayImage)
//                       : null,
//                   child: displayImage == null
//                       ? const Icon(Icons.person, color: Colors.white, size: 32)
//                       : null,
//                 ),

//                 const SizedBox(width: 15),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(displayName, style: AppTextStyles.heading3),

//                     const SizedBox(height: 5),

//                     Text(
//                       displaySubtitle,
//                       style: AppTextStyles.body.copyWith(color: Colors.white70),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           sectionTitle("ACCOUNT"),

//           settingsTile(
//             context: context,
//             icon: Icons.person_outline,
//             title: "Edit Profile",
//             subtitle: "Update your personal information",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => isScout
//                       ? const ScoutEditProfileScreen()
//                       : const EditProfileScreen(),
//                 ),
//               );
//             },
//           ),

//           settingsTile(
//             context: context,
//             icon: Icons.notifications_outlined,
//             title: "Notifications",
//             subtitle: isScout
//                 ? "Manage scout alerts & preferences"
//                 : "Manage app notifications",
//             onTap: () {
//               if (isScout) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         const NotificationsScreen(isScout: true),
//                   ),
//                 );
//               } else {
//                 Navigator.pushNamed(context, AppRoutes.notifications);
//               }
//             },
//           ),

//           settingsTile(
//             context: context,
//             icon: Icons.language,
//             title: "Language",
//             subtitle: "English",
//           ),

//           sectionTitle("SUPPORT"),

//           settingsTile(
//             context: context,
//             icon: Icons.help_outline,
//             title: "Help Center",
//             subtitle: "FAQs & contact support",
//           ),

//           settingsTile(
//             context: context,
//             icon: Icons.privacy_tip_outlined,
//             title: "Privacy Policy",
//             subtitle: "Read our privacy policy",
//           ),

//           settingsTile(
//             context: context,
//             icon: Icons.description_outlined,
//             title: "Terms & Conditions",
//             subtitle: "Application terms of use",
//           ),

//           sectionTitle("ABOUT"),

//           settingsTile(
//             context: context,
//             icon: Icons.info_outline,
//             title: "About SpotMe",
//             subtitle: "Version 1.0.0",
//             onTap: () {
//               Navigator.pushNamed(context, AppRoutes.about);
//             },
//           ),

//           settingsTile(
//             context: context,
//             icon: Icons.star_outline,
//             title: "Rate SpotMe",
//             subtitle: "Share your feedback",
//           ),

//           settingsTile(
//             context: context,
//             icon: Icons.logout,
//             iconColor: AppColors.red,
//             title: "Logout",
//             subtitle: "Sign out from your account",
//             logout: true,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:spotme/l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/player_providers.dart';
import '../../providers/scout_providers.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

import '../player/edit_profile_screen.dart';
import '../scout/scout_edit_profile_screen.dart';
import 'notifications_screen.dart';
import '../../providers/language_provider.dart';

class SettingsScreen extends StatelessWidget {
  final bool isScout;

  const SettingsScreen({super.key, this.isScout = false});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(
        title,
        style: AppTextStyles.body.copyWith(
          color: Colors.white54,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget settingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Color iconColor = AppColors.blue,
    bool logout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),

      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.15),

          child: Icon(icon, color: iconColor),
        ),

        title: Text(
          title,

          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: logout ? AppColors.red : Colors.white,
          ),
        ),

        subtitle: Text(
          subtitle,

          style: AppTextStyles.body.copyWith(
            color: Colors.white54,
            fontSize: 13,
          ),
        ),

        trailing: Icon(
          logout ? Icons.logout_rounded : Icons.arrow_forward_ios_rounded,

          size: 18,

          color: logout ? AppColors.red : Colors.white38,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final player = isScout ? null : context.watch<PlayerProvider>();

    final scout = isScout ? context.watch<ScoutProvider>() : null;

    final displayName = isScout ? scout!.scoutName : player!.playerName;

    final displaySubtitle = isScout ? t.scout : t.footballPlayer;

    final displayImage = isScout ? scout!.profileImage : player!.profileImage;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: CustomAppBar(title: t.settings),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              gradient: AppColors.dashboardGradient,

              borderRadius: BorderRadius.circular(22),
            ),

            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,

                  backgroundColor: AppColors.blue,

                  backgroundImage: displayImage != null
                      ? FileImage(displayImage)
                      : null,

                  child: displayImage == null
                      ? const Icon(Icons.person, color: Colors.white, size: 32)
                      : null,
                ),

                const SizedBox(width: 15),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(displayName, style: AppTextStyles.heading3),

                    const SizedBox(height: 5),

                    Text(
                      displaySubtitle,

                      style: AppTextStyles.body.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          sectionTitle(t.account),

          settingsTile(
            context: context,

            icon: Icons.person_outline,

            title: t.editProfile,

            subtitle: t.updateProfile,

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) => isScout
                      ? const ScoutEditProfileScreen()
                      : const EditProfileScreen(),
                ),
              );
            },
          ),

          settingsTile(
            context: context,

            icon: Icons.notifications_outlined,

            title: t.notifications,

            subtitle: isScout ? t.scoutNotifications : t.appNotifications,

            onTap: () {
              if (isScout) {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(isScout: true),
                  ),
                );
              } else {
                Navigator.pushNamed(context, AppRoutes.notifications);
              }
            },
          ),

          settingsTile(
            context: context,
            icon: Icons.language,
            title: t.language,
            subtitle:
                context.watch<LanguageProvider>().locale.languageCode == "ar"
                ? "العربية"
                : "English",
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.card,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                builder: (_) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15),

                        ListTile(
                          leading: const Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                          title: const Text(
                            "English",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            context.read<LanguageProvider>().changeLanguage(
                              "en",
                            );

                            Navigator.pop(context);
                          },
                        ),

                        ListTile(
                          leading: const Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                          title: const Text(
                            "العربية",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            context.read<LanguageProvider>().changeLanguage(
                              "ar",
                            );

                            Navigator.pop(context);
                          },
                        ),

                        const SizedBox(height: 15),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          sectionTitle(t.support),

          settingsTile(
            context: context,

            icon: Icons.help_outline,

            title: t.helpCenter,

            subtitle: t.faqSupport,
          ),

          settingsTile(
            context: context,

            icon: Icons.privacy_tip_outlined,

            title: t.privacyPolicy,

            subtitle: t.readPrivacy,
          ),

          settingsTile(
            context: context,

            icon: Icons.description_outlined,

            title: t.termsConditions,

            subtitle: t.appTerms,
          ),

          sectionTitle(t.about),

          settingsTile(
            context: context,

            icon: Icons.info_outline,

            title: t.aboutSpotMe,

            subtitle: t.version,

            onTap: () {
              Navigator.pushNamed(context, AppRoutes.about);
            },
          ),

          settingsTile(
            context: context,

            icon: Icons.star_outline,

            title: t.rateSpotMe,

            subtitle: t.feedback,
          ),

          settingsTile(
            context: context,

            icon: Icons.logout,

            iconColor: AppColors.red,

            title: t.logout,

            subtitle: t.signOut,

            logout: true,
          ),
        ],
      ),
    );
  }
}
