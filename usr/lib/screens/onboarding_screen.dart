import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/user_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();

  void _startLearning() {
    if (_nameController.text.trim().isNotEmpty) {
      UserData.shared().name = _nameController.text.trim();
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('অনুগ্রহ করে আপনার নাম লিখুন')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 100, color: AppTheme.primaryGreen),
              const SizedBox(height: 24),
              Text(
                'ইংলিশ মাস্টার',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.primaryGreen,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AI-Powered English Learning App',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.darkGreen,
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'আপনার নাম লিখুন',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _startLearning,
                child: const Text('শুরু করুন'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
