import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessage {
  final String role;
  final String text;
  final DateTime timestamp;

  const ChatMessage({
    required this.role,
    required this.text,
    required this.timestamp,
  });
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final String placeName;

  ChatNotifier(this.placeName) : super(const ChatState());

  final _demoResponses = const {
    'adwa': 'The Battle of Adwa (March 1, 1896) was a pivotal moment in African history. Ethiopian forces under Emperor Menelik II and Empress Taytu defeated the Italian army, preserving Ethiopia\'s sovereignty. This victory inspired independence movements across Africa and the African diaspora. The Adwa Victory Memorial Museum in Addis Ababa commemorates this triumph with dioramas, oral histories, and artifacts.',
    'lalibela': 'The Rock-Hewn Churches of Lalibela are a UNESCO World Heritage Site featuring eleven medieval monolithic churches carved from living rock in the 12th-13th centuries. Commissioned by King Lalibela, they were designed as a "New Jerusalem." Bete Giyorgis (Church of St. George), with its iconic cross-shaped plan, is considered the masterpiece.',
    'lucy': 'Lucy (Dinkinesh) is a 3.2-million-year-old Australopithecus afarensis fossil discovered in Hadar, Ethiopia in 1974 by Donald Johanson\'s team. She is one of the most important finds in human origins research, standing about 1 meter tall and walking upright. You can see her at the National Museum of Ethiopia in Addis Ababa.',
    'axum': 'Axum was the capital of the ancient Aksumite Empire, a major Red Sea trading power. The city features towering stelae (obelisks), royal tombs, and the Church of Our Lady Mary of Zion, where tradition holds the Ark of the Covenant is kept. King Ezana adopted Christianity here in the 4th century, making Ethiopia one of the earliest Christian states.',
    'gondar': 'Fasil Ghebbi in Gondar is a UNESCO fortress-city of castles, churches, and baths built by the Gondarine emperors starting in the 17th century. Emperor Fasilides founded Gondar as Ethiopia\'s capital in 1636. The complex earned Gondar the nickname "Camelot of Africa." Fasilides Bath is still used for Timkat (Epiphany) celebrations.',
    'harar': 'Harar Jugol is a historic Islamic city with 82 mosques, 102 shrines, and colorful houses within ancient walls. It was a major center of trade and Islamic learning in the Horn of Africa. UNESCO designated it a World Heritage Site in 2006. The city is also famous for its hyena feeding tradition.',
    'default': 'Ethiopia is home to nine UNESCO World Heritage Sites and some of the most important archaeological discoveries in human history. From the rock-hewn churches of Lalibela to the ancient obelisks of Axum, Ethiopia\'s heritage spans millennia of civilization. Ask me about any specific site or artifact!',
  };

  Future<void> sendMessage(String text) async {
    final userMessage = ChatMessage(
      role: 'user',
      text: text,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    // Simulate AI thinking delay
    await Future.delayed(const Duration(milliseconds: 800));

    final response = _generateResponse(text);

    final aiMessage = ChatMessage(
      role: 'assistant',
      text: response,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      messages: [...state.messages, aiMessage],
      isLoading: false,
    );
  }

  String _generateResponse(String query) {
    final q = query.toLowerCase();

    if (q.contains('adwa') || q.contains('battle') || q.contains('1896')) {
      return _demoResponses['adwa']!;
    }
    if (q.contains('lalibela') || q.contains('rock') || q.contains('church')) {
      return _demoResponses['lalibela']!;
    }
    if (q.contains('lucy') || q.contains('dinkinesh') || q.contains('fossil') || q.contains('human')) {
      return _demoResponses['lucy']!;
    }
    if (q.contains('axum') || q.contains('aksum') || q.contains('stelae') || q.contains('obelisk')) {
      return _demoResponses['axum']!;
    }
    if (q.contains('gondar') || q.contains('castle') || q.contains('fasilides')) {
      return _demoResponses['gondar']!;
    }
    if (q.contains('harar') || q.contains('jugol') || q.contains('mosque')) {
      return _demoResponses['harar']!;
    }

    if (placeName.isNotEmpty) {
      return 'Welcome to $placeName! This is a remarkable heritage site with deep historical significance. Feel free to ask me about its history, exhibits, or nearby attractions. I can also help translate information to Amharic or other languages.';
    }

    return _demoResponses['default']!;
  }

  void clearChat() {
    state = const ChatState();
  }
}

final chatProvider = StateNotifierProvider.family<ChatNotifier, ChatState, Map<String, String>>(
  (ref, params) => ChatNotifier(
    params['placeName'] ?? '',
  ),
);
