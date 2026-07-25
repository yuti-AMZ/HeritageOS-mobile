import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';

class HeritagePlaceActivitiesScreen extends StatelessWidget {
  const HeritagePlaceActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      _Activity(icon: Icons.quiz_rounded, title: 'Heritage Quiz', desc: '5 questions about this site', points: 50, color: AppColors.gold),
      _Activity(icon: Icons.lightbulb_rounded, title: 'Fun Facts', desc: 'Discover hidden stories', points: 20, color: AppColors.green),
      _Activity(icon: Icons.emoji_events_rounded, title: 'Scavenger Hunt', desc: 'Find all 8 hidden artifacts', points: 100, color: AppColors.gold),
      _Activity(icon: Icons.photo_camera_rounded, title: 'Photo Challenge', desc: 'Capture 5 exhibit angles', points: 30, color: AppColors.green),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: AppColors.green,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(18)),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Visitor Activities',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Points
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.green, Color(0xFF2A5A44)]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.stars_rounded, color: AppColors.gold, size: 32),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('250 points earned',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            Text('Complete activities to earn more',
                                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6))),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text('Activities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
                  const SizedBox(height: 12),

                  ...activities.map((a) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.sand,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: a.color, borderRadius: BorderRadius.circular(12)),
                          child: Icon(a.icon, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                              const SizedBox(height: 2),
                              Text(a.desc, style: TextStyle(fontSize: 12, color: AppColors.green.withOpacity(0.5))),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: Text('+${a.points}',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.gold)),
                        ),
                      ],
                    ),
                  )),

                  const SizedBox(height: 20),
                  const Text('Achievements', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10, runSpacing: 10,
                    children: MockData.achievements.map((a) => Container(
                      width: (MediaQuery.of(context).size.width - 50) / 3,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: a.isUnlocked ? AppColors.gold.withOpacity(0.1) : AppColors.sand,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: a.isUnlocked ? AppColors.gold : Colors.transparent, width: 1.5),
                      ),
                      child: Column(
                        children: [
                          Text(a.icon, style: TextStyle(fontSize: 28, color: a.isUnlocked ? null : Colors.grey)),
                          const SizedBox(height: 6),
                          Text(a.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: a.isUnlocked ? AppColors.green : Colors.grey)),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Activity {
  final IconData icon;
  final String title;
  final String desc;
  final int points;
  final Color color;
  _Activity({required this.icon, required this.title, required this.desc, required this.points, required this.color});
}
