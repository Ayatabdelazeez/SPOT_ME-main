import 'package:flutter/material.dart';
import '../../utils/app_colors.dart'; 
import 'physical_coach_chat_screen.dart';

class PhysicalCoachScreen extends StatelessWidget {
  const PhysicalCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ===== App Bar =====
            SliverAppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: AppColors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                ' Physical Coach',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),

                  // ===== Hero Card =====
                  _HeroCard(),

                  const SizedBox(height: 24),

                  // ===== Quick Stats Row =====
                  const _SectionTitle(title: 'Quick Look '),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.local_fire_department_rounded,
                          value: '1,240',
                          label: ' Calories Burned',
                          gradient: AppColors.redGradient,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.timer_outlined,
                          value: '5h 20m',
                          label: ' Exercise Time',
                          gradient: AppColors.blueGradient,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ===== Quick Actions Grid =====
                  const _SectionTitle(title: ' Coach Services'),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.05,
                    children: [
                      _ActionCard(
                        icon: Icons.fitness_center_rounded,
                        title: 'Exercise Plan ',
                        subtitle: ' Your Weekly Program',
                        onTap: () {
                        },
                      ),
                      _ActionCard(
                        icon: Icons.restaurant_menu_rounded,
                        title: 'Nutrition',
                        subtitle: ' Nutritional Advoce',
                        onTap: () {
                        },
                      ),
                      _ActionCard(
                        icon: Icons.show_chart_rounded,
                        title: 'Performance Analysis',
                        subtitle: 'Your Progress In Numbers ',
                        onTap: () {},
                      ),
                      _ActionCard(
                        icon: Icons.self_improvement_rounded,
                        title: 'Lengthening & Recovery',
                        subtitle: 'Recovery Exercises',
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ===== Ask the coach (future AI hook) =====
                  const _SectionTitle(title: ' Ask The Coach'),
                  const SizedBox(height: 12),
                  _AskCoachCard(),

                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== Widgets =====================

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.dashboardGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadow,
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.sports_gymnastics_rounded,
                color: AppColors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your Own Coach Is Ready',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Follow Your Plan & Watch Your Progress',
                  style: TextStyle(color: AppColors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Gradient gradient;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.white, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.blue, size: 22),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.grey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _AskCoachCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need Help From Your Coach?',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start chatting with your AI Physical Coach and get personalized workout and nutrition advice.',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PhysicalCoachChatScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.chat_rounded),
              label: const Text("Chat With Coach"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.background,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
