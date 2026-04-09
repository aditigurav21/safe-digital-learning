import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;

  List questions = [
    {"q": "Should you share OTP?", "a": false},
    {"q": "Should you click unknown links?", "a": false},
  ];

  void answer(bool val) {
    if (val == questions[index]['a']) score++;

    if (index < questions.length - 1) {
      setState(() => index++);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Score"),
          content: Text("$score / ${questions.length}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dashboard'); // go to dashboard
              },
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[index]['q'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => answer(true),
              child: Text("Yes"),
            ),

            ElevatedButton(
              onPressed: () => answer(false),
              child: Text("No"),
            ),
          ],
        ),
      ),
    );
  }
}