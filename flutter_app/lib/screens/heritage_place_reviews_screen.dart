import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';
import '../models/heritage_place.dart';

class HeritagePlaceReviewsScreen extends StatelessWidget {
  final HeritagePlace place;
  const HeritagePlaceReviewsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final reviews = MockData.reviews;

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
                          const Text('Reviews',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 2),
                          Text('${place.rating} · ${place.reviewCount} reviews',
                              style: const TextStyle(fontSize: 12, color: Colors.white60)),
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
              itemCount: reviews.length,
              itemBuilder: (_, i) {
                final r = reviews[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.sand,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.gold,
                            child: Text(r.userAvatar,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.green)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.userName,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                                Text(_formatDate(r.date),
                                    style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.45))),
                              ],
                            ),
                          ),
                          Row(
                            children: List.generate(5, (j) => Icon(
                                j < r.rating.round() ? Icons.star_rounded : Icons.star_border_rounded,
                                size: 14, color: AppColors.gold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(r.text,
                          style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.green.withOpacity(0.7))),
                      if (r.tip != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lightbulb_rounded, size: 14, color: AppColors.gold),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text('Tip: ${r.tip}',
                                    style: const TextStyle(fontSize: 12, color: AppColors.gold)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
