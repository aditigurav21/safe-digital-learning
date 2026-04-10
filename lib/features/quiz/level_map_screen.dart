import 'package:flutter/material.dart';
import 'lesson_model.dart';
import 'level_intro_screen.dart';
import 'progress_manager.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class LevelMapScreen extends StatefulWidget {
  const LevelMapScreen({super.key});

  @override
  State<LevelMapScreen> createState() => _LevelMapScreenState();
}

class _LevelMapScreenState extends State<LevelMapScreen> {
  Map<int, int> scores = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    scores = await ProgressManager.getAllScores();
    setState(() {
      _loading = false;
    });
  }

  void onLevelTap(int level) async {
    final levelData = allLevels[level - 1];

    final int? score = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => LevelIntroScreen(levelData: levelData)),
    );

    if (score != null) {
      await ProgressManager.saveScore(level, score);

      setState(() {
        scores[level] = score;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Level $level completed! Score: $score"),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: List.generate(allLevels.length, (i) {
                  final level = i + 1;

                  return _LevelCard(
                    levelData: allLevels[i],
                    completed: scores.containsKey(level),
                    score: scores[level],
                    onTap: () => onLevelTap(level),
                  );
                }),
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
              '🛡️ SafeLearn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final done = scores.length;
    final total = allLevels.length;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LinearProgressIndicator(
        value: done / total,
        minHeight: 10,
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final LevelData levelData;
  final bool completed;
  final int? score;
  final VoidCallback onTap;

  const _LevelCard({
    required this.levelData,
    required this.completed,
    required this.score,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.levelColor(levelData.level);
    final lightColor = color.withValues(alpha: 0.12);

    // Levels are always unlocked
    const bool unlocked = true;
    const bool isCurrent = false;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: completed
                ? AppColors.success.withValues(alpha: 0.4)
                : AppColors.cardBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              // Level icon circle
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: lightColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: completed
                      ? const Icon(Icons.check_circle_rounded,
                          color: AppColors.success, size: 32)
                      : Text(levelData.emoji,
                          style: const TextStyle(fontSize: 30)),
                ),
              ),

              const SizedBox(width: 16),

              // Title & description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppStrings.levelPrefix} ${levelData.level}: ${levelData.title}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      levelData.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Info chips
                    Wrap(
                      spacing: 8,
                      children: [
                        _InfoChip(
                          icon: Icons.menu_book,
                          label: '${levelData.lessonPages.length} pages',
                          color: color,
                        ),
                        _InfoChip(
                          icon: Icons.quiz,
                          label: '${levelData.questions.length} questions',
                          color: color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Icon(Icons.chevron_right_rounded, color: color, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}