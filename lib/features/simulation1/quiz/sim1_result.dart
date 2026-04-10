import 'package:flutter/material.dart';

class Sim1ResultScreen extends StatelessWidget {
  const Sim1ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int score =
        ModalRoute.of(context)?.settings.arguments as int? ?? 0;

    String message;
    Color color;

    if (score >= 4) {
      message = "Excellent! You are very aware of scams 🎉";
      color = Colors.green;
    } else if (score >= 2) {
      message = "Good, but be careful with scams ⚠️";
      color = Colors.orange;
    } else {
      message = "You need to learn more about scams ❌";
      color = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Result")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Score: $score / 5",
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Icon(
              Icons.emoji_events,
              size: 80,
              color: color,
            ),

            const SizedBox(height: 20),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text("Go Home"),
            ),
          ],
        ),
      ),
    );
  }
}
