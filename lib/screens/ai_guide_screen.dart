import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/place_model.dart';

class AIGuideScreen extends StatefulWidget {
  const AIGuideScreen({super.key});
  @override
  State<AIGuideScreen> createState() => _AIGuideScreenState();
}

class _AIGuideScreenState extends State<AIGuideScreen> {
  final _controller = TextEditingController();
  final _messages = <ChatMessage>[
    const ChatMessage(
        role: 'ai',
        text:
            'Selam! I\'m your Ethiopian heritage AI guide. Ask me about Adwa, Lalibela, Lucy, Axum, Gondar, or any site you\'re visiting.'),
  ];

  final _suggestions = const [
    'Tell me about the Battle of Adwa',
    'What is special about Lalibela?',
    'Who was Lucy (Dinkinesh)?',
    'Translate to Amharic',
  ];

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(role: 'user', text: _controller.text));
      _messages.add(const ChatMessage(
          role: 'ai',
          text:
              'Great question! On March 1, 1896, Ethiopian forces under Emperor Menelik II and Empress Taytu defeated Italy at Adwa — a victory that kept Ethiopia independent and inspired anti-colonial movements across Africa. Visit the Adwa Victory Memorial in Addis Ababa to see the diorama and oral histories.'));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.green,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(22)),
                      child: const Icon(Icons.auto_awesome,
                          color: AppColors.green, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Heritage AI Guide',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 4, backgroundColor: Color(0xFF4ADE80)),
                              SizedBox(width: 6),
                              Text('Online · Amharic, English & more',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white60)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language, size: 12, color: AppColors.green),
                          SizedBox(width: 4),
                          Text('EN',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                final isUser = msg.role == 'user';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment:
                        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUser) ...[
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: AppColors.gold,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Icon(Icons.auto_awesome,
                              size: 14, color: AppColors.green),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isUser ? AppColors.green : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isUser ? 20 : 5),
                              bottomRight: Radius.circular(isUser ? 5 : 20),
                            ),
                            boxShadow: isUser
                                ? null
                                : [
                                    BoxShadow(
                                        color: AppColors.green.withOpacity(0.09),
                                        blurRadius: 10)
                                  ],
                          ),
                          child: Text(msg.text,
                              style: TextStyle(
                                  fontSize: 13.5,
                                  height: 1.5,
                                  color: isUser
                                      ? Colors.white
                                      : AppColors.green)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Quick action bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: AppColors.green.withOpacity(0.05)))),
            child: Row(
              children: [
                _quickAction(Icons.headphones, 'Audio'),
                _quickAction(Icons.language, 'Translate'),
                _quickAction(Icons.image, 'Image'),
                _quickAction(Icons.book, 'Deep Dive'),
              ],
            ),
          ),

          // Input
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColors.sand,
                  borderRadius: BorderRadius.circular(22)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 13, color: AppColors.green),
                      decoration: InputDecoration(
                        hintText: AppStrings.askAboutHistory,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: AppColors.green.withOpacity(0.35)),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _controller.text.trim().isNotEmpty
                            ? AppColors.gold
                            : AppColors.sand,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        _controller.text.trim().isNotEmpty
                            ? Icons.send_rounded
                            : Icons.mic_rounded,
                        size: 16,
                        color: AppColors.green.withOpacity(
                            _controller.text.trim().isNotEmpty ? 1 : 0.47),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
            color: AppColors.sand, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, size: 14, color: AppColors.green),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.green.withOpacity(0.5))),
          ],
        ),
      ),
    );
  }
}
