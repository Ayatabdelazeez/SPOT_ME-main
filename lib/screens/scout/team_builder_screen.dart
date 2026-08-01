import 'package:flutter/material.dart';

import '../../models/player_model.dart';
import '../../mock_players.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

/// ==========================================================================
/// TEAM BUILDER SCREEN — "Build a balanced squad, not just star players"
/// ==========================================================================
/// The scout picks a formation, taps "Build My Team", and AI Scout returns
/// a full starting XI chosen for position fit, playing style and chemistry
/// between players.
///
/// 🔌 FOR THE AI/BACKEND TEAM:
/// `_buildSquad()` below is the ONLY place that fakes the AI result — it
/// just grabs mock players from MockPlayers and assigns them to formation
/// slots. Replace its body with a real API call that returns a List of
/// `SquadPick` (position + player + matchScore + reason), keeping the same
/// return type so the rest of the screen (pitch view, list, animations)
/// keeps working without changes.
/// ==========================================================================

/// One filled slot in the formation (a position + the player AI picked for it).
class SquadPick {
  final String position; // e.g. "GK", "CB", "ST"
  final Offset pitchPosition; // relative (0..1, 0..1) position on the pitch
  final PlayerModel player;
  final int matchScore; // 0-100, how well this player fits the slot/team
  final String reason; // short AI explanation

  const SquadPick({
    required this.position,
    required this.pitchPosition,
    required this.player,
    required this.matchScore,
    required this.reason,
  });
}

/// A formation preset: name + the slots that need to be filled.
/// Each slot has a position label and a relative pitch coordinate.
class _Formation {
  final String name;
  final List<_FormationSlot> slots;
  const _Formation(this.name, this.slots);
}

class _FormationSlot {
  final String position;
  final Offset pitchPosition; // x,y in 0..1 relative to the pitch box
  const _FormationSlot(this.position, this.pitchPosition);
}

const List<_Formation> _formations = [
  _Formation("4-3-3", [
    _FormationSlot("GK", Offset(0.5, 0.94)),
    _FormationSlot("LB", Offset(0.15, 0.76)),
    _FormationSlot("CB", Offset(0.38, 0.80)),
    _FormationSlot("CB", Offset(0.62, 0.80)),
    _FormationSlot("RB", Offset(0.85, 0.76)),
    _FormationSlot("CM", Offset(0.30, 0.56)),
    _FormationSlot("CM", Offset(0.5, 0.50)),
    _FormationSlot("CM", Offset(0.70, 0.56)),
    _FormationSlot("LW", Offset(0.18, 0.24)),
    _FormationSlot("ST", Offset(0.5, 0.14)),
    _FormationSlot("RW", Offset(0.82, 0.24)),
  ]),
  _Formation("4-4-2", [
    _FormationSlot("GK", Offset(0.5, 0.94)),
    _FormationSlot("LB", Offset(0.15, 0.76)),
    _FormationSlot("CB", Offset(0.38, 0.80)),
    _FormationSlot("CB", Offset(0.62, 0.80)),
    _FormationSlot("RB", Offset(0.85, 0.76)),
    _FormationSlot("LM", Offset(0.15, 0.50)),
    _FormationSlot("CM", Offset(0.40, 0.54)),
    _FormationSlot("CM", Offset(0.60, 0.54)),
    _FormationSlot("RM", Offset(0.85, 0.50)),
    _FormationSlot("ST", Offset(0.38, 0.16)),
    _FormationSlot("ST", Offset(0.62, 0.16)),
  ]),
  _Formation("3-5-2", [
    _FormationSlot("GK", Offset(0.5, 0.94)),
    _FormationSlot("CB", Offset(0.25, 0.80)),
    _FormationSlot("CB", Offset(0.5, 0.82)),
    _FormationSlot("CB", Offset(0.75, 0.80)),
    _FormationSlot("LM", Offset(0.10, 0.54)),
    _FormationSlot("CM", Offset(0.35, 0.52)),
    _FormationSlot("CM", Offset(0.5, 0.58)),
    _FormationSlot("CM", Offset(0.65, 0.52)),
    _FormationSlot("RM", Offset(0.90, 0.54)),
    _FormationSlot("ST", Offset(0.38, 0.16)),
    _FormationSlot("ST", Offset(0.62, 0.16)),
  ]),
];

