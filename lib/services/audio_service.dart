import 'dart:async';
import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> play(String url) async {
    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> pause() async => await _player.pause();

  Future<void> resume() async => await _player.play();

  Future<void> seek(Duration position) async => await _player.seek(position);

  Future<void> stop() async => await _player.stop();

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  bool get isPlaying => _player.playing;

  Duration get position => _player.position;

  Duration get duration => _player.duration ?? Duration.zero;

  Future<void> dispose() async => await _player.dispose();
}
