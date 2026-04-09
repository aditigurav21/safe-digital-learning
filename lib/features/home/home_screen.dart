import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildStreakBanner(),
              const SizedBox(height: 24),
              _buildSectionTitle('🎮 Missions'),
              const SizedBox(height: 12),
              _buildMissionCards(context),
              const SizedBox(height: 24),
              _buildSectionTitle('📊 Your Progress'),
              const SizedBox(height: 12),
              _buildProgressCard(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guardian Path',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Stay safe. Stay smart. 🛡️',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF6B35).withOpacity(0.4),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.person, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A3A5C), Color(0xFF0F2744)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF2A5A8C), width: 1),
      ),
      child: Row(
        children: [
          Text('🔥', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3 Day Streak!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Text(
                'Keep it up — you\'re on fire!',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFFF6B35).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFFFF6B35).withOpacity(0.4)),
            ),
            child: Text(
              '+10 XP',
              style: TextStyle(
                color: Color(0xFFFF6B35),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  Widget _buildMissionCards(BuildContext context) {
    final missions = [
      _MissionData(
        icon: '🔐',
        title: 'Account Setup',
        subtitle: 'Simulation 1',
        description: 'Learn to create strong, secure accounts',
        color1: Color(0xFF6C63FF),
        color2: Color(0xFF9B59B6),
        route: '/create-account',
        xp: '50 XP',
        difficulty: 'Beginner',
      ),
      _MissionData(
        icon: '🕵️',
        title: 'Scam Detection',
        subtitle: 'Simulation 2',
        description: 'Spot and avoid online scams',
        color1: Color(0xFF00B894),
        color2: Color(0xFF00CEC9),
        route: '/sim2-intro',
        xp: '75 XP',
        difficulty: 'Intermediate',
      ),
      _MissionData(
        icon: '🧠',
        title: 'Safety Quiz',
        subtitle: 'Level Challenge',
        description: 'Test your digital safety knowledge',
        color1: Color(0xFFFF6B35),
        color2: Color(0xFFFF8E53),
        route: '/levels',
        xp: '100 XP',
        difficulty: 'All Levels',
      ),
    ];

    return Column(
      children: missions
          .map((m) => _MissionCard(mission: m))
          .toList(),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A3A5C), Color(0xFF0F2744)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF2A5A8C), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/dashboard'),
                child: Text(
                  'View Dashboard →',
                  style: TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatChip(label: '3', sublabel: 'Lessons Done', icon: '✅'),
              const SizedBox(width: 12),
              _StatChip(label: '225', sublabel: 'Total XP', icon: '⚡'),
              const SizedBox(width: 12),
              _StatChip(label: '2', sublabel: 'Badges', icon: '🏅'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Daily Goal',
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.6,
              minHeight: 10,
              backgroundColor: Color(0xFF0D1B2A),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '3 / 5 missions completed today',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _MissionData {
  final String icon, title, subtitle, description, route, xp, difficulty;
  final Color color1, color2;
  const _MissionData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.color1,
    required this.color2,
    required this.route,
    required this.xp,
    required this.difficulty,
  });
}

class _MissionCard extends StatelessWidget {
  final _MissionData mission;
  const _MissionCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, mission.route),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Color(0xFF122335),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF1E3A54), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon bubble
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mission.color1, mission.color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: mission.color1.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(mission.icon, style: TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 16),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mission.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: mission.color1.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          mission.difficulty,
                          style: TextStyle(
                            color: mission.color1,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    mission.description,
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // XP badge + arrow
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: mission.color1.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: mission.color1.withOpacity(0.3), width: 1),
                  ),
                  child: Text(
                    mission.xp,
                    style: TextStyle(
                      color: mission.color1,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Icon(Icons.arrow_forward_ios,
                    color: Colors.white24, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label, sublabel, icon;
  const _StatChip(
      {required this.label, required this.sublabel, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFF0D1B2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(icon, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Text(
              sublabel,
              style: TextStyle(color: Colors.white38, fontSize: 9),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}