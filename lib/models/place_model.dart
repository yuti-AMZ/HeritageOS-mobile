class Place {
  final String name;
  final String location;
  final String type;
  final double rating;
  final String imageUrl;
  final String? duration;
  final String? description;

  const Place({
    required this.name,
    required this.location,
    required this.type,
    required this.rating,
    required this.imageUrl,
    this.duration,
    this.description,
  });
}

class Event {
  final String title;
  final String venue;
  final String date;
  final String time;

  const Event({
    required this.title,
    required this.venue,
    required this.date,
    required this.time,
  });
}

class Category {
  final String icon;
  final String label;
  final int count;

  const Category({
    required this.icon,
    required this.label,
    required this.count,
  });
}

class ChatMessage {
  final String role;
  final String text;

  const ChatMessage({required this.role, required this.text});
}

class ScannedItem {
  final String name;
  final String museum;
  final String time;
  final String imageUrl;

  const ScannedItem({
    required this.name,
    required this.museum,
    required this.time,
    required this.imageUrl,
  });
}

class TimelineEntry {
  final String year;
  final String event;

  const TimelineEntry({required this.year, required this.event});
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
