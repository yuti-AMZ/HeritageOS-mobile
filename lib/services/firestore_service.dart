import 'dart:async';
import '../models/heritage_place.dart';
import '../models/review_model.dart';
import '../models/user_model.dart';
import '../data/mock_data.dart';

class FirestoreService {
  bool _isAvailable = false;

  FirestoreService() {
    _isAvailable = false;
  }

  // ── Users ──

  Future<void> createUserProfile(UserProfile user) async {
    if (!_isAvailable) return;
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    if (!_isAvailable) {
      return UserProfile(
        uid: uid,
        name: 'Demo User',
        email: 'demo@heritageos.com',
        createdAt: DateTime.now(),
      );
    }
    return null;
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {}

  Future<void> toggleSavedPlace(String uid, String placeId) async {
    // Demo: no-op
  }

  // ── Heritage Places ──

  Stream<List<HeritagePlace>> getFeaturedPlaces() {
    return Stream.value(MockData.heritagePlaces.where((p) => p.isFeatured).toList());
  }

  Stream<List<HeritagePlace>> getAllPlaces() {
    return Stream.value(MockData.heritagePlaces);
  }

  Future<HeritagePlace?> getPlaceById(String id) async {
    try {
      return MockData.heritagePlaces.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<HeritagePlace>> searchPlaces(String query) async {
    final q = query.toLowerCase();
    return MockData.heritagePlaces.where((p) =>
        p.name.toLowerCase().contains(q) ||
        p.city.toLowerCase().contains(q) ||
        p.category.toLowerCase().contains(q) ||
        p.country.toLowerCase().contains(q)).toList();
  }

  // ── Exhibits ──

  Stream<List<Exhibit>> getExhibitsForPlace(String placeId) {
    final place = MockData.heritagePlaces.where((p) => p.id == placeId).firstOrNull;
    return Stream.value(place?.exhibits ?? []);
  }

  Future<Exhibit?> getExhibitByQrCode(String qrCode) async {
    for (final place in MockData.heritagePlaces) {
      for (final exhibit in place.exhibits) {
        if (exhibit.qrCode == qrCode) return exhibit;
      }
    }
    return null;
  }

  // ── Reviews ──

  Stream<List<Review>> getReviewsForPlace(String placeId) {
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
  }

  Future<void> addReview(Review review) async {
    // Demo: no-op
  }

  Future<void> deleteReview(String reviewId) async {
    // Demo: no-op
  }

  // ── Scan History ──

  Future<void> addScanHistory(String uid, Map<String, dynamic> scanData) async {}

  Stream<List<Map<String, dynamic>>> getScanHistory(String uid) {
    return Stream.value([]);
  }
}
