import 'package:dio/dio.dart';

class OpenAIService {
  static const String _baseUrl = 'https://api.openai.com/v1';
  final String apiKey;
  late final Dio _dio;

  OpenAIService({required this.apiKey}) {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    ));
  }

  Future<String> chat({
    required String systemPrompt,
    required List<Map<String, String>> messages,
    String model = 'gpt-4',
    double temperature = 0.7,
    int maxTokens = 1024,
  }) async {
    try {
      final response = await _dio.post('/chat/completions', data: {
        'model': model,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          ...messages,
        ],
        'temperature': temperature,
        'max_tokens': maxTokens,
      });

      return response.data['choices'][0]['message']['content'] as String;
    } on DioException catch (e) {
      throw Exception('AI request failed: ${e.message}');
    }
  }

  Future<String> generateDescription(String itemName, String context) async {
    return chat(
      systemPrompt: 'You are a cultural heritage expert. Generate engaging, educational descriptions for museum exhibits and heritage sites. Be accurate, vivid, and accessible to general audiences.',
      messages: [
        {'role': 'user', 'content': 'Write a detailed, engaging description for "$itemName". Context: $context'}
      ],
    );
  }

  Future<String> generateQuiz(String topic, String context) async {
    return chat(
      systemPrompt: 'You are an educational quiz generator. Create 5 multiple-choice questions about the given topic. Format: "Q1: [question]\nA) [option]\nB) [option]\nC) [option]\nD) [option]\nAnswer: [correct letter]". Make questions engaging and educational.',
      messages: [
        {'role': 'user', 'content': 'Generate a quiz about "$topic". Context: $context'}
      ],
    );
  }
}
