import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final int level;
  final bool passed;

  ResultScreen({required this.score, required this.total, required this.level, required this.passed});

  @override
  Widget build(BuildContext context) {
    final int percent = ((score / total) * 100).round();

    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result emoji
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: passed
                      ? Color(0xFF00B894).withOpacity(0.15)
                      : Color(0xFFFF6B35).withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: passed
                        ? Color(0xFF00B894).withOpacity(0.4)
                        : Color(0xFFFF6B35).withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: passed
                          ? Color(0xFF00B894).withOpacity(0.3)
                          : Color(0xFFFF6B35).withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    passed ? '🏆' : '💪',
                    style: TextStyle(fontSize: 52),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                passed ? 'You Passed!' : 'Keep Going!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                passed
                    ? 'Amazing work! Level ${level + 1} is now unlocked.'
                    : 'You scored $score/$total. Try again to pass!',
                style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.4),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 36),

              // Score display
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color(0xFF122335),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF1E3A54)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(value: '$score/$total', label: 'Score', icon: '⭐'),
                    _Divider(),
                    _StatItem(value: '$percent%', label: 'Accuracy', icon: '🎯'),
                    _Divider(),
                    _StatItem(
                      value: passed ? '+100' : '+${score * 20}',
                      label: 'XP Earned',
                      icon: '⚡',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Primary button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()
                      ..pop(passed);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: passed ? Color(0xFF00B894) : Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    passed ? '🚀 Next Level' : '🔄 Try Again',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  child: Text(
                    'Back to Home',
                    style: TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label, icon;
  const _StatItem({required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: TextStyle(fontSize: 20)),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
        Text(label, style: TextStyle(color: Colors.white38, fontSize: 11)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: Color(0xFF1E3A54));
  }
}