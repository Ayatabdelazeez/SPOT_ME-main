import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import 'ai_chat_screen.dart';

/// ==========================================================================
/// AI SCOUT SCREEN — "AI Scout ومدرب خاص متابع تقدمك"
/// ==========================================================================
/// This screen shows the player a personalized development plan generated
/// by AI: detected weak points, a weekly training plan, and suggested
/// educational videos.
///
/// 🔌 FOR THE AI/BACKEND TEAM:
/// All data below (weakPoints, weeklyPlan, suggestedVideos) is MOCK DATA.
/// Replace the three lists with the real response from the AI analysis
/// endpoint. The UI (cards, animations, progress bars) is already wired to
/// whatever shape of data you plug in — just keep the same field names used
/// in the small model classes below, or map your API response into them.
/// ==========================================================================

/// A single weak point detected by the AI analysis (e.g. "Weak Foot: 42%").
class WeakPoint {
  final String title;
  final IconData icon;
  final double score; // 0.0 -> 1.0 (how strong the player currently is)

  const WeakPoint({
    required this.title,
    required this.icon,
    required this.score,
  });
}

/// A single exercise inside the weekly training plan.
class PlanExercise {
  final String day;
  final String title;
  final String duration;
  final String difficulty;
  final IconData icon;

  const PlanExercise({
    required this.day,
    required this.title,
    required this.duration,
    required this.difficulty,
    required this.icon,
  });
}

/// A single suggested educational video.
class SuggestedVideo {
  final String title;
  final String duration;
  final IconData icon;

  const SuggestedVideo({
    required this.title,
    required this.duration,
    required this.icon,
  });
}

// TODO(AI-team): replace with real AI analysis result.
const List<WeakPoint> _mockWeakPoints = [
  WeakPoint(title: "Weak Foot Finishing", icon: Icons.sports_soccer, score: 0.42),
  WeakPoint(title: "Stamina Under Pressure", icon: Icons.favorite, score: 0.58),
  WeakPoint(title: "Passing Accuracy", icon: Icons.share, score: 0.67),
];

// TODO(AI-team): replace with the real weekly plan generated per player.
const List<PlanExercise> _mockWeeklyPlan = [
  PlanExercise(
    day: "Mon",
    title: "Weak Foot Finishing Drills",
    duration: "25 min",
    difficulty: "Medium",
    icon: Icons.sports_soccer,
  ),
  PlanExercise(
    day: "Tue",
    title: "Interval Stamina Run",
    duration: "30 min",
    difficulty: "Hard",
    icon: Icons.directions_run,
  ),
  PlanExercise(
    day: "Thu",
    title: "Short Passing Accuracy Grid",
    duration: "20 min",
    difficulty: "Easy",
    icon: Icons.share,
  ),
  PlanExercise(
    day: "Sat",
    title: "Match Simulation & Decision Making",
    duration: "40 min",
    difficulty: "Hard",
    icon: Icons.psychology,
  ),
];

// TODO(AI-team): replace with real video recommendations (id/url/thumbnail).
const List<SuggestedVideo> _mockVideos = [
  SuggestedVideo(title: "Fixing Your Weak Foot", duration: "8:12", icon: Icons.play_circle_fill),
  SuggestedVideo(title: "Stamina Building Basics", duration: "12:40", icon: Icons.play_circle_fill),
  SuggestedVideo(title: "Passing Like a Pro", duration: "6:55", icon: Icons.play_circle_fill),
];

class AiScoutScreen extends StatefulWidget {
  const AiScoutScreen({super.key});

  @override
  State<AiScoutScreen> createState() => _AiScoutScreenState();
}

