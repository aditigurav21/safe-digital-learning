import 'package:flutter/material.dart';
import 'lesson_model.dart';
import 'result_screen.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class QuizScreen extends StatefulWidget {
  final LevelData levelData;
  const QuizScreen({required this.levelData});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _index = 0;
  int _score = 0;
  QuizAnswer? _selectedAnswer;
  bool _showExplanation = false;

  late AnimationController _cardCtrl;
  late AnimationController _feedbackCtrl;
  late Animation<double> _cardScale;
  late Animation<double> _feedbackSlide;

  @override
  void initState() {
    super.initState();
    _cardCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _feedbackCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _cardScale = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutBack);
    _feedbackSlide = CurvedAnimation(parent: _feedbackCtrl, curve: Curves.easeOutCubic);
    _cardCtrl.forward();
  }

  @override
  void dispose() {
    _cardCtrl.dispose();
    _feedbackCtrl.dispose();
    super.dispose();
  }

  List<QuizQuestion> get questions => widget.levelData.questions;
  QuizQuestion get current => questions[_index];
  Color get levelColor => AppColors.levelColor(widget.levelData.level);

  bool get _isCorrect {
    if (_selectedAnswer == null) return false;
    return _selectedAnswer == current.answer;
  }

  void _onAnswer(QuizAnswer answer) async {
    if (_selectedAnswer != null) return;
    final correct = answer == current.answer;
    if (correct) _score++;
    setState(() {
      _selectedAnswer = answer;
      _showExplanation = true;
    });
    _feedbackCtrl.forward();
  }

  void _nextQuestion() async {
    await _feedbackCtrl.reverse();
    _cardCtrl.reset();
    setState(() {
      _index++;
      _selectedAnswer = null;
      _showExplanation = false;
    });
    _cardCtrl.forward();
  }

  void _finish() {
    final passed = _score >= (questions.length / 2).ceil();

    // ResultScreen handles its own navigation:
    // it pops itself then pops QuizScreen, returning `passed` to LevelMapScreen.
    // We just push it — do NOT pop here or await a return value.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: _score,
          total: questions.length,
          levelData: widget.levelData,
          passed: passed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_index >= questions.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _finish());
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Column(
                  children: [
                    _buildScenarioCard(),
                    const SizedBox(height: 16),
                    if (!_showExplanation) _buildAnswerButtons(),
                    if (_showExplanation)
                      FadeTransition(
                        opacity: _feedbackSlide,
                        child: _buildExplanation(),
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    final progress = (_index + 1) / questions.length;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          Row(
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
                  child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppStrings.question} ${_index + 1} ${AppStrings.of} ${questions.length}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: AppColors.xpBarBg,
                        valueColor: AlwaysStoppedAnimation<Color>(levelColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.levelLight(widget.levelData.level),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: levelColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '⭐ $_score',
                  style: TextStyle(color: levelColor, fontWeight: FontWeight.w800, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard() {
    return ScaleTransition(
      scale: _cardScale,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedAnswer == null
                ? AppColors.cardBorder
                : _isCorrect
                    ? AppColors.success.withValues(alpha: 0.5)
                    : AppColors.error.withValues(alpha: 0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                border: const Border(bottom: BorderSide(color: AppColors.cardBorder)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.smartphone, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      current.senderLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❓ Is this safe or a scam?',
                    style: TextStyle(
                      fontSize: 14,
                      color: levelColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Text(
                      current.scenario,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButtons() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            'What do you think?',
            style: TextStyle(fontSize: 16, color: AppColors.textMuted, fontWeight: FontWeight.w600),
          ),
        ),
        _BigAnswerButton(
          label: '🎣 This is a SCAM / Phishing',
          subtitle: 'Something feels wrong here',
          color: AppColors.error,
          lightColor: AppColors.errorLight,
          onTap: () => _onAnswer(QuizAnswer.phishing),
        ),
        const SizedBox(height: 12),
        _BigAnswerButton(
          label: '✅ This is SAFE',
          subtitle: 'I think this is genuine',
          color: AppColors.success,
          lightColor: AppColors.successLight,
          onTap: () => _onAnswer(QuizAnswer.safe),
        ),
        const SizedBox(height: 12),
        _BigAnswerButton(
          label: '🤔 Could Be Suspicious',
          subtitle: 'I am not 100% sure',
          color: AppColors.warning,
          lightColor: AppColors.warningLight,
          onTap: () => _onAnswer(QuizAnswer.couldBePhishing),
        ),
      ],
    );
  }

  Widget _buildExplanation() {
    final isLast = _index == questions.length - 1;
    final correct = _isCorrect;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: correct ? AppColors.successLight : AppColors.errorLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: correct
                  ? AppColors.success.withValues(alpha: 0.4)
                  : AppColors.error.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Text(correct ? '✅' : '❌', style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      correct ? AppStrings.correct : AppStrings.wrong,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: correct ? AppColors.success : AppColors.error,
                      ),
                    ),
                    if (!correct)
                      Text(
                        'The correct answer was: ${_answerLabel(current.answer)}',
                        style: TextStyle(
                          fontSize: 13,
                          color: correct ? AppColors.success : AppColors.error,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '💡 Why?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                current.explanation,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
              if (current.redFlags.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🚩 Warning Signs:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...current.redFlags.map(
                        (flag) => Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '• ',
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  flag,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.error,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLast ? _finish : _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: levelColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: Text(
              isLast ? '🏁 See My Results' : AppStrings.nextQuestion,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _answerLabel(QuizAnswer a) {
    switch (a) {
      case QuizAnswer.phishing:
        return '🎣 Scam / Phishing';
      case QuizAnswer.safe:
        return '✅ Safe';
      case QuizAnswer.couldBePhishing:
        return '🤔 Could Be Suspicious';
    }
  }
}

class _BigAnswerButton extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final Color lightColor;
  final VoidCallback onTap;

  const _BigAnswerButton({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.lightColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(color: color.withValues(alpha: 0.7), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}