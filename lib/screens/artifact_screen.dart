import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/heritage_place.dart';
import '../utils/exhibit_lookup.dart';
import 'ar_screen.dart';

class ArtifactScreen extends StatefulWidget {
  final Exhibit? exhibit;
  final String? placeName;

  const ArtifactScreen({super.key, this.exhibit, this.placeName});

  @override
  State<ArtifactScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactScreen> {
  String _tab = 'history';

  late final Exhibit _exhibit;
  late final String _placeName;

  final _defaultTimeline = const [
    TimelineEntry(year: '1889', event: 'Treaty of Wuchale signed between Ethiopia and Italy'),
    TimelineEntry(year: '1895', event: 'Italian forces invade from Eritrea'),
    TimelineEntry(year: 'Mar 1, 1896', event: 'Battle of Adwa — Ethiopian victory under Menelik II'),
    TimelineEntry(year: '1896', event: 'Treaty of Addis Ababa recognizes Ethiopian sovereignty'),
    TimelineEntry(year: 'Today', event: 'Adwa Victory Memorial Museum preserves the legacy in Addis Ababa'),
  ];

  @override
  void initState() {
    super.initState();
    final fallback = ExhibitLookup.byQrCode('ADWA-DIORAMA-001');
    _exhibit = widget.exhibit ??
        fallback?.exhibit ??
        const Exhibit(
          id: 'e1',
          name: 'Battle of Adwa Diorama',
          description:
              'A detailed miniature reconstruction of the Battle of Adwa, showing the decisive Ethiopian victory of 1896.',
          imageUrl:
              'https://images.unsplash.com/photo-1572905421176-6fa2f11a236e?w=400&h=300&fit=crop',
          category: 'Historical',
          qrCode: 'ADWA-DIORAMA-001',
        );
    _placeName =
        widget.placeName ?? fallback?.place.name ?? 'Adwa Victory Memorial Museum';
  }

  void _openAr() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArScreen(
          exhibit: _exhibit,
          placeName: _placeName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAr,
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.green,
        icon: const Icon(Icons.view_in_ar_rounded),
        label: Text(AppStrings.viewInAr,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Hero image
          Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  _exhibit.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: AppColors.sand),
                ),
              ),
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.72),
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: const [0, 0.55, 1],
                  ),
                ),
              ),
              Positioned(
                top: 54,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconButton(Icons.arrow_back_ios_new_rounded, () => Navigator.pop(context)),
                    Row(
                      children: [
                        _iconButton(Icons.view_in_ar_rounded, _openAr),
                        const SizedBox(width: 8),
                        _iconButton(Icons.favorite_border_rounded, () {}),
                        const SizedBox(width: 8),
                        _iconButton(Icons.bookmark_border_rounded, () {}),
                      ],
                    ),
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
                        _tag(_exhibit.category, AppColors.gold, AppColors.green),
                        if (_exhibit.qrCode != null) ...[
                          const SizedBox(width: 8),
                          _tag(_exhibit.qrCode!, Colors.white24, Colors.white),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_exhibit.name,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 11, color: AppColors.gold),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(_placeName,
                              style: const TextStyle(fontSize: 12, color: Colors.white70),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Audio bar
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.green.withOpacity(0.27),
                      blurRadius: 24,
                      offset: const Offset(0, 6))
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: AppColors.gold, shape: BoxShape.circle),
                    child: const Icon(Icons.play_arrow_rounded,
                        color: AppColors.green, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Audio Guide — Chapter 1: Discovery',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: 0.35,
                            backgroundColor: Colors.white.withOpacity(0.18),
                            valueColor:
                                const AlwaysStoppedAnimation(AppColors.gold),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('2:14',
                      style: TextStyle(fontSize: 11, color: Colors.white54)),
                  const SizedBox(width: 8),
                  const Icon(Icons.volume_up_rounded,
                      color: Colors.white70, size: 16),
                ],
              ),
            ),
          ),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: ['History', 'Timeline', 'Gallery', 'Quiz'].map((t) {
                final active = _tab == t.toLowerCase();
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _tab = t.toLowerCase()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: active ? AppColors.gold : Colors.transparent,
                              width: 2.5),
                        ),
                      ),
                      child: Text(t,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: active
                                  ? AppColors.green
                                  : AppColors.green.withOpacity(0.27))),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Tab content
          Expanded(
            child: _tab == 'history'
                ? _historyTab()
                : _tab == 'timeline'
                    ? _timelineTab()
                    : _tab == 'gallery'
                        ? _galleryTab()
                        : _quizTab(),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(18)),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _tag(String text, Color bg, Color col) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(text,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: col)),
    );
  }

  Widget _historyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('About This Artifact',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green)),
          const SizedBox(height: 10),
          Text(
            _exhibit.description,
            style: TextStyle(
                fontSize: 14,
                height: 1.7,
                color: AppColors.green.withOpacity(0.7)),
          ),
          const SizedBox(height: 20),
          const Text('Key Facts',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green)),
          const SizedBox(height: 12),
          _factRow('Category', _exhibit.category),
          _factRow('Museum', _placeName),
          if (_exhibit.qrCode != null) _factRow('QR Code', _exhibit.qrCode!),
          _factRow('AR', 'Available — tap View in AR'),
        ],
      ),
    );
  }

  Widget _factRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              child: Text(label,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green.withOpacity(0.5))),
          ),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.green))),
        ],
      ),
    );
  }

  Widget _timelineTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _defaultTimeline.length,
      itemBuilder: (_, i) {
        final t = _defaultTimeline[i];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gold, width: 2),
                  ),
                ),
                if (i < _defaultTimeline.length - 1)
                  Container(width: 2, height: 48, color: AppColors.gold.withOpacity(0.25)),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.year,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold)),
                  const SizedBox(height: 4),
                  Text(t.event,
                      style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.green.withOpacity(0.7))),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _galleryTab() {
    final images = [
      _exhibit.imageUrl,
      'https://images.unsplash.com/photo-1770713522187-d9c16e16a15b?w=300&h=300&fit=crop',
      'https://images.unsplash.com/photo-1772617616268-a2f27d194fce?w=300&h=300&fit=crop',
      'https://images.unsplash.com/photo-1771456294161-7d09c625cf96?w=300&h=300&fit=crop',
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: images.length,
      itemBuilder: (_, i) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(images[i], fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
      ),
    );
  }

  Widget _quizTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.quiz_rounded, size: 48, color: AppColors.gold.withOpacity(0.5)),
          const SizedBox(height: 12),
          Text('Test your knowledge!',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green.withOpacity(0.5))),
          const SizedBox(height: 8),
          Text('Take a quick quiz about this artifact',
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.green.withOpacity(0.35))),
        ],
      ),
    );
  }
}

class TimelineEntry {
  final String year;
  final String event;
  const TimelineEntry({required this.year, required this.event});
}
