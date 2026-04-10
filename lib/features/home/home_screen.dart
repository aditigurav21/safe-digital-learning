import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/services/chatbot_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ✅ MERGED APPBAR (TITLE + LOGOUT)
      appBar: AppBar(
        title: const Text("Guardian Path"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),

      // ✅ CHATBOT BUTTON (KEPT)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatbotScreen(),
            ),
          );
        },
        child: const Icon(Icons.chat),
      ),

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
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Stay safe. Stay smart. 🛡️',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryLight,
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.levelLight(1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '3 Day Streak! Keep going!',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            '+10 P',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
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
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildMissionCards(BuildContext context) {
    final missions = [
      _MissionData(
        icon: '🔐',
        title: 'Gov Scheme Scam Simulation',
        description: 'Create strong accounts',
        color: AppColors.level1,
        route: '/sim1-intro',
      ),
      _MissionData(
        icon: '🕵️',
        title: 'Social Media Scam Simulation',
        description: 'Avoid scams on social media',
        color: AppColors.level2,
        route: '/sim2-intro',
      ),
      _MissionData(
        icon: '💼',
        title: 'Job Scam Simulation',
        description: 'Identify fake jobs',
        color: AppColors.level4,
        route: '/sim3-intro',
      ),
      _MissionData(
        icon: '🛡️',
        title: 'Health Insurance Scam Simulation',
        description: 'Identify fake insurance',
        color: Colors.teal,
        route: '/sim4-intro',
      ),
      _MissionData(
        icon: '🧠',
        title: 'Safety Quiz',
        description: 'Test knowledge',
        color: AppColors.level3,
        route: '/levels',
      ),
    ];

    return Column(
      children: missions.map((m) => _MissionCard(m)).toList(),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Progress',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              _StatChip('3', 'Lessons', '✅'),
              _StatChip('225', 'P', '⚡'),
              _StatChip('2', 'Badges', '🏅'),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.6,
              minHeight: 10,
              backgroundColor: AppColors.xpBarBg,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- SUPPORT CLASSES ----------

class _MissionData {
  final String icon, title, description, route;
  final Color color;

  _MissionData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.route,
  });
}

class _MissionCard extends StatelessWidget {
  final _MissionData m;
  const _MissionCard(this.m);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, m.route),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: m.color.withOpacity(0.2), // ✅ FIXED
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(m.icon, style: const TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                m.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, m.route),
              child: const Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value, label, icon;
  const _StatChip(this.value, this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(icon),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}