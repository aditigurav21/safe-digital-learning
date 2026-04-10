import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Guardian Path")),
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

              // const SizedBox(height: 24),
              // _buildSectionTitle('⚡ Quick Actions'),
              // const SizedBox(height: 12),
              // _buildExtraButtons(context),

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
        description: 'Avoid scams',
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

  // ✅ All buttons from other branch preserved here
  // Widget _buildExtraButtons(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: Column(
  //       children: [
  //         ElevatedButton(
  //           onPressed: () => Navigator.pushNamed(context, '/create-account'),
  //           child: const Text("Simulation 1 (Account Setup)"),
  //         ),
  //         const SizedBox(height: 10),
  //         ElevatedButton(
  //           onPressed: () => Navigator.pushNamed(context, '/sim2-intro'),
  //           child: const Text("Simulation 2 (Scam Detection)"),
  //         ),
  //         const SizedBox(height: 10),
  //         ElevatedButton(
  //           onPressed: () => Navigator.pushNamed(context, '/sim3-intro'),
  //           child: const Text("Simulation 3 (Job Scam)"),
  //         ),
  //         const SizedBox(height: 10),
  //         ElevatedButton(
  //           onPressed: () => Navigator.pushNamed(context, '/quiz'),
  //           child: const Text("Quiz"),
  //         ),
  //         const SizedBox(height: 10),
  //         ElevatedButton(
  //           onPressed: () => Navigator.pushNamed(context, '/dashboard'),
  //           child: const Text("Dashboard"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

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
                color: m.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(m.icon, style: const TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    m.description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, m.route),
              child: const Text("Start"),
            ),

            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios,
                size: 14, color: AppColors.textMuted),
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
