import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/ads_data.dart';
import '../../providers/player_providers.dart';
import '../../utils/app_colors.dart';
import '../../widgets/ad_overlay.dart';
import '../../widgets/player_bottom_nav_bar.dart';

import '../player/player_home_screen.dart';
import '../player/player_profile_screen.dart';
import '../player/upload_videos_screen.dart';
import '../ai/ai_dashboard_screen.dart';
import '../settings/settings_screen.dart';

class PlayerNavigationScreen extends StatefulWidget {
  final String selectedSport;

  const PlayerNavigationScreen({
    super.key,
    required this.selectedSport,
  });

  @override
  State<PlayerNavigationScreen> createState() =>
      _PlayerNavigationScreenState();
}

class _PlayerNavigationScreenState extends State<PlayerNavigationScreen> {
  int currentIndex = 0;

  late final List<Widget> pages;
  Timer? _adTimer;

  @override
  void initState() {
    super.initState();

    // Order matches bottom nav: Home, AI, Upload, Profile, Settings
    pages = [
      PlayerHomeScreen(selectedSport: widget.selectedSport),
      const AiDashboardScreen(),
      UploadVideosScreen(selectedSport: widget.selectedSport),
      PlayerProfileScreen(selectedSport: widget.selectedSport),
      const SettingsScreen(),
    ];

    // Show a sponsored ad right when the app opens...
    WidgetsBinding.instance.addPostFrameCallback((_) => _showRandomAd());

    // ...then again every 2.5 minutes while the player is using the app.
    _adTimer = Timer.periodic(
      const Duration(minutes: 2, seconds: 30),
      (_) => _showRandomAd(),
    );
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    super.dispose();
  }

  void _showRandomAd() {
    if (!mounted) return;

    final sport = context.read<PlayerProvider>().selectedSport;
    final candidates = AdsData.forSport(
      sport.isNotEmpty ? sport : widget.selectedSport,
    );
    final ad = candidates[Random().nextInt(candidates.length)];

    showAdOverlay(context, ad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[currentIndex],
      ),
      bottomNavigationBar: PlayerBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
