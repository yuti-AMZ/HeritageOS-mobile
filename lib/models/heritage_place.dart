import 'package:cloud_firestore/cloud_firestore.dart';

class HeritagePlace {
  final String id;
  final String name;
  final String country;
  final String city;
  final String category;
  final String description;
  final String imageUrl;
  final String? videoUrl;
  final double rating;
  final int reviewCount;
  final String openingHours;
  final String ticketInfo;
  final String contact;
  final double latitude;
  final double longitude;
  final List<String> photos;
  final bool isFeatured;
  final List<Exhibit> exhibits;
  final List<TimelineEvent> timeline;

  const HeritagePlace({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.videoUrl,
    required this.rating,
    required this.reviewCount,
    required this.openingHours,
    required this.ticketInfo,
    required this.contact,
    required this.latitude,
    required this.longitude,
    this.photos = const [],
    this.isFeatured = false,
    this.exhibits = const [],
    this.timeline = const [],
  });

  factory HeritagePlace.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return HeritagePlace(
      id: doc.id,
      name: data['name'] ?? '',
      country: data['country'] ?? '',
      city: data['city'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      videoUrl: data['videoUrl'],
      rating: (data['rating'] ?? 0).toDouble(),
      reviewCount: data['reviewCount'] ?? 0,
      openingHours: data['openingHours'] ?? '',
      ticketInfo: data['ticketInfo'] ?? '',
      contact: data['contact'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      photos: List<String>.from(data['photos'] ?? []),
      isFeatured: data['isFeatured'] ?? false,
      timeline: (data['timeline'] as List<dynamic>?)
              ?.map((e) => TimelineEvent.fromMap(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'city': city,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'openingHours': openingHours,
      'ticketInfo': ticketInfo,
      'contact': contact,
      'latitude': latitude,
      'longitude': longitude,
      'photos': photos,
      'isFeatured': isFeatured,
      'timeline': timeline.map((e) => e.toMap()).toList(),
    };
  }
}

class Exhibit {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final String? audioUrl;
  final String? qrCode;
  final List<String> relatedExhibits;

  const Exhibit({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.audioUrl,
    this.qrCode,
    this.relatedExhibits = const [],
  });

  factory Exhibit.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Exhibit(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      audioUrl: data['audioUrl'],
      qrCode: data['qrCode'],
      relatedExhibits: List<String>.from(data['relatedExhibits'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'audioUrl': audioUrl,
      'qrCode': qrCode,
      'relatedExhibits': relatedExhibits,
    };
  }
}

class TimelineEvent {
  final String year;
  final String title;
  final String description;
  final String? imageUrl;

  const TimelineEvent({
    required this.year,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  factory TimelineEvent.fromMap(Map<String, dynamic> map) {
    return TimelineEvent(
      year: map['year'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}

class MockReview {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String text;
  final DateTime date;
  final String? tip;

  const MockReview({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.text,
    required this.date,
    this.tip,
  });
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool isUnlocked;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
  });
}
