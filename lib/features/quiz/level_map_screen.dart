import 'package:flutter/material.dart';
import 'lesson_model.dart';
import 'lesson_screen.dart';
import 'progress_manager.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class LevelMapScreen extends StatefulWidget {
  const LevelMapScreen({super.key});

  @override
  State<LevelMapScreen> createState() => _LevelMapScreenState();
}

class _LevelMapScreenState extends State<LevelMapScreen> {
  int unlockedLevel = 1;
  int currentLevel = 1;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final unlocked = await ProgressManager.getUnlockedLevel();
    final current = await ProgressManager.getCurrentLevel();
    setState(() {
      unlockedLevel = unlocked;
      currentLevel = current;
      _loading = false;
    });
  }

  void onLevelTap(int level) async {
    if (level > unlockedLevel) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🔒 Complete the previous level first!'),
          backgroundColor: AppColors.locked,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final levelData = allLevels[level - 1];

    // Navigate to Lesson first
    final bool? passed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => LessonScreen(levelData: levelData)),
    );

    if (passed == true) {
      final newCurrent = (level == currentLevel && currentLevel < 5) ? currentLevel + 1 : currentLevel;
      final newUnlocked = (unlockedLevel < 5 && newCurrent > unlockedLevel) ? newCurrent : unlockedLevel;

      setState(() {
        currentLevel = newCurrent;
        unlockedLevel = newUnlocked;
      });

      await ProgressManager.saveProgress(newUnlocked, newCurrent);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.levelUnlocked(level)),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } else if (passed == false) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(AppStrings.keepGoing),
            backgroundColor: AppColors.warning,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
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
                    unlocked: level <= unlockedLevel,
                    completed: level < currentLevel,
                    isCurrent: level == currentLevel && level <= unlockedLevel,
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
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🛡️ SafeLearn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Choose a level to start',
                  style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final done = (currentLevel - 1).clamp(0, 5);
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(16),
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
              Text(
                '$done / 5 ${AppStrings.levelsComplete}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(done / 5 * 100).toInt()}% Complete',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: done / 5,
              minHeight: 12,
              backgroundColor: AppColors.xpBarBg,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.xpBar),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Level Card — replaces the path/map UI
// ──────────────────────────────────────────────
class _LevelCard extends StatelessWidget {
  final LevelData levelData;
  final bool unlocked;
  final bool completed;
  final bool isCurrent;
  final VoidCallback onTap;

  const _LevelCard({
    required this.levelData,
    required this.unlocked,
    required this.completed,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.levelColor(levelData.level);
    final lightColor = AppColors.levelLight(levelData.level);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: unlocked ? Colors.white : AppColors.lockedLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCurrent
                ? color
                : completed
                    ? AppColors.success.withOpacity(0.4)
                    : AppColors.cardBorder,
            width: isCurrent ? 2.5 : 1.5,
          ),
          boxShadow: [
            if (isCurrent)
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
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
                  color: unlocked ? lightColor : AppColors.lockedLight,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: unlocked ? color.withOpacity(0.3) : AppColors.locked.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: completed
                      ? const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 32)
                      : unlocked
                          ? Text(levelData.emoji, style: const TextStyle(fontSize: 30))
                          : const Icon(Icons.lock_rounded, color: AppColors.locked, size: 28),
                ),
              ),

              const SizedBox(width: 16),

              // Title & description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${AppStrings.levelPrefix} ${levelData.level}: ${levelData.title}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: unlocked ? AppColors.textPrimary : AppColors.locked,
                            ),
                          ),
                        ),
                        if (isCurrent) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'START',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      levelData.subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: unlocked ? AppColors.textMuted : AppColors.locked,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Info chips
                    Wrap(
                      spacing: 8,
                      children: [
                        _InfoChip(icon: Icons.menu_book, label: '${levelData.lessonPages.length} pages', color: color, unlocked: unlocked),
                        _InfoChip(icon: Icons.quiz, label: '${levelData.questions.length} questions', color: color, unlocked: unlocked),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              if (unlocked)
                Icon(Icons.chevron_right_rounded, color: color, size: 28)
              else
                const Icon(Icons.chevron_right_rounded, color: AppColors.locked, size: 28),
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
  final bool unlocked;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: unlocked ? color.withOpacity(0.1) : AppColors.lockedLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: unlocked ? color.withOpacity(0.3) : AppColors.cardBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: unlocked ? color : AppColors.locked),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: unlocked ? color : AppColors.locked,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}