import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'question_model.dart';

class QuizScreen extends StatefulWidget {
  final int level;
  QuizScreen({required this.level});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;
  bool? _lastAnswer;

  List<Question> getQuestions() {
    return [
      Question(questionText: "Should you share your OTP with anyone?", answer: false),
      Question(questionText: "Should you use a strong, unique password?", answer: true),
      Question(questionText: "Is it safe to click unknown links in messages?", answer: false),
    ];
  }

  void answer(bool val) async {
    final questions = getQuestions();
    final bool correct = val == questions[index].answer;
    if (correct) score++;

    setState(() => _lastAnswer = correct);
    await Future.delayed(Duration(milliseconds: 600));

    if (index < questions.length - 1) {
      setState(() {
        index++;
        _lastAnswer = null;
      });
    } else {
      bool passed = score >= (questions.length / 2).ceil();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: score,
            total: questions.length,
            level: widget.level,
            passed: passed,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = getQuestions();
    final q = questions[index];
    final progress = (index + 1) / questions.length;

    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF122335),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.close, color: Colors.white70, size: 20),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Color(0xFF122335),
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF122335),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('${index + 1}/${questions.length}',
                        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  _ScoreChip(label: '🔥 $score correct', color: Color(0xFF00B894)),
                  SizedBox(width: 8),
                  _ScoreChip(label: 'Level ${widget.level}', color: Color(0xFF6C63FF)),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Color(0xFF122335),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _lastAnswer == null
                        ? Color(0xFF1E3A54)
                        : _lastAnswer!
                            ? Color(0xFF00B894).withOpacity(0.5)
                            : Color(0xFFFF6B35).withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    if (_lastAnswer != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          _lastAnswer! ? '✅ Correct!' : '❌ Wrong!',
                          style: TextStyle(
                            color: _lastAnswer! ? Color(0xFF00B894) : Color(0xFFFF6B35),
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    Text(
                      q.questionText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _AnswerButton(
                label: '👍  Yes',
                color: Color(0xFF00B894),
                onTap: _lastAnswer == null ? () => answer(true) : null,
              ),
              const SizedBox(height: 12),
              _AnswerButton(
                label: '👎  No',
                color: Color(0xFFFF6B35),
                onTap: _lastAnswer == null ? () => answer(false) : null,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap;
  const _AnswerButton({required this.label, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap == null ? 0.4 : 1.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.4), width: 2),
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w800)),
          ),
        ),
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  final String label;
  final Color color;
  const _ScoreChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}