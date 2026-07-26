import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String placeId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final double rating;
  final String text;
  final DateTime date;
  final List<String> photos;
  final String? tip;

  const Review({
    required this.id,
    required this.placeId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.rating,
    required this.text,
    required this.date,
    this.photos = const [],
    this.tip,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Review(
      id: doc.id,
      placeId: data['placeId'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userAvatar: data['userAvatar'],
      rating: (data['rating'] ?? 0).toDouble(),
      text: data['text'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      photos: List<String>.from(data['photos'] ?? []),
      tip: data['tip'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'text': text,
      'date': Timestamp.fromDate(date),
      'photos': photos,
      'tip': tip,
    };
  }
}
