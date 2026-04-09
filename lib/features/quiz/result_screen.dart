import 'package:flutter/material.dart';
import 'lesson_model.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final LevelData levelData;
  final bool passed;

  const ResultScreen({
    required this.score,
    required this.total,
    required this.levelData,
    required this.passed,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _scaleAnim = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color get levelColor => AppColors.levelColor(widget.levelData.level);
  int get percent => ((widget.score / widget.total) * 100).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Trophy / retry emoji
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: widget.passed
                        ? AppColors.successLight
                        : AppColors.warningLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.passed
                          ? AppColors.success.withOpacity(0.4)
                          : AppColors.warning.withOpacity(0.4),
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.passed ? '🏆' : '💪',
                      style: const TextStyle(fontSize: 60),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    Text(
                      widget.passed ? AppStrings.wellDone : AppStrings.keepTrying,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      widget.passed
                          ? 'You completed Level ${widget.levelData.level}!\nLevel ${widget.levelData.level + 1} is now unlocked.'
                          : 'You scored ${widget.score} out of ${widget.total}.\nRead the lesson again and try once more!',
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Score card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.cardBorder),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            icon: '⭐',
                            value: '${widget.score}/${widget.total}',
                            label: AppStrings.score,
                          ),
                          Container(width: 1, height: 48, color: AppColors.cardBorder),
                          _StatItem(
                            icon: '🎯',
                            value: '$percent%',
                            label: AppStrings.accuracy,
                          ),
                          Container(width: 1, height: 48, color: AppColors.cardBorder),
                          _StatItem(
                            icon: '⚡',
                            value: widget.passed ? '+100' : '+${widget.score * 10}',
                            label: AppStrings.xpEarned,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Primary button
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {
                          // Pop both ResultScreen and QuizScreen, return passed to LevelMap
                          Navigator.of(context)
                            ..pop()
                            ..pop(widget.passed);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.passed ? AppColors.success : levelColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          shadowColor: (widget.passed ? AppColors.success : levelColor).withOpacity(0.4),
                        ),
                        child: Text(
                          widget.passed ? AppStrings.nextLevel : AppStrings.retryQuiz,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                        child: const Text(
                          AppStrings.backHome,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
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

class _StatItem extends StatelessWidget {
  final String icon, value, label;
  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      ],
    );
  }
}