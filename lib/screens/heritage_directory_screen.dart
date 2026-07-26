import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';
import '../providers/heritage_provider.dart';
import 'heritage_place_screen.dart';

class HeritageDirectoryScreen extends ConsumerStatefulWidget {
  const HeritageDirectoryScreen({super.key});
  @override
  ConsumerState<HeritageDirectoryScreen> createState() => _HeritageDirectoryScreenState();
}

class _HeritageDirectoryScreenState extends ConsumerState<HeritageDirectoryScreen> {
  String _selectedCategory = 'All';
  String _selectedCity = 'All';
  final _searchController = TextEditingController();

  final _categories = ['All', 'Museum', 'Archaeological Site', 'Historical Monument', 'Natural Heritage'];
  final _cities = ['All', 'Addis Ababa', 'Lalibela', 'Axum', 'Gondar', 'Harar', 'Debark', 'Tiya'];

  @override
  Widget build(BuildContext context) {
    final allPlaces = ref.watch(allPlacesProvider);

    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.green,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Heritage Directory',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                      allPlaces.when(
                        data: (places) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(10)),
                          child: Text('${places.length} sites',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.green)),
                        ),
                        loading: () => const SizedBox(width: 60, height: 20),
                        error: (_, __) => const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Colors.white.withOpacity(0.65)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search by name, city, or country…',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.45)),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final cat = _categories[i];
                  final active = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: active ? AppColors.green : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(cat,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active ? Colors.white : AppColors.green.withOpacity(0.7))),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                itemCount: _cities.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (_, i) {
                  final city = _cities[i];
                  final active = _selectedCity == city;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCity = city),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: active ? AppColors.gold : AppColors.sand,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(city,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: active ? AppColors.green : AppColors.green.withOpacity(0.6))),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: allPlaces.when(
                data: (places) {
                  final filtered = places.where((p) {
                    final matchCategory = _selectedCategory == 'All' || p.category == _selectedCategory;
                    final matchCity = _selectedCity == 'All' || p.city == _selectedCity;
                    final matchSearch = _searchController.text.isEmpty ||
                        p.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                        p.city.toLowerCase().contains(_searchController.text.toLowerCase());
                    return matchCategory && matchCity && matchSearch;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 48, color: AppColors.green.withOpacity(0.3)),
                          const SizedBox(height: 12),
                          Text('No heritage sites found',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.green.withOpacity(0.5))),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => _placeCard(filtered[i]),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeCard(HeritagePlace place) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => HeritagePlaceScreen(place: place))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 3))],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: Image.network(place.imageUrl, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                  ),
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.6)]),
                  ),
                ),
                Positioned(
                  top: 12, left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(8)),
                    child: Text(place.category,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.green)),
                  ),
                ),
                Positioned(
                  top: 12, right: 12,
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: AppColors.gold),
                      const SizedBox(width: 3),
                      Text('${place.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 12, left: 12, right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place.name,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12, color: AppColors.gold),
                          const SizedBox(width: 4),
                          Text('${place.city}, ${place.country}',
                              style: const TextStyle(fontSize: 12, color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  _infoChip(Icons.access_time, place.openingHours.split('(').first.trim()),
                  const SizedBox(width: 10),
                  _infoChip(Icons.confirmation_number_outlined, place.ticketInfo.split('|').first.trim()),
                  const Spacer(),
                  Icon(Icons.chevron_right, color: AppColors.green.withOpacity(0.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Icon(icon, size: 12, color: AppColors.gold),
            const SizedBox(width: 4),
            Expanded(
              child: Text(text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 9, color: AppColors.green.withOpacity(0.7))),
            ),
          ],
        ),
      ),
    );
  }
}
