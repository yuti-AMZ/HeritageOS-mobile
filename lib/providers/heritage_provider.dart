import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/heritage_place.dart';
import '../models/review_model.dart';
import '../data/mock_data.dart';
import '../services/firestore_service.dart';

final heritageServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

// ── Places ──

final featuredPlacesProvider = StreamProvider<List<HeritagePlace>>((ref) {
  return Stream.value(MockData.heritagePlaces.where((p) => p.isFeatured).toList());
});

final allPlacesProvider = StreamProvider<List<HeritagePlace>>((ref) {
  return Stream.value(MockData.heritagePlaces);
});

final placeDetailProvider = FutureProvider.family<HeritagePlace?, String>((ref, placeId) async {
  try {
    return MockData.heritagePlaces.firstWhere((p) => p.id == placeId);
  } catch (_) {
    return null;
  }
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredPlacesProvider = Provider<AsyncValue<List<HeritagePlace>>>((ref) {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return ref.watch(allPlacesProvider);
  return ref.watch(allPlacesProvider).whenData((places) {
    final q = query.toLowerCase();
    return places.where((p) =>
        p.name.toLowerCase().contains(q) ||
        p.city.toLowerCase().contains(q) ||
        p.category.toLowerCase().contains(q)).toList();
  });
});

// ── Exhibits ──

final exhibitsProvider = StreamProvider.family<List<Exhibit>, String>((ref, placeId) {
  final place = MockData.heritagePlaces.where((p) => p.id == placeId).firstOrNull;
  return Stream.value(place?.exhibits ?? []);
});

final exhibitByQrProvider = FutureProvider.family<Exhibit?, String>((ref, qrCode) async {
  for (final place in MockData.heritagePlaces) {
    for (final exhibit in place.exhibits) {
      if (exhibit.qrCode == qrCode) return exhibit;
    }
  }
  return null;
});

// ── Reviews ──

final reviewsProvider = StreamProvider.family<List<Review>, String>((ref, placeId) {
  return Stream.value([
    Review(
      id: 'r1',
      placeId: placeId,
      userId: 'demo-user',
      userName: 'Hanna Bekele',
      rating: 5.0,
      text: 'An incredible experience! The history here is palpable.',
      date: DateTime(2026, 7, 15),
      tip: 'Visit in the morning for fewer crowds.',
    ),
    Review(
      id: 'r2',
      placeId: placeId,
      userId: 'user2',
      userName: 'Yonas Tadesse',
      rating: 4.5,
      text: 'Fascinating exhibits and well-preserved artifacts. A must-visit.',
      date: DateTime(2026, 7, 10),
    ),
    Review(
      id: 'r3',
      placeId: placeId,
      userId: 'user3',
      userName: 'Sara Mohammed',
      rating: 4.0,
      text: 'Great guided tours available. The audio guide is very informative.',
      date: DateTime(2026, 6, 28),
      tip: 'Combine with a walking tour of the surrounding area.',
    ),
  ]);
});

class ReviewNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  ReviewNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> addReview({
    required String placeId,
    required String userId,
    required String userName,
    required double rating,
    required String text,
    String? tip,
  }) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    state = const AsyncValue.data(null);
  }

  Future<void> deleteReview(String reviewId) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    state = const AsyncValue.data(null);
  }
}

final reviewNotifierProvider = StateNotifierProvider<ReviewNotifier, AsyncValue<void>>(
  (ref) => ReviewNotifier(ref),
);

// ── Saved Places ──

final savedPlaceIdsProvider = StateProvider<List<String>>((ref) => []);

final savedPlacesProvider = FutureProvider<List<HeritagePlace>>((ref) async {
  final ids = ref.watch(savedPlaceIdsProvider);
  final places = <HeritagePlace>[];
  for (final id in ids) {
    try {
      places.add(MockData.heritagePlaces.firstWhere((p) => p.id == id));
    } catch (_) {}
  }
  return places;
});