const List<String> _playingStyles = [
  "Possession",
  "Counter Attack",
  "High Press",
  "Balanced",
];

class TeamBuilderScreen extends StatefulWidget {
  const TeamBuilderScreen({super.key});

  @override
  State<TeamBuilderScreen> createState() => _TeamBuilderScreenState();
}

class _TeamBuilderScreenState extends State<TeamBuilderScreen>
    with TickerProviderStateMixin {
  int _formationIndex = 0;
  int _styleIndex = 3; // "Balanced" by default

  bool _isAnalyzing = false;
  bool _hasResult = false;
  List<SquadPick> _squad = [];

  late final AnimationController _analyzeController;
  late final AnimationController _resultsController;

  @override
  void initState() {
    super.initState();
    _analyzeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _resultsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _analyzeController.dispose();
    _resultsController.dispose();
    super.dispose();
  }

  Future<void> _buildTeam() async {
    setState(() {
      _isAnalyzing = true;
      _hasResult = false;
    });

    // TODO(AI-team): replace this delay + mock logic with a real call to the
    // Team Builder AI endpoint, sending formation + playing style + the
    // scout's available player pool, and receiving back a List<SquadPick>.
    await Future.delayed(const Duration(milliseconds: 1800));
    final squad = _buildSquad(_formations[_formationIndex]);

    if (!mounted) return;
    setState(() {
      _squad = squad;
      _isAnalyzing = false;
      _hasResult = true;
    });
    _resultsController.forward(from: 0);
  }

  /// MOCK squad generation — picks players from MockPlayers per position.
  /// 🔌 Replace this whole method with a real API call (see note above).
  List<SquadPick> _buildSquad(_Formation formation) {
    final pool = List<PlayerModel>.from(MockPlayers.all);
    final used = <String>{};
    final picks = <SquadPick>[];

    for (final slot in formation.slots) {
      // Try to find an unused player whose position roughly matches the slot.
      PlayerModel? chosen;
      for (final p in pool) {
        if (used.contains(p.name)) continue;
        if (_positionMatches(slot.position, p.position)) {
          chosen = p;
          break;
        }
      }
      // Fallback: just grab any unused player so every slot is filled.
      chosen ??= pool.firstWhere(
        (p) => !used.contains(p.name),
        orElse: () => pool.first,
      );
      used.add(chosen.name);

      final score = 78 + (chosen.score % 20); // mock compatibility score
      picks.add(
        SquadPick(
          position: slot.position,
          pitchPosition: slot.pitchPosition,
          player: chosen,
          matchScore: score.clamp(0, 100).toInt(),
          reason: _mockReason(slot.position, _playingStyles[_styleIndex]),
        ),
      );
    }
    return picks;
  }

  bool _positionMatches(String slot, String playerPosition) {
    final p = playerPosition.toLowerCase();
    switch (slot) {
      case "GK":
        return p.contains("goal");
      case "CB":
      case "LB":
      case "RB":
        return p.contains("defen") || p.contains("back");
      case "CM":
      case "LM":
      case "RM":
        return p.contains("mid");
      case "ST":
      case "LW":
      case "RW":
        return p.contains("forward") || p.contains("wing") || p.contains("striker");
      default:
        return false;
    }
  }

  String _mockReason(String position, String style) {
    return "Fits the $position role and suits a $style approach based on recent performance data.";
  }

  double get _teamChemistry {
    if (_squad.isEmpty) return 0;
    final avg = _squad.map((s) => s.matchScore).reduce((a, b) => a + b) /
        _squad.length;
    return avg / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Team Builder"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroCard(),
              const SizedBox(height: 26),
              Text("Choose a Formation", style: AppTextStyles.heading2.copyWith(fontSize: 19)),
              const SizedBox(height: 12),
              _buildFormationSelector(),
              const SizedBox(height: 22),
              Text("Playing Style", style: AppTextStyles.heading2.copyWith(fontSize: 19)),
              const SizedBox(height: 12),
              _buildStyleSelector(),
              const SizedBox(height: 26),
              CustomButton(
                text: _isAnalyzing ? "Analyzing Players..." : "Build My Team",
                icon: Icons.auto_awesome,
                isLoading: _isAnalyzing,
                height: 50,
                onPressed: _isAnalyzing ? null : _buildTeam,
              ),
              const SizedBox(height: 28),
              if (_isAnalyzing) _buildAnalyzingIndicator(),
              if (_hasResult) ...[
                _buildChemistryCard(),
                const SizedBox(height: 22),
                Text("Formation on the Pitch",
                    style: AppTextStyles.heading2.copyWith(fontSize: 19)),
                const SizedBox(height: 12),
                _buildPitch(),
                const SizedBox(height: 26),
                Text("Squad Breakdown",
                    style: AppTextStyles.heading2.copyWith(fontSize: 19)),
                const SizedBox(height: 12),
                _buildSquadList(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Intro banner
  // ---------------------------------------------------------------------
  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: AppColors.dashboardGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
        border: Border.all(color: AppColors.red.withOpacity(.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.red.withOpacity(.15),
            ),
            child: const Icon(Icons.groups_rounded,
                color: AppColors.red, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Build Your Dream Team", style: AppTextStyles.titleMedium),
                const SizedBox(height: 4),
                Text(
                  "AI Scout balances positions, playing style and chemistry — not just star ratings.",
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Formation chips
  // ---------------------------------------------------------------------
  Widget _buildFormationSelector() {
    return Row(
      children: List.generate(_formations.length, (i) {
        final selected = i == _formationIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _formationIndex = i;
                _hasResult = false;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.only(right: i == _formations.length - 1 ? 0 : 10),
              padding: const EdgeInsets.symmetric(vertical: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.blue : AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? AppColors.blue : Colors.white10,
                ),
              ),
              child: Text(
                _formations[i].name,
                style: AppTextStyles.titleLarge.copyWith(
                  color: selected ? Colors.white : Colors.white70,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ---------------------------------------------------------------------
  // Playing-style chips
  // ---------------------------------------------------------------------
  Widget _buildStyleSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(_playingStyles.length, (i) {
        final selected = i == _styleIndex;
        return GestureDetector(
          onTap: () => setState(() => _styleIndex = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.red.withOpacity(.18) : AppColors.card,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: selected ? AppColors.red : Colors.white10,
              ),
            ),
            child: Text(
              _playingStyles[i],
              style: AppTextStyles.titleSmall.copyWith(
                color: selected ? AppColors.red : Colors.white70,
              ),
            ),
          ),
        );
      }),
    );
  }

  // ---------------------------------------------------------------------
  // "Analyzing" animated indicator (radar-style pulsing rings)
  // ---------------------------------------------------------------------
  Widget _buildAnalyzingIndicator() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: AnimatedBuilder(
              animation: _analyzeController,
              builder: (context, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: List.generate(3, (ring) {
                    final t = (_analyzeController.value + ring / 3) % 1.0;
                    return Opacity(
                      opacity: (1 - t).clamp(0.0, 1.0),
                      child: Container(
                        width: 30 + t * 60,
                        height: 30 + t * 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.blue, width: 2),
                        ),
                      ),
                    );
                  })
                    ..add(const Icon(Icons.groups_rounded,
                        color: AppColors.blue, size: 28)),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Text("Matching players to positions...",
              style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Team chemistry score card
  // ---------------------------------------------------------------------
  Widget _buildChemistryCard() {
    return FadeTransition(
      opacity: _resultsController,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.blueGradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppColors.cardShadow,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: _teamChemistry,
                    strokeWidth: 8,
                    backgroundColor: Colors.white24,
                    color: Colors.white,
                  ),
                  Text("${(_teamChemistry * 100).round()}",
                      style: AppTextStyles.heading3),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Team Chemistry Score", style: AppTextStyles.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    "How well this squad fits together as a unit.",
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Simple pitch visualization with player markers
  // ---------------------------------------------------------------------
  Widget _buildPitch() {
    return AspectRatio(
      aspectRatio: 0.72,
      child: FadeTransition(
        opacity: _resultsController,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF0E2318),
            border: Border.all(color: Colors.white12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: _PitchPainter(),
                  ),
                  ...List.generate(_squad.length, (i) {
                    final pick = _squad[i];
                    return AnimatedBuilder(
                      animation: _resultsController,
                      builder: (context, child) {
                        final delay = (i / _squad.length) * 0.6;
                        final t = ((_resultsController.value - delay) / 0.4)
                            .clamp(0.0, 1.0);
                        return Positioned(
                          left: pick.pitchPosition.dx * constraints.maxWidth - 20,
                          top: pick.pitchPosition.dy * constraints.maxHeight - 20,
                          child: Opacity(
                            opacity: t,
                            child: Transform.scale(scale: 0.6 + 0.4 * t, child: child),
                          ),
                        );
                      },
                      child: _PlayerMarker(pick: pick),
                    );
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // List of players with why-they-fit reasoning
  // ---------------------------------------------------------------------
  Widget _buildSquadList() {
    return Column(
      children: List.generate(_squad.length, (i) {
        final pick = _squad[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.cardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(pick.position,
                    style: AppTextStyles.titleSmall.copyWith(color: AppColors.blue)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pick.player.name, style: AppTextStyles.titleLarge),
                    const SizedBox(height: 3),
                    Text(pick.reason, style: AppTextStyles.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("${pick.matchScore}%",
                    style: AppTextStyles.bodySmall.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Small circular marker for a player on the pitch, colored by position role.
class _PlayerMarker extends StatelessWidget {
  final SquadPick pick;
  const _PlayerMarker({required this.pick});

  Color get _color {
    if (pick.position == "GK") return Colors.orange;
    if (["CB", "LB", "RB"].contains(pick.position)) return AppColors.blue;
    if (["CM", "LM", "RM"].contains(pick.position)) return Colors.green;
    return AppColors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(color: _color.withOpacity(.5), blurRadius: 6),
            ],
          ),
          child: Text(
            pick.position,
            style: const TextStyle(
                color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          pick.player.name.split(" ").first,
          style: const TextStyle(color: Colors.white, fontSize: 9),
        ),
      ],
    );
  }
}

/// Draws a simplified football pitch (outline, center circle, boxes).
class _PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Outer boundary.
    canvas.drawRect(
      Rect.fromLTWH(8, 8, size.width - 16, size.height - 16),
      linePaint,
    );

    // Halfway line.
    canvas.drawLine(
      Offset(8, size.height / 2),
      Offset(size.width - 8, size.height / 2),
      linePaint,
    );

    // Center circle.
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.14,
      linePaint,
    );

    // Top & bottom penalty boxes.
    final boxWidth = size.width * 0.5;
    canvas.drawRect(
      Rect.fromLTWH(
          (size.width - boxWidth) / 2, 8, boxWidth, size.height * 0.14),
      linePaint,
    );
    canvas.drawRect(
      Rect.fromLTWH((size.width - boxWidth) / 2,
          size.height - 8 - size.height * 0.14, boxWidth, size.height * 0.14),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
