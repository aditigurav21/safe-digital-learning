import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guardian Path")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),

           ElevatedButton(
  onPressed: () => Navigator.pushNamed(context, '/sim1-intro'),
  child: Text("Simulation 1 (Gov Scheme)"),
),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/sim2-intro'),
              child: Text("Simulation 2 (Scam Detection)"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/quiz'),
              child: Text("Quiz"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/dashboard'),
              child: Text("Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}