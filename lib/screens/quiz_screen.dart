import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _current = 0;
  int? _selected;
  bool _answered = false;
  int _score = 0;

  final _questions = const [
    _QuizQ(
        question: 'In which year was the Battle of Adwa fought?',
        options: ['1889', '1896', '1936', '1941'],
        correct: 1),
    _QuizQ(
        question: 'Who led Ethiopian forces at the Battle of Adwa?',
        options: ['Haile Selassie', 'Tewodros II', 'Menelik II', 'Yohannes IV'],
        correct: 2),
    _QuizQ(
        question: 'Lucy (Dinkinesh) was discovered in which Ethiopian region?',
        options: ['Oromia', 'Afar', 'Tigray', 'Amhara'],
        correct: 1),
    _QuizQ(
        question: 'The rock-hewn churches of Lalibela were built under which king?',
        options: ['Ezana', 'Fasilides', 'Lalibela', 'Menelik II'],
        correct: 2),
    _QuizQ(
        question: 'Axum was the capital of which ancient empire?',
        options: ['Aksumite', 'Zagwe', 'Solomonic', 'Ottoman'],
        correct: 0),
  ];

  void _answer(int idx) {
    if (_answered) return;
    setState(() {
      _selected = idx;
      _answered = true;
      if (idx == _questions[_current].correct) _score++;
    });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() {
        _current++;
        _selected = null;
        _answered = false;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events_rounded,
                size: 56, color: AppColors.gold),
            const SizedBox(height: 12),
            const Text('Quiz Complete!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.green)),
            const SizedBox(height: 8),
            Text('You scored $_score / ${_questions.length}',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.green.withOpacity(0.6))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Done',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: AppColors.sand,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 16, color: AppColors.green),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Daily Quiz',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('$_score pts',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)),
                  ),
                ],
              ),
            ),

            // Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Question ${_current + 1} of ${_questions.length}',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.green.withOpacity(0.5))),
                      Text('${((_current + 1) / _questions.length * 100).round()}%',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_current + 1) / _questions.length,
                      backgroundColor: AppColors.sand,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.gold),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(q.question,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green)),
            ),

            const SizedBox(height: 24),

            // Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(q.options.length, (i) {
                  Color bg = AppColors.sand;
                  Color textCol = AppColors.green;
                  IconData? icon;

                  if (_answered) {
                    if (i == q.correct) {
                      bg = const Color(0xFFE8F5E9);
                      textCol = const Color(0xFF2E7D32);
                      icon = Icons.check_circle_rounded;
                    } else if (i == _selected) {
                      bg = const Color(0xFFFFEBEE);
                      textCol = const Color(0xFFC62828);
                      icon = Icons.cancel_rounded;
                    }
                  }

                  return GestureDetector(
                    onTap: () => _answer(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: _selected == i
                                  ? AppColors.gold
                                  : Colors.transparent,
                              width: 1.5)),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: _selected == i
                                    ? AppColors.gold
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                                child: Text(String.fromCharCode(65 + i),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: _selected == i
                                            ? AppColors.green
                                            : AppColors.green
                                                .withOpacity(0.5)))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Text(q.options[i],
                                  style: TextStyle(
                                      fontSize: 14, color: textCol))),
                          if (icon != null)
                            Icon(icon, color: textCol, size: 20),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            const Spacer(),

            // Next button
            if (_answered)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                        _current < _questions.length - 1 ? 'Next Question' : 'See Results',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _QuizQ {
  final String question;
  final List<String> options;
  final int correct;
  const _QuizQ(
      {required this.question, required this.options, required this.correct});
}
