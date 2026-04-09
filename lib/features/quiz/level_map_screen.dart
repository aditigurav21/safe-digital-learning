import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'level_intro_screen.dart';
import 'progress_manager.dart';

class LevelMapScreen extends StatefulWidget {
  @override
  _LevelMapScreenState createState() => _LevelMapScreenState();
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
    if (level > unlockedLevel) return;

    final bool? startQuiz = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => LevelIntroScreen(level: level)),
    );
    if (startQuiz != true) return;

    final bool? passed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(level: level)),
    );

    if (passed == true) {
      final newCurrent =
          (level == currentLevel && currentLevel < 5) ? currentLevel + 1 : currentLevel;
      final newUnlocked =
          (unlockedLevel < 5 && newCurrent > unlockedLevel) ? newCurrent : unlockedLevel;

      setState(() {
        currentLevel = newCurrent;
        unlockedLevel = newUnlocked;
      });

      await ProgressManager.saveProgress(newUnlocked, newCurrent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Level $level complete! Level $newCurrent unlocked!'),
          backgroundColor: Color(0xFF00B894),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Keep trying — you\'ve got this! 💪'),
          backgroundColor: Color(0xFFFF6B35),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: Color(0xFF0D1B2A),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF6C63FF))),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildXPBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 600,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(double.infinity, 600),
                        painter: LevelPathPainter(unlockedLevel: unlockedLevel),
                      ),
                      Positioned(bottom: 20, left: 60, child: _levelNode(1)),
                      Positioned(bottom: 130, left: 60, child: _levelNode(2)),
                      Positioned(bottom: 240, left: 200, child: _levelNode(3)),
                      Positioned(bottom: 360, left: 120, child: _levelNode(4)),
                      Positioned(bottom: 470, left: 200, child: _levelNode(5)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
          const SizedBox(width: 16),
          Text(
            '🧠 Safety Quiz',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF1A3A5C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text('⭐', style: TextStyle(fontSize: 14)),
                SizedBox(width: 4),
                Text(
                  '${(unlockedLevel - 1) * 3} / 15',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF122335),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF1E3A54)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level ${unlockedLevel > 5 ? 5 : unlockedLevel} / 5 Unlocked',
                style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                '${((unlockedLevel - 1) / 5 * 100).toInt()}% Complete',
                style: TextStyle(color: Color(0xFF6C63FF), fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (unlockedLevel - 1) / 5,
              minHeight: 8,
              backgroundColor: Color(0xFF0D1B2A),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _levelNode(int level) {
    final bool unlocked = level <= unlockedLevel;
    final bool completed = level < currentLevel;
    final bool isCurrent = level == currentLevel && unlocked;

    Color nodeColor;
    Widget nodeChild;

    if (completed) {
      nodeColor = Color(0xFF00B894);
      nodeChild = Icon(Icons.check_rounded, color: Colors.white, size: 28);
    } else if (isCurrent) {
      nodeColor = Color(0xFF6C63FF);
      nodeChild = Text('$level',
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w900));
    } else if (unlocked) {
      nodeColor = Color(0xFF1A3A5C);
      nodeChild = Text('$level',
          style: TextStyle(fontSize: 22, color: Colors.white54, fontWeight: FontWeight.w700));
    } else {
      nodeColor = Color(0xFF0F2030);
      nodeChild = Icon(Icons.lock_rounded, color: Colors.white24, size: 24);
    }

    return GestureDetector(
      onTap: () => onLevelTap(level),
      child: Column(
        children: [
          if (isCurrent)
            Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('START!',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
            ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: nodeColor,
              shape: BoxShape.circle,
              border: isCurrent
                  ? Border.all(color: Colors.white.withOpacity(0.4), width: 3)
                  : completed
                      ? Border.all(color: Color(0xFF00B894).withOpacity(0.5), width: 2)
                      : null,
              boxShadow: [
                if (isCurrent)
                  BoxShadow(color: Color(0xFF6C63FF).withOpacity(0.5), blurRadius: 20, spreadRadius: 4),
                if (completed)
                  BoxShadow(color: Color(0xFF00B894).withOpacity(0.3), blurRadius: 12, spreadRadius: 2),
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 4)),
              ],
            ),
            child: Center(child: nodeChild),
          ),
          const SizedBox(height: 4),
          Text(
            'Lvl $level',
            style: TextStyle(
              color: unlocked ? Colors.white60 : Colors.white24,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class LevelPathPainter extends CustomPainter {
  final int unlockedLevel;
  LevelPathPainter({required this.unlockedLevel});

  @override
  void paint(Canvas canvas, Size size) {
    final dimPaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final litPaint = Paint()
      ..color = Color(0xFF6C63FF).withOpacity(0.6)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.moveTo(95, size.height - 55);
    path.quadraticBezierTo(95, size.height - 100, 95, size.height - 130);
    path.quadraticBezierTo(140, size.height - 185, 235, size.height - 240);
    path.quadraticBezierTo(175, size.height - 300, 155, size.height - 360);
    path.quadraticBezierTo(175, size.height - 420, 235, size.height - 470);

    canvas.drawPath(path, dimPaint);
    canvas.drawPath(path, litPaint);
  }

  @override
  bool shouldRepaint(covariant LevelPathPainter oldDelegate) =>
      oldDelegate.unlockedLevel != unlockedLevel;
}