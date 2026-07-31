import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/player_providers.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../settings/notifications_screen.dart';

class PlayerHomeScreen extends StatelessWidget {
  final String selectedSport;

  const PlayerHomeScreen({
    super.key,
    required this.selectedSport,
  });

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();
    final sport =
        player.selectedSport.isNotEmpty ? player.selectedSport : selectedSport;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, player),
              const SizedBox(height: 22),
              _buildStatsRow(player),
              const SizedBox(height: 28),
              Text("Latest opportunities", style: AppTextStyles.heading3),
              const SizedBox(height: 14),
              _buildOpportunities(sport),
              const SizedBox(height: 28),
              Text("Featured scouts", style: AppTextStyles.heading3),
              const SizedBox(height: 14),
              _buildScouts(),
              const SizedBox(height: 28),
              Text("Suggested videos", style: AppTextStyles.heading3),
              const SizedBox(height: 14),
              _buildVideos(sport),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PlayerProvider player) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.card,
                border: Border.all(color: AppColors.blue, width: 2),
                image: player.profileImage != null
                    ? DecorationImage(
                        image: FileImage(player.profileImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: player.profileImage == null
                  ? const Icon(Icons.person, color: AppColors.blue, size: 34)
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back",
                style: AppTextStyles.body.copyWith(color: Colors.white60),
              ),
              const SizedBox(height: 4),
              Text(
                player.playerName.isEmpty ? "Player" : player.playerName,
                style: AppTextStyles.heading3,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            );
          },
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white10),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(PlayerProvider player) {
    return Row(
      children: [
        Expanded(child: _statCard("${player.age}", "Age")),
        const SizedBox(width: 12),
        Expanded(child: _statCard(player.weight, "Weight")),
        const SizedBox(width: 12),
        Expanded(child: _statCard(player.height, "Height")),
      ],
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(color: AppColors.blue),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.body.copyWith(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunities(String sport) {
    final opportunities = [
      {
        "club": "Al Ahly Club",
        "title": "Midfielder needed",
        "meta": "U19 - $sport",
        "color": AppColors.blue,
      },
      {
        "club": "Zamalek SC",
        "title": "Striker trial",
        "meta": "U21 - $sport",
        "color": AppColors.red,
      },
      {
        "club": "Smouha Club",
        "title": "Goalkeeper wanted",
        "meta": "U17 - $sport",
        "color": AppColors.blue,
      },
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: opportunities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final item = opportunities[index];
          final color = item["color"] as Color;
          return Container(
            width: 190,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border(
                left: BorderSide(color: color, width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["club"] as String,
                  style: AppTextStyles.titleSmall.copyWith(color: color),
                ),
                const SizedBox(height: 8),
                Text(
                  item["title"] as String,
                  style: AppTextStyles.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  item["meta"] as String,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildScouts() {
    final scouts = [
      {"name": "M. Adel", "color": AppColors.blue},
      {"name": "S. Karim", "color": AppColors.red},
      {"name": "Y. Hassan", "color": AppColors.blue},
      {"name": "O. Fathy", "color": AppColors.red},
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: scouts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (_, index) {
          final scout = scouts[index];
          final color = scout["color"] as Color;
          return Column(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.card,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(Icons.person, color: color, size: 30),
              ),
              const SizedBox(height: 8),
              Text(
                scout["name"] as String,
                style: AppTextStyles.bodySmall,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVideos(String sport) {
    final videos = [
      {"title": "Karim - shooting drill", "meta": "Basketball - 2:14"},
      {"title": "Omar - match highlights", "meta": "$sport - 4:02"},
    ];

    return Column(
      children: videos.map((video) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1220),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.blue,
                  size: 34,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video["title"] as String,
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video["meta"] as String,
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
