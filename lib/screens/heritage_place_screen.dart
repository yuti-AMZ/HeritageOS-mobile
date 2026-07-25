import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';
import 'heritage_place_exhibits_screen.dart';
import 'heritage_place_ai_screen.dart';
import 'heritage_place_audio_guide_screen.dart';
import 'heritage_place_tour_screen.dart';
import 'heritage_place_timeline_screen.dart';
import 'heritage_place_nearby_screen.dart';
import 'heritage_place_activities_screen.dart';
import 'heritage_place_reviews_screen.dart';

class HeritagePlaceScreen extends StatefulWidget {
  final HeritagePlace place;
  const HeritagePlaceScreen({super.key, required this.place});
  @override
  State<HeritagePlaceScreen> createState() => _HeritagePlaceScreenState();
}

class _HeritagePlaceScreenState extends State<HeritagePlaceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Hero image
          Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(place.imageUrl, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
              ),
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.1), Colors.transparent],
                    stops: const [0, 0.6, 1],
                  ),
                ),
              ),
              Positioned(
                top: 54,
                left: 20,
                child: _iconBtn(Icons.arrow_back_ios_new_rounded, () => Navigator.pop(context)),
              ),
              Positioned(
                top: 54,
                right: 20,
                child: Row(
                  children: [
                    _iconBtn(
                      _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      () => setState(() => _isSaved = !_isSaved),
                    ),
                    const SizedBox(width: 8),
                    _iconBtn(Icons.share_rounded, () {}),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _tag(place.category, AppColors.gold, AppColors.green),
                        const SizedBox(width: 8),
                        _tag(place.city, Colors.white24, Colors.white),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(place.name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 13, color: AppColors.gold),
                        const SizedBox(width: 4),
                        Text('${place.rating} (${place.reviewCount} reviews)',
                            style: const TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Quick action buttons
          Transform.translate(
            offset: const Offset(0, -16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _quickAction(Icons.map_rounded, 'Map', () {}),
                  _quickAction(Icons.qr_code_scanner, 'Scan', () {}),
                  _quickAction(Icons.headphones_rounded, 'Audio', () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => HeritagePlaceAudioGuideScreen(place: place)));
                  }),
                  _quickAction(Icons.auto_awesome, 'AI Guide', () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => HeritagePlaceAIScreen(place: place)));
                  }),
                  _quickAction(Icons.route_rounded, 'Tour', () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => HeritagePlaceTourScreen(place: place)));
                  }),
                ],
              ),
            ),
          ),

          // Tabs
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.green.withOpacity(0.08))),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.green,
              unselectedLabelColor: AppColors.green.withOpacity(0.4),
              labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              indicatorColor: AppColors.gold,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Exhibits'),
                Tab(text: 'Timeline'),
                Tab(text: 'Reviews'),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _overviewTab(place),
                _exhibitsTab(place),
                _timelineTab(place),
                _reviewsTab(place),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            color: Colors.black38, borderRadius: BorderRadius.circular(19)),
        child: Icon(icon, color: Colors.white, size: 17),
      ),
    );
  }

  Widget _tag(String text, Color bg, Color col) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: col)),
    );
  }

  Widget _quickAction(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Icon(icon, size: 18, color: AppColors.green),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.green.withOpacity(0.7))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _overviewTab(HeritagePlace place) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('About', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
          const SizedBox(height: 8),
          Text(place.description,
              style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.green.withOpacity(0.7))),
          const SizedBox(height: 20),
          _infoRow(Icons.access_time, 'Opening Hours', place.openingHours),
          _infoRow(Icons.confirmation_number_outlined, 'Tickets', place.ticketInfo),
          _infoRow(Icons.phone, 'Contact', place.contact),
          _infoRow(Icons.location_on, 'Location', '${place.city}, ${place.country}'),
          const SizedBox(height: 20),
          // Photos
          if (place.photos.isNotEmpty) ...[
            const Text('Photos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: place.photos.length,
                itemBuilder: (_, i) => Container(
                  width: 130,
                  margin: const EdgeInsets.only(right: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Image.network(place.photos[i], fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          // Nearby attractions button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => HeritagePlaceNearbyScreen(place: place))),
              icon: const Icon(Icons.explore_rounded, size: 18),
              label: const Text('Nearby Attractions'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.green,
                side: const BorderSide(color: AppColors.green),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.gold),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.green.withOpacity(0.5))),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 13, color: AppColors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _exhibitsTab(HeritagePlace place) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: place.exhibits.length,
      itemBuilder: (_, i) {
        final exhibit = place.exhibits[i];
        return GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => HeritagePlaceExhibitsScreen(place: place, initialIndex: i))),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.06), blurRadius: 8)],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 72, height: 72,
                    child: Image.network(exhibit.imageUrl, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exhibit.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                      const SizedBox(height: 4),
                      Text(exhibit.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: AppColors.green.withOpacity(0.55))),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(6)),
                            child: Text(exhibit.category,
                                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.green.withOpacity(0.6))),
                          ),
                          if (exhibit.audioUrl != null) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.headphones, size: 12, color: AppColors.gold),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.green.withOpacity(0.25)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _timelineTab(HeritagePlace place) {
    return ListView.builder(
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
                  width: 14, height: 14,
                  decoration: BoxDecoration(color: AppColors.gold, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                ),
                if (i < place.timeline.length - 1)
                  Container(width: 2, height: 56, color: AppColors.gold.withOpacity(0.25)),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.year, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.gold)),
                  const SizedBox(height: 2),
                  Text(t.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.green)),
                  const SizedBox(height: 4),
                  Text(t.description, style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.green.withOpacity(0.6))),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _reviewsTab(HeritagePlace place) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.reviews_rounded, size: 48, color: AppColors.green.withOpacity(0.3)),
          const SizedBox(height: 12),
          Text('${place.reviewCount} reviews',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.green.withOpacity(0.5))),
          const SizedBox(height: 8),
          SizedBox(
            width: 200,
            child: OutlinedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => HeritagePlaceReviewsScreen(place: place))),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.green,
                side: const BorderSide(color: AppColors.green),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('View All Reviews'),
            ),
          ),
        ],
      ),
    );
  }
}
