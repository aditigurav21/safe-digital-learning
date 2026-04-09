import 'package:flutter/material.dart';

class LevelIntroScreen extends StatelessWidget {
  final int level;
  LevelIntroScreen({required this.level});

  static const _levelData = [
    {'emoji': '🔐', 'title': 'Password Basics', 'desc': 'Learn the first rules of staying safe online. Can you spot the right moves?', 'color': 0xFF6C63FF},
    {'emoji': '🕵️', 'title': 'Scam Spotter', 'desc': 'Phishing, fake links, suspicious messages — test your scam-detection skills.', 'color': 0xFF00B894},
    {'emoji': '🛡️', 'title': 'Privacy Guard', 'desc': 'What should you share? What should you keep secret? Protect your identity.', 'color': 0xFFFF6B35},
    {'emoji': '🌐', 'title': 'Safe Browsing', 'desc': 'Navigate the web without falling into traps. Stay one step ahead.', 'color': 0xFF0984E3},
    {'emoji': '🏆', 'title': 'Master Challenge', 'desc': 'The final test. Prove you are a true digital safety guardian!', 'color': 0xFFFFD700},
  ];

  @override
  Widget build(BuildContext context) {
    final data = level <= 5 ? _levelData[level - 1] : _levelData[0];
    final color = Color(data['color'] as int);

    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF122335),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white70, size: 18),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Big emoji
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: color.withOpacity(0.3), width: 2),
                        boxShadow: [
                          BoxShadow(color: color.withOpacity(0.3), blurRadius: 30, spreadRadius: 5),
                        ],
                      ),
                      child: Center(
                        child: Text(data['emoji'] as String, style: TextStyle(fontSize: 52)),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Level badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color.withOpacity(0.4)),
                      ),
                      child: Text(
                        'LEVEL $level',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          letterSpacing: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      data['title'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      data['desc'] as String,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // Stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _InfoChip(icon: '❓', label: '3 Questions'),
                        const SizedBox(width: 12),
                        _InfoChip(icon: '⚡', label: '100 XP'),
                        const SizedBox(width: 12),
                        _InfoChip(icon: '⏱️', label: '~2 min'),
                      ],
                    ),
                  ],
                ),
              ),

              // Start button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    shadowColor: color.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Level $level',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Skip / back
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Maybe later',
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

class _InfoChip extends StatelessWidget {
  final String icon, label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF122335),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF1E3A54)),
      ),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 14)),
          SizedBox(width: 6),
          Text(label,
              style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}