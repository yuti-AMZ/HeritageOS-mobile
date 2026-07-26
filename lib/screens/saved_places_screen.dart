import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../providers/heritage_provider.dart';
import 'heritage_place_screen.dart';

class SavedPlacesScreen extends ConsumerStatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  ConsumerState<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends ConsumerState<SavedPlacesScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final savedPlacesAsync = ref.watch(savedPlacesProvider);

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _tab('Favorites', 0),
                  _tab('Tour History', 1),
                  _tab('Bookmarks', 2),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _selectedTab == 0
                  ? savedPlacesAsync.when(
                      data: (places) => places.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bookmark_border_rounded, size: 48, color: AppColors.green.withOpacity(0.3)),
                                  const SizedBox(height: 12),
                                  Text('No saved places yet',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.green.withOpacity(0.5))),
                                  const SizedBox(height: 8),
                                  Text('Tap the bookmark icon on any heritage site to save it here.',
                                      style: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.4)),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: places.length,
                              itemBuilder: (_, i) {
                                final place = places[i];
                                return GestureDetector(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => HeritagePlaceScreen(place: place))),
                                  child: Container(
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
                                                    const Icon(Icons.star, size: 12, color: AppColors.gold),
                                                    const SizedBox(width: 3),
                                                    Text('${place.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.green)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ref.read(savedPlaceIdsProvider.notifier).update(
                                              (ids) => ids.where((id) => id != place.id).toList(),
                                            );
                                          },
                                          icon: const Icon(Icons.favorite_rounded, color: AppColors.gold, size: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Error: $e')),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history_rounded, size: 48, color: AppColors.green.withOpacity(0.3)),
                          const SizedBox(height: 12),
                          Text(_selectedTab == 1 ? 'No tour history yet' : 'No bookmarks yet',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.green.withOpacity(0.5))),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String label, int index) {
    final active = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
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
      ),
    );
  }
}