class _AiScoutScreenState extends State<AiScoutScreen>
    with TickerProviderStateMixin {
  // Controls the staggered fade + slide entrance animation of every section.
  late final AnimationController _entranceController;

  // Controls the circular "readiness score" filling up on screen open.
  late final AnimationController _scoreController;
  late final Animation<double> _scoreAnimation;

  // Keeps track of which weekly-plan exercises the player marked as done.
  // (Local UI state only — wire this up to the backend when ready.)
  final Set<int> _completedExercises = {};

  static const double _readinessScore = 0.74;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _scoreAnimation = Tween<double>(begin: 0, end: _readinessScore).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.easeOutCubic),
    );
    _scoreController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  /// Returns a fade+slide animation for the [index]-th section, staggered
  /// so sections appear one after another instead of all at once.
  Animation<Offset> _slideFor(int index) {
    final start = (index * 0.12).clamp(0.0, 1.0);
    final end = (start + 0.5).clamp(0.0, 1.0);
    return Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  Animation<double> _fadeFor(int index) {
    final start = (index * 0.12).clamp(0.0, 1.0);
    final end = (start + 0.5).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _entranceController,
      curve: Interval(start, end, curve: Curves.easeOut),
    );
  }

  Widget _animatedSection({required int index, required Widget child}) {
    return FadeTransition(
      opacity: _fadeFor(index),
      child: SlideTransition(position: _slideFor(index), child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "AI Scout"),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AiChatScreen()),
          );
        },
        icon: const Icon(Icons.smart_toy_outlined, color: Colors.white),
        label: Text("Ask AI Scout", style: AppTextStyles.button),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _animatedSection(index: 0, child: _buildHeaderCard()),
              const SizedBox(height: 28),
              _animatedSection(index: 1, child: _buildSectionTitle(
                "Detected Weak Points",
                "AI Scout picked these up from your last analysis",
              )),
              const SizedBox(height: 14),
              _animatedSection(index: 1, child: _buildWeakPointsList()),
              const SizedBox(height: 28),
              _animatedSection(index: 2, child: _buildSectionTitle(
                "Your Weekly Plan",
                "A personal training plan built around your weak points",
              )),
              const SizedBox(height: 14),
              _animatedSection(index: 2, child: _buildWeeklyPlan()),
              const SizedBox(height: 28),
              _animatedSection(index: 3, child: _buildSectionTitle(
                "Suggested Videos",
                "Short lessons picked for your development plan",
              )),
              const SizedBox(height: 14),
              _animatedSection(index: 3, child: _buildVideosList()),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Header: gradient card with an animated circular "readiness score"
  // ---------------------------------------------------------------------
  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.dashboardGradient,
        borderRadius: BorderRadius.circular(26),
        boxShadow: AppColors.cardShadow,
        border: Border.all(color: AppColors.blue.withOpacity(.25)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue.withOpacity(.15),
            ),
            child: const Icon(Icons.emoji_events_outlined,
                color: AppColors.blue, size: 32),
          ),
          const SizedBox(height: 14),
          Text("Your Personal Development Plan",
              textAlign: TextAlign.center, style: AppTextStyles.titleMedium),
          const SizedBox(height: 4),
          Text(
            "AI Scout is tracking your progress like a private coach",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _scoreAnimation,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: CircularProgressIndicator(
                      value: _scoreAnimation.value,
                      strokeWidth: 12,
                      backgroundColor: Colors.white12,
                      color: AppColors.blue,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${(_scoreAnimation.value * 100).round()}%",
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: 36,
                          color: AppColors.blue,
                        ),
                      ),
                      Text("Readiness", style: AppTextStyles.bodySmall),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading2.copyWith(fontSize: 19)),
        const SizedBox(height: 4),
        Text(subtitle, style: AppTextStyles.bodySmall),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Weak points: horizontal progress cards
  // ---------------------------------------------------------------------
  Widget _buildWeakPointsList() {
    return Column(
      children: _mockWeakPoints.map((point) {
        final percent = (point.score * 100).round();
        final color = point.score < 0.5
            ? AppColors.red
            : (point.score < 0.7 ? Colors.orange : Colors.green);
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: point.score),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppColors.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(point.icon, color: color, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(point.title,
                            style: AppTextStyles.titleLarge),
                      ),
                      Text("$percent%",
                          style: AppTextStyles.titleLarge
                              .copyWith(color: color)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      backgroundColor: Colors.white12,
                      color: color,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // ---------------------------------------------------------------------
  // Weekly plan: list of exercise cards with a "mark as done" checkbox
  // ---------------------------------------------------------------------
  Widget _buildWeeklyPlan() {
    return Column(
      children: List.generate(_mockWeeklyPlan.length, (i) {
        final exercise = _mockWeeklyPlan[i];
        final isDone = _completedExercises.contains(i);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDone
                  ? Colors.green.withOpacity(.5)
                  : Colors.white10,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(exercise.day,
                        style: AppTextStyles.titleSmall
                            .copyWith(color: AppColors.blue)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.title,
                      style: AppTextStyles.titleLarge.copyWith(
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: isDone ? Colors.white54 : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            size: 13, color: Colors.white54),
                        const SizedBox(width: 4),
                        Text(exercise.duration,
                            style: AppTextStyles.bodySmall),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            exercise.difficulty,
                            style: AppTextStyles.bodySmall
                                .copyWith(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (isDone) {
                      _completedExercises.remove(i);
                    } else {
                      _completedExercises.add(i);
                    }
                  });
                },
                icon: Icon(
                  isDone
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isDone ? Colors.green : Colors.white38,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ---------------------------------------------------------------------
  // Suggested videos: horizontal scroll of video cards
  // ---------------------------------------------------------------------
  Widget _buildVideosList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _mockVideos.length,
        itemBuilder: (context, index) {
          final video = _mockVideos[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            child: Material(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  // TODO(AI-team): open real video (player/url) here.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Opening: ${video.title}")),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: AppColors.blueGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(video.icon,
                            color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleSmall,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.play_arrow,
                              size: 13, color: Colors.white54),
                          const SizedBox(width: 2),
                          Text(video.duration,
                              style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
