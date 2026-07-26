import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/audio_service.dart';

final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService();
});

class AudioState {
  final bool isPlaying;
  final String? currentTrackUrl;
  final String? currentTrackName;
  final Duration position;
  final Duration duration;

  const AudioState({
    this.isPlaying = false,
    this.currentTrackUrl,
    this.currentTrackName,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  AudioState copyWith({
    bool? isPlaying,
    String? currentTrackUrl,
    String? currentTrackName,
    Duration? position,
    Duration? duration,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentTrackUrl: currentTrackUrl ?? this.currentTrackUrl,
      currentTrackName: currentTrackName ?? this.currentTrackName,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}

class AudioNotifier extends StateNotifier<AudioState> {
  final AudioService _audioService;

  AudioNotifier(this._audioService) : super(const AudioState()) {
    _audioService.positionStream.listen((pos) {
      state = state.copyWith(position: pos);
    });
    _audioService.durationStream.listen((dur) {
      state = state.copyWith(duration: dur ?? Duration.zero);
    });
    _audioService.playerStateStream.listen((playerState) {
      state = state.copyWith(isPlaying: playerState.playing);
    });
  }

  Future<void> play(String url, String name) async {
    if (state.currentTrackUrl == url && state.isPlaying) {
      await _audioService.pause();
      return;
    }
    state = state.copyWith(
      currentTrackUrl: url,
      currentTrackName: name,
      isPlaying: true,
    );
    await _audioService.play(url);
  }

  Future<void> pause() async => await _audioService.pause();

  Future<void> resume() async => await _audioService.resume();

  Future<void> seek(Duration position) async => await _audioService.seek(position);

  Future<void> stop() async {
    await _audioService.stop();
    state = const AudioState();
  }

  Future<void> skipForward() async {
    final newPos = state.position + const Duration(seconds: 15);
    await _audioService.seek(newPos > state.duration ? state.duration : newPos);
  }

  Future<void> skipBackward() async {
    final newPos = state.position - const Duration(seconds: 15);
    await _audioService.seek(newPos < Duration.zero ? Duration.zero : newPos);
  }
}

final audioNotifierProvider = StateNotifierProvider<AudioNotifier, AudioState>(
  (ref) => AudioNotifier(ref.watch(audioServiceProvider)),
);
