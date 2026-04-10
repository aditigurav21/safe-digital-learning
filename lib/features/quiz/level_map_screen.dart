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
      MaterialPageRoute(builder: (_) => LessonScreen(levelData: levelData)),
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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.2),
              child: Text(levelData.emoji, style: const TextStyle(fontSize: 26)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level ${levelData.level}: ${levelData.title}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(levelData.subtitle),
                  if (completed)
                    Text(
                      "Score: $score",
                      style: const TextStyle(color: Colors.green),
                    ),
                ],
              ),
            ),
            completed
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.play_arrow),
          ],
        ),
      ),
    );
  }
}