import 'package:flutter/material.dart';
import '../quiz/lesson_model.dart';
import '../quiz/progress_manager.dart';
import '../../core/constants/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<int, int> scores = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    scores = await ProgressManager.getAllScores();
    setState(() => _loading = false);
  }

  int get completedCount => scores.length;
  int get totalLevels => allLevels.length;
  int get totalXP {
    int xp = 0;
    for (final entry in scores.entries) {
      final level = allLevels.firstWhere((l) => l.level == entry.key,
          orElse: () => allLevels.first);
      final passed = entry.value >= (level.questions.length / 2).ceil();
      xp += passed ? 100 : entry.value * 10;
    }
    return xp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            if (_loading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryCards(),
                      const SizedBox(height: 24),
                      _buildOverallProgress(),
                      const SizedBox(height: 24),
                      const Text(
                        'Level Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...allLevels.map((level) => _LevelProgressCard(
                            levelData: level,
                            score: scores[level.level],
                          )),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              '📊 My Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Reset Progress?'),
                  content: const Text(
                      'This will delete all your scores. This cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await ProgressManager.resetProgress();
                _load();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            icon: '🏆',
            value: '$completedCount / $totalLevels',
            label: 'Levels Done',
            color: AppColors.success,
            lightColor: AppColors.successLight,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: '⚡',
            value: '$totalXP XP',
            label: 'Total Earned',
            color: AppColors.warning,
            lightColor: AppColors.warningLight,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: '🎯',
            value: completedCount == 0
                ? '—'
                : '${(scores.values.fold(0, (a, b) => a + b) / (completedCount * (allLevels.isNotEmpty ? allLevels.first.questions.length : 1) * 100) * 100).round()}%',
            label: 'Avg Score',
            color: AppColors.levelColor(1),
            lightColor: AppColors.levelLight(1),
          ),
        ),
      ],
    );
  }

  Widget _buildOverallProgress() {
    final progress = totalLevels == 0 ? 0.0 : completedCount / totalLevels;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overall completion',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: AppColors.xpBarBg,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedCount of $totalLevels levels completed',
            style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String icon, value, label;
  final Color color, lightColor;

  const _SummaryCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelProgressCard extends StatelessWidget {
  final LevelData levelData;
  final int? score;

  const _LevelProgressCard({required this.levelData, required this.score});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.levelColor(levelData.level);
    final lightColor = AppColors.levelLight(levelData.level);
    final completed = score != null;
    final passed = completed &&
        score! >= (levelData.questions.length / 2).ceil();
    final percent = completed
        ? ((score! / levelData.questions.length) * 100).round()
        : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: completed
              ? (passed
                  ? AppColors.success.withValues(alpha: 0.4)
                  : AppColors.warning.withValues(alpha: 0.4))
              : AppColors.cardBorder,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: completed ? lightColor : AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: completed ? color.withValues(alpha: 0.3) : AppColors.cardBorder,
              ),
            ),
            child: Center(
              child: completed
                  ? Text(levelData.emoji, style: const TextStyle(fontSize: 24))
                  : const Icon(Icons.lock_outline, color: AppColors.textMuted, size: 22),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level ${levelData.level}: ${levelData.title}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                if (completed) ...[
                  Text(
                    '$score / ${levelData.questions.length} correct  •  $percent%',
                    style: TextStyle(
                      fontSize: 13,
                      color: passed ? AppColors.success : AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: score! / levelData.questions.length,
                      minHeight: 6,
                      backgroundColor: AppColors.xpBarBg,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          passed ? AppColors.success : AppColors.warning),
                    ),
                  ),
                ] else
                  const Text(
                    'Not attempted yet',
                    style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (completed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: passed ? AppColors.successLight : AppColors.warningLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                passed ? '✅ Pass' : '⚠️ Retry',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: passed ? AppColors.success : AppColors.warning,
                ),
              ),
            ),
        ],
      ),
    );
  }
}