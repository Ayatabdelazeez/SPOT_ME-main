import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

class PerformanceGraphsScreen extends StatelessWidget {
  const PerformanceGraphsScreen({super.key});

  Widget buildSkillCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(.05),
        ),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: iconColor.withOpacity(.15),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: iconColor,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChartCard({
    required Widget child,
  }) {
    return Container(
      height: 285,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(.05),
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(
        title: "Performance Graphs",
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "AI Performance Overview",
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),

            Text(
              "Analyze your skills and monitor every improvement in real time.",
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 28),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                gradient: AppColors.dashboardGradient,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: Colors.white.withOpacity(.06),
                ),
                boxShadow: AppColors.cardShadow,
              ),

              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Overall AI Rating",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: SizedBox(
                      width: 195,
                      height: 195,

                      child: Stack(
                        alignment: Alignment.center,

                        children: [

                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0,
                              end: .89,
                            ),
                            duration: const Duration(
                              milliseconds: 1200,
                            ),
                            builder: (context, value, child) {
                              return ShaderMask(
                                shaderCallback: (rect) {
                                  return AppColors.primaryGradient
                                      .createShader(rect);
                                },
                                child: CircularProgressIndicator(
                                  value: value,
                                  strokeWidth: 14,
                                  backgroundColor: Colors.white10,
                                  valueColor:
                                      const AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),

                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [

                              Text(
                                "89",
                                style:
                                    AppTextStyles.heading1.copyWith(
                                  fontSize: 46,
                                ),
                              ),

                              Text(
                                "/100",
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.white70,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.red.withOpacity(.15),
                                  borderRadius:
                                      BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  "Excellent",
                                  style: TextStyle(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),
                        Text(
              "Skills Analysis",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 18),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.05,
              children: [

                buildSkillCard(
                  icon: Icons.speed,
                  title: "Speed",
                  value: "92%",
                  iconColor: AppColors.blue,
                ),

                buildSkillCard(
                  icon: Icons.sports_soccer,
                  title: "Accuracy",
                  value: "87%",
                  iconColor: AppColors.red,
                ),

                buildSkillCard(
                  icon: Icons.flash_on,
                  title: "Reaction",
                  value: "91%",
                  iconColor: AppColors.blue,
                ),

                buildSkillCard(
                  icon: Icons.psychology,
                  title: "Decision",
                  value: "95%",
                  iconColor: AppColors.red,
                ),
              ],
            ),

            const SizedBox(height: 38),

            Text(
              "Performance Trend",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 16),

            buildChartCard(
              child: LineChart(
                LineChartData(
                  minY: 50,
                  maxY: 100,

                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white10,
                        strokeWidth: 1,
                      );
                    },
                  ),

                  borderData: FlBorderData(show: false),

                  titlesData: const FlTitlesData(
                    show: false,
                  ),

                  lineBarsData: [

                    LineChartBarData(
                      spots: const [

                        FlSpot(0,70),
                        FlSpot(1,74),
                        FlSpot(2,79),
                        FlSpot(3,84),
                        FlSpot(4,89),
                        FlSpot(5,94),

                      ],

                      isCurved: true,
                      isStrokeCapRound: true,
                      barWidth: 6,

                      gradient: AppColors.primaryGradient,

                      dotData: FlDotData(
                        show: true,
                        getDotPainter:
                            (spot, percent, barData, index) {

                          return FlDotCirclePainter(
                            radius: 5,
                            color: AppColors.red,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),

                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [

                            AppColors.blue.withOpacity(.25),

                            AppColors.red.withOpacity(.05),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 38),

            Text(
              "Skills Comparison",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 16),

            buildChartCard(
              child: BarChart(
                BarChartData(

                  maxY: 100,

                  gridData: const FlGridData(
                    show: false,
                  ),

                  borderData: FlBorderData(
                    show: false,
                  ),

                  titlesData: FlTitlesData(

                    leftTitles: const AxisTitles(),

                    rightTitles: const AxisTitles(),

                    topTitles: const AxisTitles(),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,

                        getTitlesWidget: (value, meta) {

                          switch (value.toInt()) {

                            case 0:
                              return const Text(
                                "SPD",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              );

                            case 1:
                              return const Text(
                                "ACC",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              );

                            case 2:
                              return const Text(
                                "REA",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              );

                            case 3:
                              return const Text(
                                "DEC",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ),

                  barGroups: [

                    buildBar(0,92),

                    buildBar(1,87),

                    buildBar(2,91),

                    buildBar(3,95),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),
                        Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withOpacity(.05),
                ),
                boxShadow: AppColors.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        "AI Coach Summary",
                        style: AppTextStyles.heading3,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "• Your overall performance improved by 12% compared to last month.\n\n"
                    "• Speed and reaction time remain your strongest skills.\n\n"
                    "• Decision making is consistently excellent during matches.\n\n"
                    "• Focus on finishing accuracy and composure under pressure to push your AI Rating above 92.",

                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  BarChartGroupData buildBar(int x, double value) {
    final bool redBar = x.isEven;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 26,
          borderRadius: BorderRadius.circular(10),

          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: Colors.white10,
          ),

          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: redBar
                ? [
                    AppColors.red,
                    const Color(0xFFFF5A7E),
                  ]
                : [
                    AppColors.blue,
                    const Color(0xFF56B3FF),
                  ],
          ),
        ),
      ],
    );
  }
}