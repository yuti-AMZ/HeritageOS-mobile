import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/heritage_place.dart';

class HeritagePlaceAIScreen extends StatefulWidget {
  final HeritagePlace place;
  const HeritagePlaceAIScreen({super.key, required this.place});
  @override
  State<HeritagePlaceAIScreen> createState() => _HeritagePlaceAIScreenState();
}

class _HeritagePlaceAIScreenState extends State<HeritagePlaceAIScreen> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final _suggestions = [
    'Tell me about this exhibit',
    'What is the history of this place?',
    'Any fun facts?',
    'What should I see next?',
    'Translate to Arabic',
  ];

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': _controller.text});
      _messages.add({
        'role': 'ai',
        'text': 'Great question about ${widget.place.name}! This heritage site has a rich history spanning centuries. The ${widget.place.exhibits.isNotEmpty ? widget.place.exhibits.first.name : "main exhibit"} is particularly noteworthy — it tells the story of resilience and cultural preservation that defines this place.'
      });
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
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(18)),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.auto_awesome, color: AppColors.green, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.place.name} AI Guide',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 2),
                          const Row(
                            children: [
                              CircleAvatar(radius: 4, backgroundColor: Color(0xFF4ADE80)),
                              SizedBox(width: 6),
                              Text('Context-aware · 40+ languages',
                                  style: TextStyle(fontSize: 10, color: Colors.white60)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language, size: 11, color: AppColors.green),
                          SizedBox(width: 3),
                          Text('EN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.green)),
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
            child: _messages.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Spacer(),
                        Icon(Icons.auto_awesome, size: 56, color: AppColors.gold.withOpacity(0.3)),
                        const SizedBox(height: 16),
                        Text('Ask anything about\n${widget.place.name}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.green.withOpacity(0.6))),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 8, runSpacing: 8, alignment: WrapAlignment.center,
                          children: _suggestions.map((s) => GestureDetector(
                            onTap: () { _controller.text = s; _send(); },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.06), blurRadius: 6)],
                              ),
                              child: Text(s, style: const TextStyle(fontSize: 12, color: AppColors.green)),
                            ),
                          )).toList(),
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    itemCount: _messages.length,
                    itemBuilder: (_, i) {
                      final msg = _messages[i];
                      final isUser = msg['role'] == 'user';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isUser) ...[
                              Container(
                                width: 30, height: 30,
                                decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(15)),
                                child: const Icon(Icons.auto_awesome, size: 13, color: AppColors.green),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isUser ? AppColors.green : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(18),
                                    topRight: const Radius.circular(18),
                                    bottomLeft: Radius.circular(isUser ? 18 : 4),
                                    bottomRight: Radius.circular(isUser ? 4 : 18),
                                  ),
                                  boxShadow: isUser ? null : [BoxShadow(color: AppColors.green.withOpacity(0.08), blurRadius: 8)],
                                ),
                                child: Text(msg['text']!, style: TextStyle(fontSize: 13, height: 1.5, color: isUser ? Colors.white : AppColors.green)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Input
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(22)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 13, color: AppColors.green),
                      decoration: InputDecoration(
                        hintText: 'Ask about ${widget.place.name}…',
                        hintStyle: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.35)),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: _controller.text.trim().isNotEmpty ? AppColors.gold : AppColors.sand,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Icon(
                        _controller.text.trim().isNotEmpty ? Icons.send_rounded : Icons.mic_rounded,
                        size: 16,
                        color: AppColors.green.withOpacity(_controller.text.trim().isNotEmpty ? 1 : 0.4),
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
}
