import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              Container(
                height: 260,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1763734546247-83a8792bf0eb?w=800&h=500&fit=crop'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 260,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: const [0, 0.6, 1],
                  ),
                ),
              ),
              Positioned(
                top: 54,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(18)),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 16),
                  ),
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EGYPTIAN ANTIQUITIES',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold)),
                    SizedBox(height: 4),
                    Text('Tour of the Met',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats
                  Row(
                    children: [
                      _stat(Icons.access_time, '2.5 hrs'),
                      _stat(Icons.route_rounded, '3.2 km'),
                      _stat(Icons.place_rounded, '12 stops'),
                      _stat(Icons.star_rounded, '4.9'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text('About This Tour',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.green)),
                  const SizedBox(height: 8),
                  Text(
                    'Explore the Met\'s world-renowned Egyptian collection with an AI-powered guide. From the Temple of Dendur to the iconicRosetta Stone replica, this tour covers 3,000 years of ancient Egyptian civilization.',
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: AppColors.green.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 24),

                  const Text('Tour Highlights',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.green)),
                  const SizedBox(height: 12),
                  ..._highlights.map((h) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.sand,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Icon(h.$1, size: 18, color: AppColors.gold),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(h.$2,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.green)),
                                  Text(h.$3,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.green
                                              .withOpacity(0.44))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),

          // Start button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Start Tour'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.sand, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, size: 16, color: AppColors.gold),
            const SizedBox(height: 4),
            Text(text,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.green)),
          ],
        ),
      ),
    );
  }

  static const _highlights = [
    (Icons.account_balance_rounded, 'Temple of Dendur',
        'Ancient Egyptian temple gifted by Egypt to the US'),
    (Icons.history_edu_rounded, 'Rosetta Stone Replica',
        'See the key to deciphering hieroglyphs'),
    (Icons.museum_rounded, 'King Tut\'s Mask',
        'Iconic gold burial mask of Tutankhamun'),
    (Icons.landscape_rounded, 'Mummy Chamber',
        'Explore 3,000-year-old preserved remains'),
  ];
}
