import 'package:flutter/material.dart';
import 'lesson_model.dart';
import 'lesson_screen.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

/// This screen is now a "preview" before the lesson.
/// It shows level info and a "Start Lesson" button.
class LevelIntroScreen extends StatelessWidget {
  final LevelData levelData;
  const LevelIntroScreen({required this.levelData});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.levelColor(levelData.level);
    final lightColor = AppColors.levelLight(levelData.level);

    return Scaffold(
      backgroundColor: AppColors.background,
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
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textSecondary),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Emoji hero
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: lightColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: color.withValues(alpha:0.3), width: 2),
                      ),
                      child: Center(
                        child: Text(levelData.emoji, style: const TextStyle(fontSize: 54)),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Level badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color.withValues(alpha:0.4)),
                      ),
                      child: Text(
                        'LEVEL ${levelData.level}',
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
                      levelData.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      levelData.description,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Stats
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _InfoChip(icon: '📖', label: '${levelData.lessonPages.length} lessons'),
                          Container(width: 1, height: 32, color: AppColors.cardBorder),
                          _InfoChip(icon: '❓', label: '${levelData.questions.length} questions'),
                          Container(width: 1, height: 32, color: AppColors.cardBorder),
                          const _InfoChip(icon: '⚡', label: '100 XP'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Start button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LessonScreen(levelData: levelData),
                    ),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    shadowColor: color.withValues(alpha:0.4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Lesson →',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(
                    'Maybe later',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 15),
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
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
