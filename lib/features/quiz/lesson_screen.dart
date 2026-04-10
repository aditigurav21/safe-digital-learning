import 'package:flutter/material.dart';
import 'lesson_model.dart';
import 'quiz_screen.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class LessonScreen extends StatefulWidget {
  final LevelData levelData;
  const LessonScreen({required this.levelData});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  late AnimationController _fadeCtrl;
  late AnimationController _slideCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _slideCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0.08, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _fadeCtrl.forward();
    _slideCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  List<LessonPage> get pages => widget.levelData.lessonPages;
  LessonPage get currentPage => pages[_pageIndex];
  bool get isLastPage => _pageIndex == pages.length - 1;
  Color get levelColor => AppColors.levelColor(widget.levelData.level);

  void _nextPage() async {
    if (isLastPage) {
      _goToQuiz();
      return;
    }
    await _fadeCtrl.reverse();
    _slideCtrl.reset();
    _fadeCtrl.reset();
    setState(() => _pageIndex++);
    _fadeCtrl.forward();
    _slideCtrl.forward();
  }

  void _goToQuiz() async {
  final int? score = await Navigator.push<int>(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => QuizScreen(levelData: widget.levelData),
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 350),
    ),
  );

  if (score != null) {
    Navigator.pop(context, score); // 🔥 RETURN SCORE BACK
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildProgressDots(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    child: _buildPageContent(),
                  ),
                ),
              ),
            ),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level ${widget.levelData.level} — ${AppStrings.lessonTitle}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  widget.levelData.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: levelColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.levelLight(widget.levelData.level),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: levelColor.withOpacity(0.3)),
            ),
            child: Text(
              '${_pageIndex + 1} / ${pages.length}',
              style: TextStyle(
                fontSize: 13,
                color: levelColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDots() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pages.length, (i) {
          final bool done = i < _pageIndex;
          final bool active = i == _pageIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: active ? 28 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: done
                  ? levelColor
                  : active
                      ? levelColor
                      : AppColors.xpBarBg,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Emoji hero
        _AnimatedEmoji(emoji: currentPage.emoji, color: levelColor),
        const SizedBox(height: 24),

        // Heading
        Text(
          currentPage.heading,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Body card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            currentPage.body,
            style: const TextStyle(
              fontSize: 17,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ),

        // Tip box
        if (currentPage.tip != null) ...[
          const SizedBox(height: 16),
          _TipBox(tip: currentPage.tip!, color: levelColor),
        ],

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: levelColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            shadowColor: levelColor.withOpacity(0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLastPage ? AppStrings.startQuiz : AppStrings.nextPage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (isLastPage) ...[
                const SizedBox(width: 8),
                const Icon(Icons.quiz_rounded, color: Colors.white, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Sub-widgets
// ──────────────────────────────────────────────

class _AnimatedEmoji extends StatefulWidget {
  final String emoji;
  final Color color;
  const _AnimatedEmoji({required this.emoji, required this.color});

  @override
  State<_AnimatedEmoji> createState() => _AnimatedEmojiState();
}

class _AnimatedEmojiState extends State<_AnimatedEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnim = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: widget.color.withOpacity(0.3), width: 2),
          ),
          child: Center(
            child: Text(widget.emoji, style: const TextStyle(fontSize: 52)),
          ),
        ),
      ),
    );
  }
}

class _TipBox extends StatelessWidget {
  final String tip;
  final Color color;
  const _TipBox({required this.tip, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 15,
                color: color.withOpacity(0.9),
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}