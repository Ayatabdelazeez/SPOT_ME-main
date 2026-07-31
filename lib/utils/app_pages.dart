import 'package:flutter/material.dart';

import '../screens/ai/ai_chat_screen.dart';
import '../screens/ai/ai_dashboard_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/onboarding_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/auth/splash_screen.dart';
// import '../screens/navigation/main_navigation_screen.dart';
import '../screens/player/choose_sport_screen.dart';
// import '../screens/player/medical_history_screen.dart';
// import '../screens/player/player_profile_screen.dart';
// import '../screens/player/upload_medical_reports_screen.dart';
// import '../screens/player/upload_videos_screen.dart';
import '../screens/scout/scout_dashboard_screen.dart';
import '../screens/settings/about_screen.dart';
import '../screens/settings/notifications_screen.dart';
import '../screens/settings/settings_screen.dart';
import 'app_routes.dart';


import '../screens/subscription/scout_subscription_screen.dart';
import '../screens/subscription/player_subscription_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';

// import '../screens/navigation/player_navigation_screen.dart';
// import '../screens/navigation/scout_navigation_screen.dart';

class AppPages {
  AppPages._();

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.splash: (_) => const SplashScreen(),
    AppRoutes.onboarding: (_) => const OnboardingScreen(),
    AppRoutes.login: (_) => const LoginScreen(),
    AppRoutes.register: (_) => const RegisterScreen(),
    AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
    AppRoutes.roleSelection: (_) => const RoleSelectionScreen(),
    AppRoutes.chooseSport: (_) => const ChooseSportScreen(),
    // AppRoutes.medicalHistory: (_) =>
    //     const MedicalHistoryScreen(),
    // AppRoutes.uploadMedical: (_) =>
    //     const UploadMedicalReportsScreen(),
    // AppRoutes.uploadVideos: (_) =>
    //     const UploadVideosScreen(),
    AppRoutes.medicalHistory: (_) => throw UnimplementedError(),
    AppRoutes.uploadMedical: (_) => throw UnimplementedError(),
    AppRoutes.uploadVideos: (_) => throw UnimplementedError(),
    AppRoutes.playerProfile: (_) => throw UnimplementedError(),
    AppRoutes.aiDashboard: (_) => const AiDashboardScreen(),
    AppRoutes.aiChat: (_) => const AiChatScreen(),
    AppRoutes.scoutDashboard: (_) => const ScoutDashboardScreen(),
    AppRoutes.navigation: (_) => throw UnimplementedError(),
    AppRoutes.settings: (_) => const SettingsScreen(),
    AppRoutes.notifications: (_) => const NotificationsScreen(),
    AppRoutes.about: (_) => const AboutScreen(),

    AppRoutes.subscription: (_) => const PlayerSubscriptionScreen(),

AppRoutes.scoutSubscription: (_) =>
    const ScoutSubscriptionScreen(),

    AppRoutes.adminDashboard: (_) => const AdminDashboardScreen(),
  
  };
}