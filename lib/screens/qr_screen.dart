import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/exhibit_lookup.dart';
import 'artifact_screen.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  bool _isLookingUp = false;
  String? _statusMessage;

  void _openDemoScan() async {
    setState(() {
      _isLookingUp = true;
      _statusMessage = 'Looking up demo exhibit...';
    });

    await Future.delayed(const Duration(milliseconds: 500));

    final match = ExhibitLookup.byQrCode('ADWA-DIORAMA-001');

    if (!mounted) return;

    setState(() {
      _isLookingUp = false;
      _statusMessage = null;
    });

    if (match != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ArtifactScreen(exhibit: match.exhibit, placeName: match.place.name),
        ),
      );
    } else {
      setState(() {
        _statusMessage = 'Exhibit not found';
      });
    }
  }

  void _onDemoQrTap(String qrCode) async {
    setState(() {
      _isLookingUp = true;
      _statusMessage = 'Looking up: $qrCode';
    });

    await Future.delayed(const Duration(milliseconds: 500));

    final match = ExhibitLookup.byQrCode(qrCode);

    if (!mounted) return;

    setState(() {
      _isLookingUp = false;
      _statusMessage = null;
    });

    if (match != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ArtifactScreen(exhibit: match.exhibit, placeName: match.place.name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Scan QR Code',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      'Demo Mode',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gold),
                    ),
                  ),
                ],
              ),
            ),

            // Camera placeholder
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.grey[900]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: Colors.grey[900]),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.qr_code_scanner_rounded,
                              size: 48, color: AppColors.gold.withOpacity(0.5)),
                          const SizedBox(height: 12),
                          Text(
                            'Camera unavailable in demo mode.\nTap the demo QR codes below.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, height: 1.5, color: Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                    if (_isLookingUp)
                      Container(
                        color: Colors.black54,
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: AppColors.gold),
                              SizedBox(height: 12),
                              Text('Looking up exhibit...',
                                  style: TextStyle(color: Colors.white, fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 16, left: 16, right: 16,
                      child: Text(
                        _statusMessage ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _statusMessage != null ? Colors.orangeAccent : Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                    const Text('Demo QR Codes — Tap to scan',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.gold)),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView(
                        children: [
                          _demoQrCard('ADWA-DIORAMA-001', 'Battle of Adwa Diorama', 'Adwa Victory Memorial'),
                          _demoQrCard('NME-LUCY-001', 'Lucy (Dinkinesh)', 'National Museum'),
                          _demoQrCard('LALIBELA-GIYORGIS-001', 'Bete Giyorgis', 'Lalibela Rock Churches'),
                          _demoQrCard('AXUM-STELE-001', 'Great Stele of Axum', 'Axum Archaeological Site'),
                          _demoQrCard('GONDAR-FASIL-001', 'Castle of Fasilides', 'Fasil Ghebbi'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLookingUp ? null : _openDemoScan,
                        icon: const Icon(Icons.camera_alt, size: 16),
                        label: const Text('Quick Demo Scan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: AppColors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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

  Widget _demoQrCard(String qrCode, String name, String museum) {
    return GestureDetector(
      onTap: () => _onDemoQrTap(qrCode),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xFF252525),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.qr_code_2, color: AppColors.gold, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(museum, style: TextStyle(fontSize: 11, color: AppColors.gold.withOpacity(0.6))),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }
}
