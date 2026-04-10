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
}
