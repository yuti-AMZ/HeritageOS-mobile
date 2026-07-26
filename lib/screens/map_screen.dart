import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: AppColors.sand,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 16, color: AppColors.green),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Explore Ethiopia',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: AppColors.sand,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.my_location_rounded,
                            size: 14, color: AppColors.green),
                        SizedBox(width: 4),
                        Text('Nearby',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.green)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Map placeholder
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFFD8E8DC)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Grid lines
                      ...List.generate(
                          18,
                          (i) => Positioned(
                              top: i * 28.0,
                              left: 0,
                              right: 0,
                              child: Container(
                                  height: 0.6,
                                  color: AppColors.green.withOpacity(0.12)))),
                      ...List.generate(
                          22,
                          (i) => Positioned(
                              left: i * 22.0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                  width: 0.6,
                                  color: AppColors.green.withOpacity(0.12)))),

                      // Map pins — Addis Ababa focus
                      Positioned(
                          top: 72,
                          left: 80,
                          child: _pin('Adwa')),
                      Positioned(
                          top: 180,
                          left: 180,
                          child: _pin('NME')),
                      Positioned(
                          top: 140,
                          left: 220,
                          child: _pin('Lucy')),
                      Positioned(
                          top: 250,
                          left: 90,
                          child: _pin('Entoto')),
                      Positioned(
                          top: 220,
                          left: 140,
                          child: _pin('Red Terror')),

                      // Center button
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColors.green,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.green.withOpacity(0.3),
                                      blurRadius: 12)
                                ]),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.navigation_rounded,
                                    size: 16, color: Colors.white),
                                SizedBox(width: 6),
                                Text('Navigate',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Nearby list
            Container(
              margin: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.green.withOpacity(0.08),
                        blurRadius: 12)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('NEARBY PLACES',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold)),
                  const SizedBox(height: 12),
                  _nearbyItem('Adwa Victory Memorial', '1.2 km away', Icons.museum_rounded),
                  _nearbyItem('National Museum (Lucy)', '2.1 km away', Icons.pets_rounded),
                  _nearbyItem('Holy Trinity Cathedral', '3.4 km away', Icons.account_balance_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pin(String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
              color: AppColors.gold,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ]),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green)),
        ),
        const Icon(Icons.location_on, size: 22, color: AppColors.gold),
      ],
    );
  }

  Widget _nearbyItem(String name, String dist, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: AppColors.sand,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 16, color: AppColors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green)),
                Text(dist,
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.green.withOpacity(0.4))),
              ],
            ),
          ),
          Icon(Icons.chevron_right,
              size: 18, color: AppColors.green.withOpacity(0.25)),
        ],
      ),
    );
  }
}
