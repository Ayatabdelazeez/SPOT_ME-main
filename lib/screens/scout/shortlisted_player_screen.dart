import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/player_model.dart';
import '../../mock_players.dart';
import 'player_cv_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

////////////////////////////////////**shortlist_state**////////////////////////////////////////////
abstract class ShortlistState extends Equatable {
  const ShortlistState();

  @override
  List<Object?> get props => [];
}

class ShortlistInitial extends ShortlistState {}

class ShortlistLoading extends ShortlistState {}

class ShortlistLoaded extends ShortlistState {
  final List<PlayerModel> players;
  const ShortlistLoaded(this.players);

  @override
  List<Object?> get props => [players];
}

class ShortlistEmpty extends ShortlistState {}


////////////////////////////////////**shortlist_cubit**////////////////////////////////////////////

class ShortlistCubit extends Cubit<ShortlistState> {
  ShortlistCubit() : super(ShortlistInitial());

  List<PlayerModel> _shortlist = [];

  // 1. Load favorite players list
  void loadShortlist(String sport) {
    _updateState();
  }
  // 2. Add a player to the list
  void toggleShortlist(PlayerModel player) {
    final index = _shortlist.indexWhere((p) => p.name == player.name);
    if (index >= 0) {
      _shortlist.removeAt(index);
    } else {
      _shortlist.add(player);
    }
    _updateState();
  }

  bool isShortlisted(PlayerModel player) {
    return _shortlist.any((p) => p.name == player.name);
  }

  void _updateState() {
    if (_shortlist.isEmpty) {
      emit(ShortlistEmpty());
    } else {
      emit(ShortlistLoaded(List.from(_shortlist)));
    }
  }

  // 3. Remove a player from the list
  void removePlayer(PlayerModel player) {
    _shortlist.removeWhere((p) => p.name == player.name);

    if (_shortlist.isEmpty) {
      emit(ShortlistEmpty());
    } else {
      emit(ShortlistLoaded(List.from(_shortlist)));
    }
  }

  // 4. Send an invitation for an immersive experience
  void sendTrialInvite(PlayerModel player) {
  }
}

////////////////////////////////////**shortlisted_players_screen**////////////////////////////////////////////

class ShortlistedPlayersScreen extends StatelessWidget {
  final String selectedSport;

  const ShortlistedPlayersScreen({
    super.key,
    this.selectedSport = "Football",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.card,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.white),
          title: const Text(
            "Shortlisted Players ",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ShortlistCubit, ShortlistState>(
            builder: (context, state) {
              if (state is ShortlistLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.blue),
                );
              }

              if (state is ShortlistEmpty) {
                return _buildEmptyState();
              }

              if (state is ShortlistLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top Summary Banner
                    _buildSummaryHeader(state.players.length),
                    const SizedBox(height: 16),

                    // 2. Shortlisted List
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.players.length,
                        itemBuilder: (context, index) {
                          final player = state.players[index];
                          return _buildShortlistedCard(context, player);
                        },
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
    );
  }

  // --- Header Summary ---
  Widget _buildSummaryHeader(int count) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blue.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.bookmark, color: AppColors.red, size: 22),
              const SizedBox(width: 8),
              Text(
                "Saved Prospects ($count)",
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  // --- Player Card Component ---
  Widget _buildShortlistedCard(BuildContext context, PlayerModel player) {
    final cubit = context.read<ShortlistCubit>();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.blue.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.background,
                    child: Icon(Icons.person, color: AppColors.blue, size: 30),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${player.score}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 12),

              // Player Basic Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${player.position} • ${player.age} yrs",
                      style: const TextStyle(color: AppColors.blue, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      player.club,
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ),

              // Remove Icon Button
              IconButton(
                icon: const Icon(Icons.bookmark_remove, color: AppColors.red, size: 22),
                onPressed: () {
                  cubit.removePlayer(player);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Player removed from Shortlist"),
                      duration: Duration(seconds: 2),
                      backgroundColor: AppColors.red,
                    ),
                  );
                },
                tooltip: "Remove",
              ),
            ],
          ),
          const Divider(color: Colors.white10, height: 16),

          // Bottom Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.blue.withOpacity(0.5)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PlayerCvScreen()),
                    );
                  },
                  icon: const Icon(Icons.visibility_outlined, size: 16, color: AppColors.blue),
                  label: const Text(
                    "View Profile",
                    style: TextStyle(color: AppColors.blue, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _showInviteDialog(context, player),
                  icon: const Icon(Icons.send_rounded, size: 14, color: Colors.white),
                  label: const Text(
                    "Send Trial Invitation",
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // --- Empty State ---
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 60, color: Colors.white24),
          SizedBox(height: 12),
          Text(
            "No shortlisted players yet",
            style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            "Explore talents from Search or Home feed and bookmark them here.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // --- Dialog for Invitation ---
  void _showInviteDialog(BuildContext context, PlayerModel player) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Send Trial to ${player.name}",
          style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to send an official scouting trial invitation to this player?",
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
            onPressed: () {
              context.read<ShortlistCubit>().sendTrialInvite(player);
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Invitation sent to ${player.name}!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Send Invite", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
