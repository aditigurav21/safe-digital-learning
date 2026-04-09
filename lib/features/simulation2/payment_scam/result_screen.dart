import 'package:flutter/material.dart';

class Sim2ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result")),
      body: Center(
        child: Text("You detected the scam correctly!"),
      ),
    );
  }
}