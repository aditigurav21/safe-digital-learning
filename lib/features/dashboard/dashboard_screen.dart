import 'package:flutter/material.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Progress")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Modules Completed: 1"),
            SizedBox(height: 10),

            Text("Quiz Score: 2/2"),
          ],
        ),
      ),
    );
  }
}