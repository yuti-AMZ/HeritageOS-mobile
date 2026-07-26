import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/place_model.dart';
import 'artifact_screen.dart';
import 'map_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _filter = 'All';
  bool _isMap = false;
  final _filters = ['All', 'Museum', 'Ruins', 'Park', 'Church', 'Castle'];

  final _places = const [
    Place(name: 'Adwa Victory Memorial', location: 'Addis Ababa', type: 'Museum', rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1572905421176-6fa2f11a236e?w=400&h=300&fit=crop'),
    Place(name: 'Rock Churches of Lalibela', location: 'Lalibela', type: 'Church', rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=400&h=300&fit=crop'),
    Place(name: 'Axum Obelisks', location: 'Axum', type: 'Ruins', rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1523805009345-7448845a9e53?w=400&h=300&fit=crop'),
    Place(name: 'National Museum', location: 'Addis Ababa', type: 'Museum', rating: 4.7,
        imageUrl: 'https://images.unsplash.com/photo-1566127444979-b20d8ce2484a?w=400&h=300&fit=crop'),
    Place(name: 'Fasil Ghebbi', location: 'Gondar', type: 'Castle', rating: 4.7,
        imageUrl: 'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=400&h=300&fit=crop'),
    Place(name: 'Simien Mountains', location: 'Debark', type: 'Park', rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=400&h=300&fit=crop'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'All'
        ? _places
        : _places.where((p) => p.type == _filter).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Explore',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.green)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                              color: AppColors.sand,
                              borderRadius: BorderRadius.circular(14)),
                          child: Row(
                            children: [
                              Icon(Icons.search, size: 15, color: AppColors.green.withOpacity(0.33)),
                              const SizedBox(width: 10),
                              Text('Search places, artifacts…',
                                  style: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.28))),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const MapScreen())),
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                              color: _isMap ? AppColors.green : AppColors.sand,
                              borderRadius: BorderRadius.circular(14)),
                          child: Icon(Icons.map_rounded,
                              size: 18,
                              color: _isMap ? Colors.white : AppColors.green),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                            color: AppColors.sand,
                            borderRadius: BorderRadius.circular(14)),
                        child: Icon(Icons.tune_rounded,
                            size: 18, color: AppColors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 32,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final f = _filters[i];
                        final active = _filter == f;
                        return GestureDetector(
                          onTap: () => setState(() => _filter = f),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: active ? AppColors.green : AppColors.sand,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: Text(f,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: active
                                        ? Colors.white
                                        : AppColors.green.withOpacity(0.47))),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 80),
                child: GridView.builder(
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (_, i) => _placeCard(filtered[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeCard(Place place) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ArtifactScreen())),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: AppColors.green.withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 118,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18)),
                  ),
                  child: Image.network(place.imageUrl,
                      width: double.infinity,
                      height: 118,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                ),
                Container(
                  height: 118,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.green.withOpacity(0.6)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star,
                            size: 9, color: AppColors.gold),
                        const SizedBox(width: 2),
                        Text('${place.rating}',
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(place.type,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.name,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 9, color: AppColors.gold),
                        const SizedBox(width: 3),
                        Text(place.location,
                            style: TextStyle(
                                fontSize: 10,
                                color: AppColors.green.withOpacity(0.41))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
