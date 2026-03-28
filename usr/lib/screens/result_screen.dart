import 'package:flutter/material.dart';
import '../core/theme.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int score = ModalRoute.of(context)?.settings.arguments as int? ?? 0;

    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, size: 120, color: AppTheme.amber),
                const SizedBox(height: 24),
                const Text(
                  'অসাধারণ!',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text('আপনার স্কোর', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      Text(
                        '$score XP',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen),
                      ),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStat('সঠিক', '3', AppTheme.primaryGreen),
                          _buildStat('ভুল', '0', AppTheme.red),
                          _buildStat('সময়', '1:20', AppTheme.blue),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.darkGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.smart_toy, color: AppTheme.purple, size: 40),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '"অবিশ্বাস্য! ১০০% স্কোর! তুমি সত্যিই প্রতিভাবান! এভাবেই চালিয়ে যাও।"',
                          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryGreen,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('চালিয়ে যান'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
