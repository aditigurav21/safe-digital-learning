import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import 'sim2_questions.dart';

class Sim2QuizScreen extends StatefulWidget {
  @override
  State<Sim2QuizScreen> createState() => _Sim2QuizScreenState();
}

class _Sim2QuizScreenState extends State<Sim2QuizScreen> {
  int _current = 0;
  int? _selected;
  bool _answered = false;
  int _score = 0;

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selected = index;
      _answered = true;
      if (index == sim2Questions[_current].correctIndex) _score++;
    });
  }

  void _next() {
    if (_current < sim2Questions.length - 1) {
      setState(() {
        _current++;
        _selected = null;
        _answered = false;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/sim2-quiz-result',
          arguments: {'score': _score, 'total': sim2Questions.length});
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = sim2Questions[_current];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
            'Quiz: Question ${_current + 1} of ${sim2Questions.length}',
            style: const TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            LinearProgressIndicator(
              value: (_current + 1) / sim2Questions.length,
              backgroundColor: Colors.grey.shade300,
              color: AppColors.primary,
              minHeight: 6,
            ),
            const SizedBox(height: 24),
            Text(q.question,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.4)),
            const SizedBox(height: 24),
            ...List.generate(q.options.length, (i) {
              Color? bg;
              if (_answered) {
                if (i == q.correctIndex) bg = Colors.green.shade50;
                if (i == _selected && i != q.correctIndex)
                  bg = Colors.red.shade50;
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
                          ? AppColors.primary
                          : Colors.grey.shade300),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(q.options[i],
                              style: const TextStyle(fontSize: 16))),
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
            if (_answered) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text('💡 ${q.explanation}',
                    style: const TextStyle(fontSize: 14, height: 1.4)),
              ),
            ],
            const Spacer(),
            if (_answered)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _next,
                  child: Text(
                    _current < sim2Questions.length - 1
                        ? 'Next Question →'
                        : 'See Results',
                    style: const TextStyle(
                        fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
