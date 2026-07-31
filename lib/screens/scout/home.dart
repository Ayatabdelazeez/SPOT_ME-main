import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/screens/scout/player_cv_screen.dart';
import 'package:spotme/screens/scout/shortlisted_player_screen.dart';
import 'package:spotme/utils/app_text_styles.dart';
import '../../utils/app_colors.dart';
import '../../models/player_model.dart';
import '../../mock_players.dart';

class Home extends StatefulWidget {
  final String selectedSport;

  const Home({
    super.key,
    required this.selectedSport,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Fetch player data based on the selected sport.
    final players = MockPlayers.bySport(widget.selectedSport);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white), // for back arrow color 
        title: Row(
          children: [
            const Icon(Icons.local_fire_department, color: AppColors.red, size: 22),
            const SizedBox(width: 8),
            Text(
              "${widget.selectedSport} Talent Feed",
              style: AppTextStyles.heading3
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: AppColors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Highlights / Stories Section
            _buildHighlightsSection(players),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "Latest Match Videos & Reels",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 2. Video Feed List 
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return _buildPlayerVideoCard(player);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- 1. Top Highlights Section ---
  Widget _buildHighlightsSection(List<PlayerModel> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Top Daily Clips ",
            style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: players.length,
            itemBuilder: (context, index) {
              final player = players[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.red, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.card,
                        child: Text(
                          player.name.isNotEmpty ? player.name[0] : 'P',
                          style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      player.name.split(' ').first,
                      style: const TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- 2. Player Video Feed Card ---
  Widget _buildPlayerVideoCard(PlayerModel player) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Player Info
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.background,
              child: Text(
                player.name.isNotEmpty ? player.name[0] : 'P',
                style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              player.name,
              style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: Text(
              "${player.position} • ${player.club}",
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.red),
              ),
              child: Text(
                "${player.score}% AI Match",
                style: const TextStyle(color: AppColors.red, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Video Thumbnail Box
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              image: player.image.isNotEmpty
                  ? DecorationImage(image: NetworkImage(player.image), fit: BoxFit.cover)
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.sports_soccer, size: 60, color: Colors.white10),
                
                // Play Button
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.red.withOpacity(0.85),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
                ),

                // Video duration badge
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("1:24", style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                )
              ],
            ),
          ),

          // Action Buttons Footer
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BlocBuilder<ShortlistCubit, ShortlistState>(
                      builder: (context, state) {
                        final cubit = context.read<ShortlistCubit>();
                        final isSaved = cubit.isShortlisted(player);

                        return IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? AppColors.red : AppColors.blue,
                            size: 22,
                          ),
                          onPressed: () {
                            // 1. Updating the state inside the Cubit.
                            cubit.toggleShortlist(player);

                            // 2. Show a confirmation SnackBar
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isSaved
                                      ? "${player.name} removed from Shortlist"
                                      : "${player.name} added to Shortlist!",
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor: isSaved ? AppColors.red : AppColors.blue,
                              ),
                            );
                          },
                          tooltip: "Shortlist Player",
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.send_outlined, color: Colors.white70, size: 20),
                      onPressed: () {},
                      tooltip: "Send Invitation",
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue.withOpacity(0.15),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PlayerCvScreen()),
                    );
                  },
                  child: const Text(
                    "View Profile",
                    style: TextStyle(color: AppColors.blue, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
