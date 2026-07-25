import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';

class HeritagePlaceTimelineScreen extends StatelessWidget {
  final HeritagePlace place;
  const HeritagePlaceTimelineScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Timeline & Stories',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 2),
                          Text(place.name, style: const TextStyle(fontSize: 12, color: Colors.white60)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: place.timeline.length,
              itemBuilder: (_, i) {
                final t = place.timeline[i];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 16, height: 16,
                          decoration: BoxDecoration(
                            color: i == 0 || t.year == 'Today' ? AppColors.gold : AppColors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                        if (i < place.timeline.length - 1)
                          Container(width: 2, height: 64, color: AppColors.green.withOpacity(0.2)),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: t.year == 'Today' ? AppColors.gold.withOpacity(0.08) : AppColors.sand,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.year, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.gold)),
                            const SizedBox(height: 4),
                            Text(t.title,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.green)),
                            const SizedBox(height: 4),
                            Text(t.description,
                                style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.green.withOpacity(0.65))),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
