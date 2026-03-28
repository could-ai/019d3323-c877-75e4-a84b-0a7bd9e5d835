import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserData user = UserData.shared();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ড্যাশবোর্ড'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatsRow(),
            const SizedBox(height: 24),
            Text('লেভেল সমূহ', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildLevelCard('Basic', 'প্রাথমিক স্তর', true, 0.75),
            _buildLevelCard('Medium', 'মধ্যম স্তর', false, 0.0),
            _buildLevelCard('Hard', 'কঠিন স্তর', false, 0.0),
            _buildLevelCard('Extra Hard', 'অধিক কঠিন স্তর', false, 0.0),
            _buildLevelCard('Expert', 'বিশেষজ্ঞ স্তর', false, 0.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppTheme.primaryGreen,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('স্বাগতম, ${user.name}!', style: Theme.of(context).textTheme.titleLarge),
            Text('চলুন ইংরেজি শিখি', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem(Icons.local_fire_department, '${user.streak} দিন', AppTheme.amber, 'স্ট্রিক'),
        _buildStatItem(Icons.star, '${user.xp} XP', AppTheme.blue, 'পয়েন্ট'),
        _buildStatItem(Icons.favorite, '${user.hearts}', AppTheme.red, 'হার্ট'),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLevelCard(String title, String subtitle, bool isUnlocked, double progress) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        onTap: isUnlocked ? () => Navigator.pushNamed(context, '/quiz') : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isUnlocked ? AppTheme.lightGreen : Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isUnlocked ? Icons.play_arrow : Icons.lock,
                  color: isUnlocked ? AppTheme.primaryGreen : Colors.grey,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isUnlocked ? AppTheme.textDark : Colors.grey,
                    )),
                    Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    )),
                    if (isUnlocked) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
