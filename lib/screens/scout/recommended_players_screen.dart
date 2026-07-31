import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_card.dart';
import 'player_cv_screen.dart';

/// Lightweight display model for a player returned by the SpotMe chatbot
/// backend's /api/search endpoint (data/players.json on the server side).
class _ApiPlayer {
  final String name;
  final String sport;
  final String position;
  final String club;
  final int age;
  final num aiScore;

  _ApiPlayer({
    required this.name,
    required this.sport,
    required this.position,
    required this.club,
    required this.age,
    required this.aiScore,
  });

  factory _ApiPlayer.fromJson(Map<String, dynamic> json) {
    return _ApiPlayer(
      name: json["name"]?.toString() ?? "Unknown",
      sport: json["sport"]?.toString() ?? "-",
      position: json["position"]?.toString() ?? "-",
      club: json["current_club"]?.toString() ?? "-",
      age: (json["age"] as num?)?.toInt() ?? 0,
      aiScore: (json["ai_score"] as num?) ?? 0,
    );
  }
}

class RecommendedPlayersScreen extends StatefulWidget {
  final String selectedSport;
  final bool isFromDashboard;

  const RecommendedPlayersScreen({
    super.key,
    this.selectedSport = "Football",
    this.isFromDashboard = false,
  });

  @override
  State<RecommendedPlayersScreen> createState() =>
      _RecommendedPlayersScreenState();
}

class _RecommendedPlayersScreenState extends State<RecommendedPlayersScreen> {
  // SpotMe chatbot backend (FastAPI on Vercel) — same one used by AI Coach.
  static const String _searchUrl =
      "https://chat-bot-spot-me-drab.vercel.app/api/search";

  bool _isLoading = true;
  String? _error;
  List<_ApiPlayer> _players = [];

  @override
  void initState() {
    super.initState();
    _loadTop10();
  }

  Future<void> _loadTop10() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http
          .post(
            Uri.parse(_searchUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "sport": widget.selectedSport,
              "sort_by": "ai_score",
              "order": "desc",
              "limit": 10,
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        throw Exception("Server error (${response.statusCode})");
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final playersJson = (data["players"] as List?) ?? [];

      if (!mounted) return;
      setState(() {
        _players = playersJson
            .map((p) => _ApiPlayer.fromJson(p as Map<String, dynamic>))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = "Couldn't load recommendations. Check your connection.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: widget.isFromDashboard,
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: Text(
          "Recommended Players",
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadTop10,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    "Top 10 AI Recommendations",
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Highest-rated ${widget.selectedSport} players by AI Score.",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 25),
                  if (_error != null)
                    Text(
                      _error!,
                      style: AppTextStyles.body.copyWith(color: AppColors.red),
                    )
                  else if (_players.isEmpty)
                    Text(
                      "No ${widget.selectedSport} players found.",
                      style: AppTextStyles.body.copyWith(color: Colors.white70),
                    )
                  else
                    ..._players.map(
                      (player) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CustomCard(
                          title: player.name,
                          subtitle:
                              "${player.sport} • ${player.position} • ${player.club} • AI Score: ${player.aiScore}",
                          icon: Icons.star,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PlayerCvScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
