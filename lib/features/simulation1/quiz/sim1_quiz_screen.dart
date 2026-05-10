import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';
import 'sim1_questions.dart';

class Sim1QuizScreen extends StatefulWidget {
  const Sim1QuizScreen({super.key});

  @override
  State<Sim1QuizScreen> createState() => _Sim1QuizScreenState();
}

class _Sim1QuizScreenState extends State<Sim1QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedOption;
  bool answered = false;

  // Questions are built lazily from localizations
  late List<Sim1Question> _questions;
  bool _questionsInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_questionsInitialized) {
      _questions = getSim1Questions(AppLocalizations.of(context)!);
      _questionsInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _speakQuestion());
    }
  }

  void _speakQuestion() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    final q = _questions[currentIndex];
    final opts = q.options.asMap().entries
        .map((e) => "Option ${e.key + 1}: ${e.value}")
        .join('. ');
    tts.speak(
        "Question ${currentIndex + 1} of ${_questions.length}. "
            "${q.question}. $opts"
    );
  }

  void answerQuestion(int selectedIndex) {
    if (answered) return;
    final l = AppLocalizations.of(context)!;
    final isCorrect = selectedIndex == _questions[currentIndex].correctIndex;
    setState(() {
      selectedOption = selectedIndex;
      answered = true;
      if (isCorrect) score++;
    });

    final tts = context.read<TtsProvider>();
    if (isCorrect) {
      tts.speak(l.sim1_quiz_correct);
    } else {
      final correctAnswer = _questions[currentIndex].options[_questions[currentIndex].correctIndex];
      tts.speak(l.sim1_quiz_wrong(correctAnswer));
    }

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      if (currentIndex < _questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedOption = null;
          answered = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _speakQuestion());
      } else {
        Navigator.pushNamed(context, '/sim1-quiz-result', arguments: score);
      }
    });
  }

  Color _buttonColor(int index) {
    if (!answered) return Colors.white;
    if (index == _questions[currentIndex].correctIndex) return Colors.green.shade100;
    if (index == selectedOption) return Colors.red.shade100;
    return Colors.white;
  }

  Color _buttonBorderColor(int index) {
    if (!answered) return Colors.grey.shade300;
    if (index == _questions[currentIndex].correctIndex) return Colors.green;
    if (index == selectedOption) return Colors.red;
    return Colors.grey.shade300;
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final question = _questions[currentIndex];
    final progress = (currentIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text(l.sim1_quiz_appBarTitle(currentIndex + 1, _questions.length)),
        actions: [TtsToggleButton(onToggled: _speakQuestion)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(question.question,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5)),
            ),
            const SizedBox(height: 24),
            ...List.generate(question.options.length, (index) {
              final isCorrect = index == question.correctIndex;
              final isSelected = index == selectedOption;
              return GestureDetector(
                onTap: () => answerQuestion(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: _buttonColor(index),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _buttonBorderColor(index), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      if (answered)
                        Icon(
                          isCorrect ? Icons.check_circle : (isSelected ? Icons.cancel : Icons.circle_outlined),
                          color: isCorrect ? Colors.green : (isSelected ? Colors.red : Colors.grey),
                          size: 24,
                        )
                      else
                        const Icon(Icons.circle_outlined, color: Colors.grey, size: 24),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          question.options[index],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: (answered && isCorrect) ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}