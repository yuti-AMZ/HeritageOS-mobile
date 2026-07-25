import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';

class HeritagePlaceExhibitsScreen extends StatefulWidget {
  final HeritagePlace place;
  final int initialIndex;
  const HeritagePlaceExhibitsScreen({super.key, required this.place, this.initialIndex = 0});
  @override
  State<HeritagePlaceExhibitsScreen> createState() => _HeritagePlaceExhibitsScreenState();
}

class _HeritagePlaceExhibitsScreenState extends State<HeritagePlaceExhibitsScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    final exhibits = widget.place.exhibits;
    if (exhibits.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Exhibits'), backgroundColor: AppColors.green, foregroundColor: Colors.white),
        body: const Center(child: Text('No exhibits available')),
      );
    }

    final exhibit = exhibits[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Hero
          Stack(
            children: [
              SizedBox(
                height: 260, width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: exhibits.length,
                  onPageChanged: (i) => setState(() => _currentIndex = i),
                  itemBuilder: (_, i) => Image.network(exhibits[i].imageUrl, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                ),
              ),
              Container(
                height: 260,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                  ),
                ),
              ),
              Positioned(
                top: 54, left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(19)),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 17),
                  ),
                ),
              ),
              Positioned(
                top: 54, right: 20,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(10)),
                      child: Text('${_currentIndex + 1}/${exhibits.length}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16, left: 20, right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(8)),
                      child: Text(exhibit.category,
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.green)),
                    ),
                    const SizedBox(height: 8),
                    Text(exhibit.name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exhibit.description,
                      style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.green.withOpacity(0.7))),
                  const SizedBox(height: 20),

                  // Actions
                  Row(
                    children: [
                      if (exhibit.audioUrl != null)
                        _actionBtn(Icons.headphones_rounded, 'Audio Guide', AppColors.gold),
                      if (exhibit.audioUrl != null) const SizedBox(width: 10),
                      _actionBtn(Icons.auto_awesome, 'Ask AI', AppColors.green),
                      const SizedBox(width: 10),
                      _actionBtn(Icons.share_rounded, 'Share', AppColors.sand),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (exhibit.relatedExhibits.isNotEmpty) ...[
                    const Text('Related Exhibits',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
                    const SizedBox(height: 10),
                    ...exhibit.relatedExhibits.map((rid) {
                      final related = exhibits.firstWhere(
                        (e) => e.id == rid,
                        orElse: () => exhibits.first,
                      );
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                width: 48, height: 48,
                                child: Image.network(related.imageUrl, fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(related.name,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.green))),
                            Icon(Icons.chevron_right, color: AppColors.green.withOpacity(0.3)),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bg == AppColors.sand ? AppColors.sand : bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: bg == AppColors.sand ? AppColors.green : Colors.white),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: bg == AppColors.sand ? AppColors.green : Colors.white)),
          ],
        ),
      ),
    );
  }
}
