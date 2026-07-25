import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../utils/page_transitions.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIdx = 0;

  static const _slides = [
    _SlideData(
      icon: Icons.smart_toy_rounded,
      title: 'AI Tour Guide',
      desc:
          'Your personal AI guide narrates every artifact, painting, and landmark in your language. History like never before.',
      imgUrl:
          'https://images.unsplash.com/photo-1770713522187-d9c16e16a15b?w=800&h=500&fit=crop&auto=format',
    ),
    _SlideData(
      icon: Icons.qr_code_scanner_rounded,
      title: 'Scan QR Codes',
      desc:
          'Point your camera at any exhibit QR for instant history, audio narration, and interactive 3D content.',
      imgUrl:
          'https://images.unsplash.com/photo-1765127959746-3f5925d9a2c7?w=800&h=500&fit=crop&auto=format',
    ),
    _SlideData(
      icon: Icons.language_rounded,
      title: 'Multilingual Experiences',
      desc:
          'Break language barriers. Translate, narrate, and explore history in 40+ languages effortlessly.',
      imgUrl:
          'https://images.unsplash.com/photo-1772617616268-a2f27d194fce?w=800&h=500&fit=crop&auto=format',
    ),
    _SlideData(
      icon: Icons.route_rounded,
      title: 'Personalized Tours',
      desc:
          'AI crafts a custom itinerary based on your interests, time, and walking pace. Your perfect visit, every time.',
      imgUrl:
          'https://images.unsplash.com/photo-1765470129726-3689336ff549?w=800&h=500&fit=crop&auto=format',
    ),
  ];

  void _goLogin() {
    Navigator.of(context).pushReplacement(fadeRoute(const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentIdx];

    return Scaffold(
      backgroundColor: AppColors.sand,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 24, 0),
                child: TextButton(
                  onPressed: _goLogin,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.green.withOpacity(0.06),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(AppStrings.skip,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green.withOpacity(0.7))),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        child: ClipRRect(
                          key: ValueKey(_currentIdx),
                          borderRadius: BorderRadius.circular(28),
                          child: SizedBox(
                            height: 286,
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ColoredBox(color: AppColors.greenLight),
                                Image.network(
                                  slide.imgUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const ColoredBox(
                                    color: AppColors.greenLight,
                                    child: Center(
                                      child: Icon(Icons.museum_rounded,
                                          color: Colors.white54, size: 48),
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        AppColors.green.withOpacity(0.81),
                                      ],
                                      stops: const [0.45, 1.0],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.gold,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                AppColors.gold.withOpacity(0.6),
                                            blurRadius: 16,
                                            offset: const Offset(0, 4))
                                      ],
                                    ),
                                    child: Icon(slide.icon,
                                        color: AppColors.green),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${_currentIdx + 1} / ${_slides.length}',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        child: Column(
                          key: ValueKey(_currentIdx),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(slide.title,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.green)),
                            const SizedBox(height: 10),
                            Text(slide.desc,
                                style: TextStyle(
                                    fontSize: 14,
                                    height: 1.6,
                                    color: AppColors.green.withOpacity(0.6))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _currentIdx ? 26 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _currentIdx
                        ? AppColors.gold
                        : AppColors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentIdx < _slides.length - 1) {
                      setState(() => _currentIdx++);
                    } else {
                      _goLogin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentIdx < _slides.length - 1
                        ? AppColors.green
                        : AppColors.gold,
                    foregroundColor: _currentIdx < _slides.length - 1
                        ? Colors.white
                        : AppColors.green,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentIdx < _slides.length - 1
                        ? AppStrings.next
                        : AppStrings.startExploring,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideData {
  final IconData icon;
  final String title;
  final String desc;
  final String imgUrl;
  const _SlideData(
      {required this.icon,
      required this.title,
      required this.desc,
      required this.imgUrl});
}
