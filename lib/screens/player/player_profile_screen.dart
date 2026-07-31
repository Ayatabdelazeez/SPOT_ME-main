import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/player_providers.dart';
import '../../utils/app_colors.dart';
import '../../utils/hidden_sports.dart';
import '../../widgets/custom_button.dart';
import 'edit_profile_screen.dart';
import '../football/football_dashboard_screen.dart';
import '../basketball/basketball_dashboard_screen.dart';
import '../handball/handball_dashboard_screen.dart';
import '../volleyball/volleyball_dashboard_screen.dart';

class PlayerProfileScreen extends StatelessWidget {
  final String selectedSport;

  const PlayerProfileScreen({super.key, required this.selectedSport});

  static const List<Map<String, dynamic>> _highlights = [
    {"label": "Skills", "icon": Icons.sports_soccer},
    {"label": "Matches", "icon": Icons.stadium},
    {"label": "Training", "icon": Icons.fitness_center},
    {"label": "Goals", "icon": Icons.emoji_events},
  ];

  void openDashboard(BuildContext context) {
    if (HiddenSportsConfig.isHidden(selectedSport)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This sport is temporarily hidden.')),
      );
      return;
    }

    switch (selectedSport) {
      case "Football":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FootballDashboardScreen()),
        );
        break;
      case "Basketball":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BasketballDashboardScreen()),
        );
        break;
      case "Handball":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HandballDashboardScreen()),
        );
        break;
      case "Volleyball":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VolleyballDashboardScreen()),
        );
        break;
    }
  }

  Future<void> openEditProfile(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();

    final cardsData = [
      {"label": "Height", "value": player.height},
      {"label": "Weight", "value": player.weight},
      {"label": "Position", "value": player.position},
      {"label": "Club", "value": player.club},
      {"label": "Experience", "value": player.experience},
    ];

    final stats = [
      {"label": "Goals", "value": "${player.goals}"},
      {"label": "Assists", "value": "${player.assists}"},
      {"label": "Matches", "value": "${player.matches}"},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            _buildProfileHeader(player),
            const SizedBox(height: 16),
            _buildSectionTitle("Cards", AppColors.blue),
            const SizedBox(height: 8),
            _buildCardsWrap(cardsData),
            const SizedBox(height: 16),
            _buildSectionTitle("Bio", AppColors.red),
            const SizedBox(height: 8),
            _buildBioSection(player.bio),
            const SizedBox(height: 16),
            _buildSectionTitle("Highlights", AppColors.blue),
            const SizedBox(height: 8),
            _buildHighlightsRow(),
            const SizedBox(height: 16),
            _buildSectionTitle("Statistics", AppColors.red),
            const SizedBox(height: 8),
            _buildStatisticsRow(stats),
            const SizedBox(height: 16),
            CustomButton(
              text: "Edit Profile",
              icon: Icons.edit,
              backgroundColor: AppColors.red,
              height: 44,
              onPressed: () => openEditProfile(context),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: "Go To Dashboard",
              icon: Icons.dashboard_outlined,
              backgroundColor: AppColors.blue,
              height: 44,
              onPressed: () => openDashboard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(PlayerProvider player) {
    final name = player.playerName.isEmpty ? "Player Name" : player.playerName;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.blue.withValues(alpha: 0.35),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.blue, width: 3),
              image: player.profileImage != null
                  ? DecorationImage(
                      image: FileImage(player.profileImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: player.profileImage == null
                ? const Icon(Icons.person, color: AppColors.blue, size: 38)
                : null,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.red, width: 1),
          ),
          child: Text(
            "${player.age} years old  •  $selectedSport",
            style: const TextStyle(color: AppColors.grey, fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color accentColor) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCardsWrap(List<Map<String, String>> cardsData) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(cardsData.length, (index) {
        final item = cardsData[index];
        final Color sideColor = index.isEven ? AppColors.blue : AppColors.red;

        return Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: sideColor, width: 3)),
          ),
          child: Column(
            children: [
              Text(
                item["value"]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: sideColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item["label"]!,
                style: const TextStyle(color: AppColors.grey, fontSize: 10),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBioSection(String bio) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: const Border(left: BorderSide(color: AppColors.red, width: 3)),
      ),
      child: Text(
        bio,
        style: const TextStyle(
          color: AppColors.grey,
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildHighlightsRow() {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _highlights.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _highlights[index];
          return _buildHighlightCircle(
            item["label"] as String,
            item["icon"] as IconData,
          );
        },
      ),
    );
  }

  Widget _buildHighlightCircle(String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          padding: const EdgeInsets.all(2.5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.blue, AppColors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(2.5),
            decoration: const BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.card,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.white, size: 20),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildStatisticsRow(List<Map<String, String>> stats) {
    return Row(
      children: stats.map((item) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  item["value"]!,
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item["label"]!,
                  style: const TextStyle(color: AppColors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
