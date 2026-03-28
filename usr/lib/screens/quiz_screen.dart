import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/user_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int hearts = 2;
  int score = 0;
  bool? isCorrect;
  String? selectedAnswer;

  final List<Map<String, dynamic>> questions = [
    {
      'type': 'word_to_meaning',
      'question': 'Apple',
      'options': ['কলা', 'আপেল', 'কমলা', 'আঙ্গুর'],
      'answer': 'আপেল',
      'ipa': '/ˈæp.əl/',
      'example': 'I eat an apple every day.',
      'translation': 'আমি প্রতিদিন একটি আপেল খাই।'
    },
    {
      'type': 'translation',
      'question': 'আমি স্কুলে যাই',
      'options': ['I go to school', 'I went to school', 'I am going to school', 'I will go to school'],
      'answer': 'I go to school',
      'ipa': '',
      'example': '',
      'translation': ''
    },
    {
      'type': 'fill_blank',
      'question': 'He ___ a good boy.',
      'options': ['am', 'is', 'are', 'were'],
      'answer': 'is',
      'ipa': '',
      'example': '',
      'translation': ''
    }
  ];

  void _checkAnswer(String option) {
    if (selectedAnswer != null) return;

    setState(() {
      selectedAnswer = option;
      if (option == questions[currentQuestionIndex]['answer']) {
        isCorrect = true;
        score += 10;
      } else {
        isCorrect = false;
        hearts--;
      }
    });

    if (hearts <= 0) {
      _showGameOverDialog();
    } else {
      _showFeedbackBottomSheet();
    }
  }

  void _nextQuestion() {
    Navigator.pop(context); // Close bottom sheet
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        isCorrect = null;
      });
    } else {
      UserData.shared().xp += score;
      Navigator.pushReplacementNamed(context, '/result', arguments: score);
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('গেম ওভার!'),
        content: const Text('আপনার সব হার্ট শেষ হয়ে গেছে। আবার চেষ্টা করুন।'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('ফিরে যান'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: isCorrect! ? AppTheme.lightGreen : const Color(0xFFFFEBEE),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCorrect! ? Icons.check_circle : Icons.cancel,
                  color: isCorrect! ? AppTheme.primaryGreen : AppTheme.red,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  isCorrect! ? 'সঠিক উত্তর!' : 'ভুল হয়েছে!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isCorrect! ? AppTheme.primaryGreen : AppTheme.red,
                  ),
                ),
              ],
            ),
            if (!isCorrect!) ...[
              const SizedBox(height: 16),
              Text('সঠিক উত্তর: ${questions[currentQuestionIndex]['answer']}', 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              if (questions[currentQuestionIndex]['ipa'] != '') ...[
                Text('উচ্চারণ: ${questions[currentQuestionIndex]['ipa']}'),
                Text('উদাহরণ: ${questions[currentQuestionIndex]['example']}'),
              ]
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isCorrect! ? AppTheme.primaryGreen : AppTheme.red,
              ),
              onPressed: _nextQuestion,
              child: const Text('পরবর্তী'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textDark),
        title: Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.favorite, color: AppTheme.red),
            const SizedBox(width: 4),
            Text('$hearts', style: const TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question['type'] == 'word_to_meaning' ? 'এর বাংলা অর্থ কী?' : 
              question['type'] == 'translation' ? 'ইংরেজিতে অনুবাদ করুন:' : 'শূন্যস্থান পূরণ করুন:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            Text(
              question['question'],
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ...(question['options'] as List<String>).map((option) {
              bool isSelected = selectedAnswer == option;
              Color bgColor = Colors.white;
              Color borderColor = Colors.grey[300]!;
              
              if (selectedAnswer != null) {
                if (option == question['answer']) {
                  bgColor = AppTheme.lightGreen;
                  borderColor = AppTheme.primaryGreen;
                } else if (isSelected) {
                  bgColor = const Color(0xFFFFEBEE);
                  borderColor = AppTheme.red;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  onTap: () => _checkAnswer(option),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      option,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
