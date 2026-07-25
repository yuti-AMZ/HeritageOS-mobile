import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';

class HeritagePlaceNearbyScreen extends StatelessWidget {
  final HeritagePlace place;
  const HeritagePlaceNearbyScreen({super.key, required this.place});

  final _nearby = const [
    {'name': 'National Museum', 'type': 'Museum', 'dist': '0.5 km', 'icon': Icons.museum_rounded},
    {'name': 'St. George Cathedral', 'type': 'Historical', 'dist': '1.2 km', 'icon': Icons.account_balance_rounded},
    {'name': 'Mercato Market', 'type': 'Cultural', 'dist': '1.8 km', 'icon': Icons.store_rounded},
    {'name': 'Unity Park', 'type': 'Park', 'dist': '2.1 km', 'icon': Icons.park_rounded},
    {'name': 'Entoto Hill', 'type': 'Natural', 'dist': '5.3 km', 'icon': Icons.landscape_rounded},
    {'name': 'Ghibe Coffee Ceremony', 'type': 'Café', 'dist': '0.8 km', 'icon': Icons.coffee_rounded},
  ];

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
                    const Expanded(
                      child: Text('Nearby Attractions',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _nearby.length,
              itemBuilder: (_, i) {
                final item = _nearby[i];
                return Container(
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
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Icon(item['icon'] as IconData, size: 20, color: AppColors.gold),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'] as String,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                            const SizedBox(height: 2),
                            Text('${item['type']} · ${item['dist']}',
                                style: TextStyle(fontSize: 12, color: AppColors.green.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.green, size: 20),
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
}
