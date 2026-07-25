import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';

class SavedPlacesScreen extends StatelessWidget {
  const SavedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saved = MockData.heritagePlaces.take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: AppColors.green),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Saved Places',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.green)),
                  ),
                ],
              ),
            ),
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _tab('Favorites', true),
                  _tab('Tour History', false),
                  _tab('Bookmarks', false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: saved.length,
                itemBuilder: (_, i) {
                  final place = saved[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.06), blurRadius: 8)],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                          child: SizedBox(
                            width: 100, height: 100,
                            child: Image.network(place.imageUrl, fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(place.name,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 10, color: AppColors.gold),
                                    const SizedBox(width: 3),
                                    Text('${place.city}, ${place.country}',
                                        style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.5))),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.star, size: 12, color: AppColors.gold),
                                    const SizedBox(width: 3),
                                    Text('${place.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.green)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_rounded, color: AppColors.gold, size: 20),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String label, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: active ? AppColors.gold : Colors.transparent, width: 2.5),
          ),
        ),
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: active ? AppColors.green : AppColors.green.withOpacity(0.4))),
      ),
    );
  }
}
