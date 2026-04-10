import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import 'sim4_questions.dart';

class Sim4QuizScreen extends StatefulWidget {
  const Sim4QuizScreen({super.key});

  @override
  State<Sim4QuizScreen> createState() => _Sim4QuizScreenState();
}

class _Sim4QuizScreenState extends State<Sim4QuizScreen> {
  int _current = 0;
  int? _selected;
  bool _answered = false;
  int _score = 0;

  void _selectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selected = index;
      _answered = true;

      if (index == sim4Questions[_current].correctIndex) {
        _score++;
      }
    });
  }

  void _next() {
    if (_current < sim4Questions.length - 1) {
      setState(() {
        _current++;
        _selected = null;
        _answered = false;
      });
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/sim4-quiz-result',
        arguments: {'score': _score, 'total': sim4Questions.length},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = sim4Questions[_current];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade600,
        automaticallyImplyLeading: false,
        title: Text(
          'Quiz: Question ${_current + 1} of ${sim4Questions.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),

      // ✅ FIXED: Scrollable body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: (_current + 1) / sim4Questions.length,
                backgroundColor: Colors.grey.shade300,
                color: Colors.teal.shade600,
                minHeight: 6,
              ),

              const SizedBox(height: 24),

              // Question
              Text(
                q.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // Options
              ...List.generate(q.options.length, (i) {
                Color? bg;

                if (_answered) {
                  if (i == q.correctIndex) {
                    bg = Colors.green.shade50;
                  } else if (i == _selected) {
                    bg = Colors.red.shade50;
                  }
                }

                return GestureDetector(
                  onTap: () => _selectAnswer(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bg ?? Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _answered
                            ? (i == q.correctIndex
                                ? Colors.green
                                : (i == _selected
                                    ? Colors.red
                                    : Colors.grey.shade300))
                            : (_selected == i
                                ? Colors.teal.shade600
                                : Colors.grey.shade300),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            q.options[i],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        if (_answered && i == q.correctIndex)
                          const Icon(Icons.check_circle, color: Colors.green),
                        if (_answered &&
                            i == _selected &&
                            i != q.correctIndex)
                          const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                );
              }),

              // Explanation
              if (_answered) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Text(
                    '💡 ${q.explanation}',
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Next button
              if (_answered)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _next,
                    child: Text(
                      _current < sim4Questions.length - 1
                          ? 'Next Question →'
                          : 'See Results',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
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