import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Result")),
      body: Center(
        child: Text("Quiz Completed!"),
      ),
    );
  }
}