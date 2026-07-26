import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/heritage_place.dart';

/// AR preview stub — live camera with a floating exhibit overlay.
/// Ready to swap in ARCore / ARKit / model_viewer later.
class ArScreen extends StatefulWidget {
  final Exhibit exhibit;
  final String placeName;

  const ArScreen({
    super.key,
    required this.exhibit,
    required this.placeName,
  });

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  bool _modelPlaced = false;
  bool _cameraReady = true;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_cameraReady)
            MobileScanner(
              onDetect: (_) {},
              errorBuilder: (context, error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _cameraReady) {
                    setState(() => _cameraReady = false);
                  }
                });
                return _fallbackBackdrop();
              },
            )
          else
            _fallbackBackdrop(),

          // Dim vignette
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.75),
                ],
                stops: const [0, 0.22, 0.62, 1],
              ),
            ),
            child: const SizedBox.expand(),
          ),

          // Ground plane hint
          Align(
            alignment: const Alignment(0, 0.35),
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) {
                final t = 0.35 + (_pulse.value * 0.35);
                return Container(
                  width: 180 + (_pulse.value * 24),
                  height: 70 + (_pulse.value * 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.gold.withOpacity(t),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.gold.withOpacity(0.06),
                  ),
                );
              },
            ),
          ),

          // Floating exhibit "model"
          Align(
            alignment: Alignment(0, _modelPlaced ? -0.05 : -0.15),
            child: AnimatedScale(
              scale: _modelPlaced ? 1.0 : 0.88,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutBack,
              child: _exhibitCard(),
            ),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  _roundBtn(Icons.close_rounded, () => Navigator.pop(context)),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.gold.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.view_in_ar_rounded,
                            size: 14, color: AppColors.gold),
                        const SizedBox(width: 6),
                        Text(AppStrings.arPreview,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),

          // Bottom controls
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _modelPlaced
                          ? AppStrings.arModelPlaced
                          : AppStrings.arTapToPlace,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppStrings.arStubHint,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                setState(() => _modelPlaced = !_modelPlaced),
                            icon: Icon(
                              _modelPlaced
                                  ? Icons.refresh_rounded
                                  : Icons.add_box_outlined,
                              size: 18,
                            ),
                            label: Text(_modelPlaced
                                ? AppStrings.arReset
                                : AppStrings.arPlaceModel),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(
                                  color: Colors.white.withOpacity(0.35)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Full AR coming soon — this is a preview stub.'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.threed_rotation, size: 18),
                            label: Text(AppStrings.viewInAr),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              foregroundColor: AppColors.green,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallbackBackdrop() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A1A), Color(0xFF0C0C0C), Color(0xFF1E3A2F)],
        ),
      ),
      child: CustomPaint(painter: _GridPainter(), child: const SizedBox.expand()),
    );
  }

  Widget _exhibitCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.gold, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.35),
                blurRadius: 28,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.exhibit.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.green,
                    child: const Icon(Icons.museum_rounded,
                        color: AppColors.gold, size: 48),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    color: Colors.black54,
                    child: const Icon(Icons.view_in_ar_rounded,
                        color: AppColors.gold, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.exhibit.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.placeName,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.gold.withOpacity(0.85),
          ),
        ),
      ],
    );
  }

  Widget _roundBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;
    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
