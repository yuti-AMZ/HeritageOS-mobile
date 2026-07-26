import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationState {
  final double? latitude;
  final double? longitude;
  final bool isLoading;
  final String? error;

  const LocationState({
    this.latitude,
    this.longitude,
    this.isLoading = false,
    this.error,
  });
}

class LocationNotifier extends StateNotifier<LocationState> {
  StreamSubscription<Position>? _subscription;

  LocationNotifier() : super(const LocationState());

  Future<void> getCurrentLocation() async {
    state = const LocationState(isLoading: true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = const LocationState(error: 'Location services disabled');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = const LocationState(error: 'Location permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = const LocationState(error: 'Location permission permanently denied');
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      state = LocationState(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      state = LocationState(error: e.toString());
    }
  }

  void startTracking() {
    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    ).listen((position) {
      state = LocationState(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  void stopTracking() {
    _subscription?.cancel();
    _subscription = null;
  }

  double distanceTo(double lat, double lng) {
    if (state.latitude == null || state.longitude == null) return 0;
    return Geolocator.distanceBetween(
      state.latitude!,
      state.longitude!,
      lat,
      lng,
    );
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(),
);
