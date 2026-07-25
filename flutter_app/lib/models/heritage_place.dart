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
}

class AudioTrack {
  final String id;
  final String title;
  final String language;
  final Duration duration;
  final String? url;
  final bool isDetailed;

  const AudioTrack({
    required this.id,
    required this.title,
    required this.language,
    required this.duration,
    this.url,
    this.isDetailed = false,
  });
}

class Review {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String text;
  final DateTime date;
  final List<String> photos;
  final String? tip;

  const Review({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.text,
    required this.date,
    this.photos = const [],
    this.tip,
  });
}

class TourPreference {
  final int durationMinutes;
  final List<String> interests;
  final String? heritagePlaceId;

  const TourPreference({
    required this.durationMinutes,
    required this.interests,
    this.heritagePlaceId,
  });
}

class SavedPlace {
  final String placeId;
  final String placeName;
  final String imageUrl;
  final DateTime savedAt;
  final bool isFavorite;

  const SavedPlace({
    required this.placeId,
    required this.placeName,
    required this.imageUrl,
    required this.savedAt,
    this.isFavorite = true,
  });
}

class VisitorActivity {
  final String id;
  final String type;
  final String title;
  final String description;
  final int points;
  final bool isCompleted;

  const VisitorActivity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.points,
    this.isCompleted = false,
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
