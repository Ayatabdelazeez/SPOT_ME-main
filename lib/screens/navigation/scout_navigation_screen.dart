import 'package:flutter/material.dart';
import 'package:spotme/screens/scout/home.dart';

import '../../utils/app_colors.dart';
import '../../widgets/scout_bottom_nav_bar.dart';
import '../scout/search_players_screen.dart';
import '../scout/scout_dashboard_screen.dart';
import '../scout/recommended_players_screen.dart';
import '../settings/settings_screen.dart';

class ScoutNavigationScreen extends StatefulWidget {
  final String selectedSport;

  const ScoutNavigationScreen({
    super.key,
    required this.selectedSport,
  });

  @override
  State<ScoutNavigationScreen> createState() =>
      _ScoutNavigationScreenState();
}

class _ScoutNavigationScreenState extends State<ScoutNavigationScreen> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      Home(selectedSport:widget.selectedSport),
      ScoutDashboardScreen(selectedSport: widget.selectedSport),
      SearchPlayersScreen(selectedSport: widget.selectedSport),
      RecommendedPlayersScreen(selectedSport: widget.selectedSport),
      const SettingsScreen(isScout: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[currentIndex],
      ),
      bottomNavigationBar: ScoutBottomNavBar(
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
