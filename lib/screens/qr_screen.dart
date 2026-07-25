import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/place_model.dart';
import 'artifact_screen.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanned = const [
      ScannedItem(
          name: 'Rosetta Stone',
          museum: 'British Museum',
          time: '2 min ago',
          imageUrl:
              'https://images.unsplash.com/photo-1782466357373-515da25d313e?w=100&h=100&fit=crop'),
      ScannedItem(
          name: 'Venus de Milo',
          museum: 'The Louvre',
          time: 'Yesterday',
          imageUrl:
              'https://images.unsplash.com/photo-1771456294161-7d09c625cf96?w=100&h=100&fit=crop'),
      ScannedItem(
          name: 'Elgin Marbles',
          museum: 'British Museum',
          time: '2 days ago',
          imageUrl:
              'https://images.unsplash.com/photo-1770713522187-d9c16e16a15b?w=100&h=100&fit=crop'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.scanQR,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text('Flash Off',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.green)),
                  ),
                ],
              ),
            ),

            // Scanner viewport
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 330,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.grey[900]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1765127959746-3f5925d9a2c7?w=600&h=800&fit=crop',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(0.75),
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.grey[800]),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.45),
                    ),
                    // Scanning frame
                    Center(
                      child: SizedBox(
                        width: 224,
                        height: 224,
                        child: Stack(
                          children: [
                            // Corner brackets
                            ...List.generate(4, (i) {
                              final isTop = i < 2;
                              final isLeft = i.isEven;
                              return Positioned(
                                top: isTop ? 0 : null,
                                bottom: isTop ? null : 0,
                                left: isLeft ? 0 : null,
                                right: isLeft ? null : 0,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: isTop
                                          ? const BorderSide(
                                              color: AppColors.gold,
                                              width: 3)
                                          : BorderSide.none,
                                      bottom: !isTop
                                          ? const BorderSide(
                                              color: AppColors.gold,
                                              width: 3)
                                          : BorderSide.none,
                                      left: isLeft
                                          ? const BorderSide(
                                              color: AppColors.gold,
                                              width: 3)
                                          : BorderSide.none,
                                      right: !isLeft
                                          ? const BorderSide(
                                              color: AppColors.gold,
                                              width: 3)
                                          : BorderSide.none,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: isTop && isLeft
                                          ? const Radius.circular(8)
                                          : Radius.zero,
                                      topRight: isTop && !isLeft
                                          ? const Radius.circular(8)
                                          : Radius.zero,
                                      bottomLeft: !isTop && isLeft
                                          ? const Radius.circular(8)
                                          : Radius.zero,
                                      bottomRight: !isTop && !isLeft
                                          ? const Radius.circular(8)
                                          : Radius.zero,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.gold.withOpacity(0.5),
                                blurRadius: 10)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Text(AppStrings.pointAtQR,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Recently scanned
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color(0xFF181818),
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.recentlyScanned,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold)),
                    const SizedBox(height: 12),
                    ...scanned.map((item) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ArtifactScreen())),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: const Color(0xFF252525),
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(item.imageUrl,
                                      width: 44,
                                      height: 44,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          Container(
                                              width: 44,
                                              height: 44,
                                              color: Colors.grey[700])),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.name,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                      const SizedBox(height: 2),
                                      Text(item.museum,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: AppColors.gold
                                                  .withOpacity(0.6))),
                                    ],
                                  ),
                                ),
                                Text(item.time,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white38)),
                              ],
                            ),
                          ),
                        )),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ArtifactScreen())),
                        icon: const Icon(Icons.camera_alt, size: 16),
                        label: Text(AppStrings.scanArtifact),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: AppColors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
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
