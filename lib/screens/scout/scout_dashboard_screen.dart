import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/screens/scout/player_cv_screen.dart';
import 'package:spotme/screens/scout/shortlisted_player_screen.dart';
import '../../models/player_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import 'recommended_players_screen.dart';
import 'scout_notifications_screen.dart';
//import '../../widgets/custom_card.dart';
//import '../../widgets/custom_button.dart';

////////////////////////////////////**scout_dashboard_states**////////////////////////////////////////////
abstract class ScoutDashboardState {}

class ScoutDashboardInitial extends ScoutDashboardState {}
class ScoutDashboardLoading extends ScoutDashboardState {}
class ScoutDashboardSuccess extends ScoutDashboardState {
  final List<PlayerModel> recommendedPlayers;
  final List<PlayerModel> recentPlayers;

  ScoutDashboardSuccess({
    required this.recommendedPlayers,
    required this.recentPlayers,
  });
}
class ScoutDashboardError extends ScoutDashboardState {
  final String message;
  ScoutDashboardError(this.message);
}

class ScoutDashboardCubit extends Cubit<ScoutDashboardState> {
  ScoutDashboardCubit() : super(ScoutDashboardInitial());

  void fetchDashboardData() async {
    emit(ScoutDashboardLoading());

    // Simulated Delay for API/Firebase
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // Mock Data (Fake API Response)
      final recommended = [
        PlayerModel(name: 'Ahmed Ali', sport: 'Football', position: 'ST',  age: 18, score: 96, email: '', phone: '', height: 160, weight: 60, image: '', club: '', experienceYears: 0),
        PlayerModel(name: 'Youssef Hassan', sport: 'Basketball', position: 'PG', age: 17, score: 91, email: '', phone: '', height: 170, weight: 70, image: '', club: '', experienceYears: 0),
        PlayerModel(name: 'Omar Khaled', sport: 'Handball', position: 'LW', age: 19, score: 88, email: '', phone: '', height: 180, weight: 80, image: '', club: '', experienceYears: 0),
      ];

      final recent = [
        PlayerModel(name: 'Mohamed Sayed', sport: 'Football', position: 'CM', age: 18, score: 82, email: '', phone: '', height: 0, weight: 0, image: '', club: '', experienceYears: 0),
        PlayerModel(name: 'Kareem Tarek', sport: 'Basketball', position: 'SG', age: 16, score: 79, email: '', phone: '', height: 0, weight: 0, image: '', club: '', experienceYears: 0),
        PlayerModel(name: 'Hamza Ibrahim', sport: 'Handball', position: 'GK', age: 20, score: 85, email: '', phone: '', height: 0, weight: 0, image: '', club: '', experienceYears: 0),
      ];

      emit(ScoutDashboardSuccess(recommendedPlayers: recommended, recentPlayers: recent));
    } catch (e) {
      emit(ScoutDashboardError("Failed to load dashboard data"));
    }
  }
}
////////////////////////////////////**state_card**////////////////////////////////////////////

// 4 cards (Total Players , Shortlisted , Invitations Sent , Trials Booked)
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;
  final VoidCallback? onTap;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accentColor.withOpacity(0.2), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accentColor, size: 26),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
// AI Recommended cards
class RecommendedPlayerCard extends StatelessWidget {
  final PlayerModel player;

  const RecommendedPlayerCard({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.red.withOpacity(0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.background,
            child: Icon(Icons.person, color: AppColors.blue, size: 32),
          ),
          const SizedBox(height: 8),
          Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text("${player.position} • ${player.age}y ", style: const TextStyle(fontSize: 11, color: Colors.white70)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${player.score}% AI Match",
              style: const TextStyle(fontSize: 10, color: AppColors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

//Recent Joined Players cards
class RecentPlayerTile extends StatelessWidget {
  final PlayerModel player;

  const RecentPlayerTile({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.background,
          child: Icon(
            player.sport == 'Basketball'
                ? Icons.sports_basketball
                : player.sport == 'Handball'
                    ? Icons.sports_handball
                    : Icons.sports_soccer,
            color: AppColors.red,
            size: 20,
          ),
        ),
        title: Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
        subtitle: Text("${player.sport} • ${player.position}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white70),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const PlayerCvScreen(),
            ),
          );        
        },
      ),
    );
  }
}

////////////////////////////////////**scout_dashboard**////////////////////////////////////////////

class ScoutDashboardScreen extends StatelessWidget {
  final String selectedSport;
  const ScoutDashboardScreen({
    super.key,
    this.selectedSport = "Football",
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoutDashboardCubit()..fetchDashboardData(),
      child:Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.card,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.white), // for back arrow color 
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome back", style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white70,
              ),),
              Text("Ahly Club Scout", style: AppTextStyles.heading3,),
            ],
          ),
                   actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ScoutNotificationsScreen(),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BlocBuilder<ScoutDashboardCubit, ScoutDashboardState>(
          builder: (context, state) {
            if (state is ScoutDashboardLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.red));
            } else if (state is ScoutDashboardSuccess) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Metrics Row 1
                    Row(
                      children: [
                        Expanded(child: StatCard(title: "Total $selectedSport Players", value: "1,240", icon: Icons.people_outline, accentColor: AppColors.blue)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: "Shortlisted",
                            value: "32",
                            icon: Icons.bookmark,
                            accentColor: AppColors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShortlistedPlayersScreen(),
                                ),
                              );
                            },
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Metrics Row 2
                    Row(
                      children: const [
                        Expanded(child: StatCard(title: "Invitations Sent", value: "18", icon: Icons.send_outlined, accentColor: AppColors.blue)),
                        SizedBox(width: 12),
                        Expanded(child: StatCard(title: "Trials Booked", value: "5", icon: Icons.event_available_outlined, accentColor: AppColors.red)),
                      ],
                    ),

                    const SizedBox(height: 28),

/////////////////// AI Recommended Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("AI Recommended $selectedSport players", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecommendedPlayersScreen(selectedSport: selectedSport,isFromDashboard: true,),
                              ),
                            );
                          },
                          child: const Text("See All", style: TextStyle(color: AppColors.blue)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.recommendedPlayers.length,
                        itemBuilder: (context, index) {
                          return RecommendedPlayerCard(player: state.recommendedPlayers[index]);
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

/////////////////// Recent Players Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Recent Joined Players", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.recentPlayers.length,
                      itemBuilder: (context, index) {
                        return RecentPlayerTile(player: state.recentPlayers[index]);
                      },
                    ),
                  ],
                ),
              );
            } else if (state is ScoutDashboardError) {
              return Center(child: Text(state.message, style: const TextStyle(color: AppColors.red)));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
