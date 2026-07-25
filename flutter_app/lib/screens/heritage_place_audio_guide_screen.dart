import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';

class HeritagePlaceAudioGuideScreen extends StatefulWidget {
  final HeritagePlace place;
  const HeritagePlaceAudioGuideScreen({super.key, required this.place});
  @override
  State<HeritagePlaceAudioGuideScreen> createState() => _HeritagePlaceAudioGuideScreenState();
}

class _HeritagePlaceAudioGuideScreenState extends State<HeritagePlaceAudioGuideScreen> {
  bool _isPlaying = false;
  double _progress = 0.35;
  String _selectedLanguage = 'English';
  bool _isDetailed = false;

  final _languages = ['English', 'Arabic', 'French', 'Amharic', 'Chinese', 'Spanish'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.green,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(18)),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text('Audio Guide', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(widget.place.name,
                        style: const TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language selector
                  const Text('Language', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: _languages.map((lang) {
                      final active = _selectedLanguage == lang;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedLanguage = lang),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: active ? AppColors.green : AppColors.sand,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(lang,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: active ? Colors.white : AppColors.green.withOpacity(0.7))),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Narration style
                  Row(
                    children: [
                      const Text('Style:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.green)),
                      const SizedBox(width: 12),
                      _styleBtn('Short', !_isDetailed),
                      const SizedBox(width: 8),
                      _styleBtn('Detailed', _isDetailed),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Track list
                  const Text('Tracks',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
                  const SizedBox(height: 12),
                  ...widget.place.exhibits.where((e) => e.audioUrl != null).toList().asMap().entries.map((entry) {
                    final i = entry.key;
                    final exhibit = entry.value;
                    final active = i == 1; // Simulate second track as current
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: active ? AppColors.green.withOpacity(0.08) : AppColors.sand,
                        borderRadius: BorderRadius.circular(12),
                        border: active ? Border.all(color: AppColors.gold, width: 1.5) : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                                color: active ? AppColors.gold : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                                active ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                color: AppColors.green, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(exhibit.name,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.green)),
                                const SizedBox(height: 2),
                                Text(_isDetailed ? 'Detailed · 5:30' : 'Short · 2:15',
                                    style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.5))),
                              ],
                            ),
                          ),
                          if (active)
                            Icon(Icons.volume_up_rounded, size: 16, color: AppColors.gold),
                        ],
                      ),
                    );
                  }),

                  // Add tracks for exhibits without audio
                  ...widget.place.exhibits.where((e) => e.audioUrl == null).take(2).map((exhibit) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.play_arrow_rounded, color: AppColors.green, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(exhibit.name,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.green)),
                                const SizedBox(height: 2),
                                Text(_isDetailed ? 'Detailed · 4:45' : 'Short · 1:50',
                                    style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.5))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Player bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: AppColors.green,
              boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, -4))],
            ),
            child: Column(
              children: [
                // Progress bar
                Row(
                  children: [
                    const Text('0:45', style: TextStyle(fontSize: 10, color: Colors.white54)),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: AppColors.gold,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: AppColors.gold,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          trackHeight: 3,
                        ),
                        child: Slider(value: _progress, onChanged: (v) => setState(() => _progress = v)),
                      ),
                    ),
                    const Text('2:15', style: TextStyle(fontSize: 10, color: Colors.white54)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 28)),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => setState(() => _isPlaying = !_isPlaying),
                      child: Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(28)),
                        child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: AppColors.green, size: 30),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 28)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _styleBtn(String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => _isDetailed = label == 'Detailed'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.gold : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? AppColors.green : AppColors.green.withOpacity(0.5))),
      ),
    );
  }
}
