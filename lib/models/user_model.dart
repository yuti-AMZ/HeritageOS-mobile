import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String preferredLanguage;
  final List<String> savedPlaceIds;
  final DateTime createdAt;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.preferredLanguage = 'en',
    this.savedPlaceIds = const [],
    required this.createdAt,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'],
      preferredLanguage: data['preferredLanguage'] ?? 'en',
      savedPlaceIds: List<String>.from(data['savedPlaceIds'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'preferredLanguage': preferredLanguage,
      'savedPlaceIds': savedPlaceIds,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  UserProfile copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? preferredLanguage,
    List<String>? savedPlaceIds,
  }) {
    return UserProfile(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      savedPlaceIds: savedPlaceIds ?? this.savedPlaceIds,
      createdAt: createdAt,
    );
  }
}
