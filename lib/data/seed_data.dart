import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/heritage_place.dart';
import '../data/mock_data.dart';

class SeedData {
  static Future<void> seedAllPlaces() async {
    for (final place in MockData.heritagePlaces) {
      await _seedPlace(place);
    }
  }

  static Future<void> _seedPlace(HeritagePlace place) async {
    final placeRef = FirebaseFirestore.instance
        .collection('heritage_places')
        .doc(place.id);

    await placeRef.set(place.toMap());

    for (final exhibit in place.exhibits) {
      await placeRef.collection('exhibits').doc(exhibit.id).set(exhibit.toMap());
    }
  }

  static Future<void> seedReviews() async {
    final reviews = [
      {
        'placeId': '1',
        'userId': 'demo_user',
        'userName': 'Sarah Johnson',
        'rating': 5.0,
        'text': 'An incredibly moving experience. The Battle of Adwa diorama brought history to life.',
        'date': Timestamp.fromDate(DateTime(2025, 1, 15)),
        'tip': 'Visit in the morning for fewer crowds.',
      },
      {
        'placeId': '1',
        'userId': 'demo_user_2',
        'userName': 'Marco Rossi',
        'rating': 4.5,
        'text': 'Excellent museum with well-preserved artifacts. The oral history section is particularly powerful.',
        'date': Timestamp.fromDate(DateTime(2025, 2, 20)),
      },
      {
        'placeId': '2',
        'userId': 'demo_user_3',
        'userName': 'Aisha Mohammed',
        'rating': 5.0,
        'text': 'Seeing Lucy (Dinkinesh) in person was a dream come true. The museum is well organized.',
        'date': Timestamp.fromDate(DateTime(2025, 3, 10)),
        'tip': 'Allow at least 2 hours for a thorough visit.',
      },
      {
        'placeId': '3',
        'userId': 'demo_user',
        'userName': 'Sarah Johnson',
        'rating': 5.0,
        'text': 'Lalibela is breathtaking. The rock-hewn churches are an absolute wonder of the world.',
        'date': Timestamp.fromDate(DateTime(2025, 4, 5)),
        'tip': 'Wear comfortable shoes - there is a lot of walking.',
      },
    ];

    for (final review in reviews) {
      await FirebaseFirestore.instance.collection('reviews').add(review);
    }
  }
}
