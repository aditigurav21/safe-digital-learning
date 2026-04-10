/*import 'package:flutter/material.dart';
import 'sim1_questions.dart';

class Sim1QuizScreen extends StatefulWidget {
  const Sim1QuizScreen({super.key});

  @override
  State<Sim1QuizScreen> createState() => _Sim1QuizScreenState();
}

class _Sim1QuizScreenState extends State<Sim1QuizScreen> {
  int currentIndex = 0;
  int score = 0;

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == sim1Questions[currentIndex].correctIndex) {
      score++;
    }

    if (currentIndex < sim1Questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.pushNamed(
        context,
        '/sim1-quiz-result',
        arguments: score,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = sim1Questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${currentIndex + 1}/${sim1Questions.length}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Text(
              question.question,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ...List.generate(question.options.length, (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => answerQuestion(index),
                  child: Text(question.options[index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
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

  void answerQuestion(int selectedIndex) {
    if (answered) return;
    setState(() {
      selectedOption = selectedIndex;
      answered = true;
      if (selectedIndex == sim1Questions[currentIndex].correctIndex) score++;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (currentIndex < sim1Questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedOption = null;
          answered = false;
        });
      } else {
        Navigator.pushNamed(context, '/sim1-quiz-result', arguments: score);
      }
    });
  }

  Color _buttonColor(int index) {
    if (!answered) return Colors.white;
    if (index == sim1Questions[currentIndex].correctIndex) return Colors.green.shade100;
    if (index == selectedOption) return Colors.red.shade100;
    return Colors.white;
  }

  Color _buttonBorderColor(int index) {
    if (!answered) return Colors.grey.shade300;
    if (index == sim1Questions[currentIndex].correctIndex) return Colors.green;
    if (index == selectedOption) return Colors.red;
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final question = sim1Questions[currentIndex];
    final progress = (currentIndex + 1) / sim1Questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text("Quiz — Question ${currentIndex + 1} of ${sim1Questions.length}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
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

            // Question
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                question.question,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5),
              ),
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
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakQuestion());
  }

  void _speakQuestion() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final q = sim1Questions[currentIndex];
    final opts = q.options.asMap().entries
        .map((e) => "Option ${e.key + 1}: ${e.value}")
        .join('. ');
    tts.speak(
      "Question ${currentIndex + 1} of ${sim1Questions.length}. "
      "${q.question}. $opts"
    );
  }

  void answerQuestion(int selectedIndex) {
    if (answered) return;
    final isCorrect = selectedIndex == sim1Questions[currentIndex].correctIndex;
    setState(() {
      selectedOption = selectedIndex;
      answered = true;
      if (isCorrect) score++;
    });

    // Speak result of answer
    final tts = context.read<TtsProvider>();
    if (isCorrect) {
      tts.speak("Correct! Well done.");
    } else {
      final correctAnswer = sim1Questions[currentIndex].options[sim1Questions[currentIndex].correctIndex];
      tts.speak("Wrong. The correct answer is: $correctAnswer");
    }

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      if (currentIndex < sim1Questions.length - 1) {
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
    if (index == sim1Questions[currentIndex].correctIndex) return Colors.green.shade100;
    if (index == selectedOption) return Colors.red.shade100;
    return Colors.white;
  }

  Color _buttonBorderColor(int index) {
    if (!answered) return Colors.grey.shade300;
    if (index == sim1Questions[currentIndex].correctIndex) return Colors.green;
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
    final question = sim1Questions[currentIndex];
    final progress = (currentIndex + 1) / sim1Questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text("Quiz — Question ${currentIndex + 1} of ${sim1Questions.length}"),
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