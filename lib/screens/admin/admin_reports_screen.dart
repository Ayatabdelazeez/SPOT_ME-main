import 'package:flutter/material.dart';
import '../../models/player_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  final List<PlayerModel> reportedPlayers = [
    PlayerModel(
      name: "Khaled Ali",
      email: "khaled@test.com",
      phone: "011...",
      sport: "Football",
      position: "Midfielder",
      age: 22,
      height: 175,
      weight: 70,
      score: 85,
      image: "",
      club: "Zamalek",
      experienceYears: 4,
      violationsCount: 1, 
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        iconTheme: const IconThemeData(color: AppColors.white), // for back arrow color 
        title: Text("Fraud Reports", style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: reportedPlayers.isEmpty
          ? const Center(child: Text("No pending reports", style: TextStyle(color: Colors.white54)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reportedPlayers.length,
              itemBuilder: (context, index) {
                final player = reportedPlayers[index];
                return Card(
                  color: AppColors.card,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(player.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text("Reported Reason: Age Discrepancy\nPrevious Violations: ${player.violationsCount}",
                        style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    trailing: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {
                        if (value == 'warning') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Warning & negative review issued to ${player.name}")),
                          );
                        } else if (value == 'block') {
                          setState(() {
                            reportedPlayers.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${player.name} has been BLOCKED"), backgroundColor: AppColors.red),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'warning',
                          child: Row(
                            children: [
                              Icon(Icons.warning, color: Colors.orange, size: 18),
                              SizedBox(width: 8),
                              Text("Issue Warning"),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'block',
                          child: Row(
                            children: [
                              Icon(Icons.block, color: Colors.red, size: 18),
                              SizedBox(width: 8),
                              Text("Block Player"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
