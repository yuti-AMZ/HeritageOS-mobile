import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';
import '../providers/audio_provider.dart';

class HeritagePlaceAudioGuideScreen extends ConsumerStatefulWidget {
  final HeritagePlace place;
  const HeritagePlaceAudioGuideScreen({super.key, required this.place});
  @override
  ConsumerState<HeritagePlaceAudioGuideScreen> createState() => _HeritagePlaceAudioGuideScreenState();
}

class _HeritagePlaceAudioGuideScreenState extends ConsumerState<HeritagePlaceAudioGuideScreen> {
  String _selectedLanguage = 'English';
  bool _isDetailed = false;

  final _languages = ['Amharic', 'English', 'Afaan Oromo', 'Tigrinya', 'Somali', 'French'];

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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

                  const Text('Tracks',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
                  const SizedBox(height: 12),

                  ...widget.place.exhibits.asMap().entries.map((entry) {
                    final exhibit = entry.value;
                    final hasAudio = exhibit.audioUrl != null;
                    final isCurrentTrack = audioState.currentTrackName == exhibit.name;
                    final isPlayingThis = isCurrentTrack && audioState.isPlaying;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCurrentTrack ? AppColors.green.withOpacity(0.08) : AppColors.sand,
                        borderRadius: BorderRadius.circular(12),
                        border: isCurrentTrack ? Border.all(color: AppColors.gold, width: 1.5) : null,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: hasAudio
                                ? () => ref.read(audioNotifierProvider.notifier).play(
                                    exhibit.audioUrl!, exhibit.name)
                                : null,
                            child: Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                  color: isPlayingThis ? AppColors.gold : Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                  isPlayingThis ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  color: AppColors.green, size: 20),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(exhibit.name,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.green)),
                                const SizedBox(height: 2),
                                Text(hasAudio
                                    ? (_isDetailed ? 'Detailed · Audio available' : 'Short · Audio available')
                                    : 'Audio not available',
                                    style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.5))),
                              ],
                            ),
                          ),
                          if (isPlayingThis)
                            Icon(Icons.volume_up_rounded, size: 16, color: AppColors.gold),
                          if (!hasAudio)
                            Icon(Icons.headphones, size: 16, color: AppColors.green.withOpacity(0.3)),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          if (audioState.currentTrackUrl != null)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              decoration: BoxDecoration(
                color: AppColors.green,
                boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, -4))],
              ),
              child: Column(
                children: [
                  Text(audioState.currentTrackName ?? '',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(_formatDuration(audioState.position),
                          style: const TextStyle(fontSize: 10, color: Colors.white54)),
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: AppColors.gold,
                            inactiveTrackColor: Colors.white24,
                            thumbColor: AppColors.gold,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            trackHeight: 3,
                          ),
                          child: Slider(
                            value: audioState.duration.inMilliseconds > 0
                                ? audioState.position.inMilliseconds / audioState.duration.inMilliseconds
                                : 0,
                            onChanged: (v) {
                              final pos = Duration(
                                  milliseconds: (v * audioState.duration.inMilliseconds).round());
                              ref.read(audioNotifierProvider.notifier).seek(pos);
                            },
                          ),
                        ),
                      ),
                      Text(_formatDuration(audioState.duration),
                          style: const TextStyle(fontSize: 10, color: Colors.white54)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => ref.read(audioNotifierProvider.notifier).skipBackward(),
                          icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 28)),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          if (audioState.isPlaying) {
                            ref.read(audioNotifierProvider.notifier).pause();
                          } else {
                            ref.read(audioNotifierProvider.notifier).resume();
                          }
                        },
                        child: Container(
                          width: 56, height: 56,
                          decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(28)),
                          child: Icon(audioState.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                              color: AppColors.green, size: 30),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                          onPressed: () => ref.read(audioNotifierProvider.notifier).skipForward(),
                          icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 28)),
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

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
