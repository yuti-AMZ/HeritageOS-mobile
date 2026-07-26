import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';
import '../models/heritage_place.dart';
import '../providers/map_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  HeritagePlace? _selectedPlace;
  bool _showRoutePanel = false;

  // Ethiopia bounding box
  static const double _ethLatMin = 3.4;
  static const double _ethLatMax = 14.9;
  static const double _ethLngMin = 33.0;
  static const double _ethLngMax = 48.0;

  double _latToY(double lat) {
    return 1.0 - (lat - _ethLatMin) / (_ethLatMax - _ethLatMin);
  }

  double _lngToX(double lng) {
    return (lng - _ethLngMin) / (_ethLngMax - _ethLngMin);
  }

  Future<void> _navigateToPlace(HeritagePlace place) async {
    final url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=${place.latitude},${place.longitude}&travelmode=driving');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _navigateFromCurrentToAdwa() async {
    final location = ref.read(locationProvider);
    final adwa = MockData.heritagePlaces.firstWhere((p) => p.id == '1');

    String origin = '';
    if (location.latitude != null && location.longitude != null) {
      origin = '${location.latitude},${location.longitude}';
    } else {
      origin = 'Addis Ababa, Ethiopia';
    }

    final url = Uri.parse(
        'https://www.google.com/maps/dir/$origin/${adwa.latitude},${adwa.longitude}/@${adwa.latitude},${adwa.longitude},8z/data=!3m1!4b1!4m2!4m1!3e0');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openInGoogleMaps(HeritagePlace place) async {
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  double _distanceFromUser(HeritagePlace place) {
    final location = ref.read(locationProvider);
    if (location.latitude == null || location.longitude == null) {
      return _haversine(9.0192, 38.7525, place.latitude, place.longitude);
    }
    return _haversine(
        location.latitude!, location.longitude!, place.latitude, place.longitude);
  }

  double _haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0;
    final dLat = (lat2 - lat1) * pi / 180;
    final dLon = (lon2 - lon1) * pi / 180;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    return R * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMapArea()),
            if (_showRoutePanel && _selectedPlace != null)
              _buildRoutePanel()
            else
              _buildAdwaBanner(),
            _buildNearbyList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final loc = ref.read(locationProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                  color: AppColors.sand, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16, color: AppColors.green),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Heritage Map',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.green)),
                Text('Ethiopia\'s UNESCO sites & landmarks',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => ref.read(locationProvider.notifier).getCurrentLocation(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColors.sand, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.my_location_rounded,
                      size: 14,
                      color: loc.latitude != null ? AppColors.gold : AppColors.green),
                  const SizedBox(width: 4),
                  Text(loc.latitude != null ? 'Located' : 'Locate Me',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.green)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapArea() {
    final places = MockData.heritagePlaces;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFE8F0EA)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Ethiopia outline hint
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: _EthiopiaMapPainter(),
                ),

                // Place pins
                ...places.map((place) {
                  final x = _lngToX(place.longitude) * constraints.maxWidth;
                  final y = _latToY(place.latitude) * constraints.maxHeight;
                  final isSelected = _selectedPlace?.id == place.id;
                  final isAdwa = place.id == '1';

                  return Positioned(
                    left: x - (isAdwa ? 20 : 14),
                    top: y - (isAdwa ? 32 : 24),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPlace = place;
                          _showRoutePanel = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isAdwa ? 10 : 6,
                                  vertical: isAdwa ? 4 : 2),
                              decoration: BoxDecoration(
                                  color: isAdwa
                                      ? AppColors.gold
                                      : isSelected
                                          ? AppColors.green
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(isAdwa ? 10 : 8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2))
                                  ]),
                              child: Text(
                                place.name.length > 12
                                    ? '${place.name.substring(0, 10)}...'
                                    : place.name,
                                style: TextStyle(
                                    fontSize: isAdwa ? 10 : 8,
                                    fontWeight: FontWeight.bold,
                                    color: isAdwa
                                        ? AppColors.green
                                        : isSelected
                                            ? Colors.white
                                            : AppColors.green),
                              ),
                            ),
                            Icon(Icons.location_on,
                                size: isAdwa ? 28 : 20,
                                color: isAdwa
                                    ? AppColors.gold
                                    : isSelected
                                        ? AppColors.green
                                        : AppColors.gold),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                // User location dot
                if (ref.read(locationProvider).latitude != null && ref.read(locationProvider).longitude != null)
                  Positioned(
                    left: _lngToX(ref.read(locationProvider).longitude!) * constraints.maxWidth - 8,
                    top: _latToY(ref.read(locationProvider).latitude!) * constraints.maxHeight - 8,
                    child: Container(
                      width: 16, height: 16,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                blurRadius: 12)
                          ]),
                    ),
                  ),

                // Compass
                Positioned(
                  top: 12, right: 12,
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08), blurRadius: 6)
                        ]),
                    child: const Icon(Icons.explore_rounded,
                        size: 18, color: AppColors.green),
                  ),
                ),

                // Map legend
                Positioned(
                  top: 12, left: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _legendItem(AppColors.gold, 'Featured'),
                        _legendItem(AppColors.green, 'Selected'),
                        _legendItem(Colors.blue, 'Your Location'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 8, color: AppColors.green)),
        ],
      ),
    );
  }

  Widget _buildAdwaBanner() {
    final adwa = MockData.heritagePlaces.firstWhere((p) => p.id == '1');
    final dist = _distanceFromUser(adwa);

    return GestureDetector(
      onTap: () => setState(() {
        _selectedPlace = adwa;
        _showRoutePanel = true;
      }),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.green, AppColors.green.withOpacity(0.85)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: AppColors.green.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                  color: AppColors.gold, borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.navigation_rounded, color: AppColors.green, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Route to Adwa Victory Memorial',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text('${dist.toStringAsFixed(0)} km from you · Battle of Adwa, 1896',
                      style: const TextStyle(fontSize: 11, color: Colors.white70)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutePanel() {
    final place = _selectedPlace!;
    final dist = _distanceFromUser(place);
    final duration = (dist / 60).toStringAsFixed(0);

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: AppColors.green.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: AppColors.gold, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.location_on, color: AppColors.green, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                    Text('${place.city}, ${place.country}',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.green.withOpacity(0.5))),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _showRoutePanel = false;
                  _selectedPlace = null;
                }),
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                      color: AppColors.sand, borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.close, size: 14, color: AppColors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _routeStat(Icons.directions_car_rounded, '${dist.toStringAsFixed(0)} km', 'Distance'),
              const SizedBox(width: 12),
              _routeStat(Icons.schedule_rounded, '~$duration hrs', 'Driving'),
              const SizedBox(width: 12),
              _routeStat(Icons.star_rounded, '${place.rating}', 'Rating'),
              const SizedBox(width: 12),
              _routeStat(Icons.category_rounded, place.category, 'Type'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _navigateToPlace(place),
                  icon: const Icon(Icons.navigation_rounded, size: 16),
                  label: const Text('Get Directions',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _openInGoogleMaps(place),
                  icon: const Icon(Icons.map_rounded, size: 16),
                  label: const Text('View on Map',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.green,
                    side: const BorderSide(color: AppColors.green),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _routeStat(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.sand, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Icon(icon, size: 14, color: AppColors.gold),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.green)),
            Text(label,
                style: TextStyle(
                    fontSize: 8, color: AppColors.green.withOpacity(0.5))),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyList() {
    final places = MockData.heritagePlaces;
    final sorted = List<HeritagePlace>.from(places)
      ..sort((a, b) =>
          _distanceFromUser(a).compareTo(_distanceFromUser(b)));

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ALL HERITAGE SITES',
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.gold)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sorted.length,
              itemBuilder: (_, i) {
                final place = sorted[i];
                final dist = _distanceFromUser(place);
                final isSelected = _selectedPlace?.id == place.id;
                final isAdwa = place.id == '1';

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPlace = place;
                      _showRoutePanel = true;
                    });
                  },
                  child: Container(
                    width: 130,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.green : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: isAdwa
                          ? Border.all(color: AppColors.gold, width: 2)
                          : null,
                      boxShadow: [
                        BoxShadow(
                            color: isSelected
                                ? AppColors.green.withOpacity(0.2)
                                : Colors.black.withOpacity(0.04),
                            blurRadius: 6)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            if (isAdwa) ...[
                              const Icon(Icons.star_rounded,
                                  size: 12, color: AppColors.gold),
                              const SizedBox(width: 2),
                            ],
                            Expanded(
                              child: Text(
                                place.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('${dist.toStringAsFixed(0)} km',
                            style: TextStyle(
                                fontSize: 10,
                                color: isSelected
                                    ? Colors.white70
                                    : AppColors.gold)),
                        const SizedBox(height: 2),
                        Text(place.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 9,
                                color: isSelected
                                    ? Colors.white54
                                    : AppColors.green.withOpacity(0.5))),
                      ],
                    ),
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

class _EthiopiaMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.green.withOpacity(0.06)
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Simulated roads
    final roadPaint = Paint()
      ..color = AppColors.green.withOpacity(0.12)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Main highway Addis -> Adwa (simplified)
    final path = Path();
    path.moveTo(size.width * 0.55, size.height * 0.55);
    path.quadraticBezierTo(
        size.width * 0.45, size.height * 0.4,
        size.width * 0.4, size.height * 0.25);
    canvas.drawPath(path, roadPaint);

    // Addis -> Lalibela
    final path2 = Path();
    path2.moveTo(size.width * 0.55, size.height * 0.55);
    path2.quadraticBezierTo(
        size.width * 0.6, size.height * 0.35,
        size.width * 0.58, size.height * 0.2);
    canvas.drawPath(path2, roadPaint);

    // Addis -> Gondar
    final path3 = Path();
    path3.moveTo(size.width * 0.55, size.height * 0.55);
    path3.quadraticBezierTo(
        size.width * 0.5, size.height * 0.38,
        size.width * 0.48, size.height * 0.22);
    canvas.drawPath(path3, roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
