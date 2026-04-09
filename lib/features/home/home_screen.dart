import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key); // fixing that warning too

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guardian Path")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/create-account'),
              child: const Text("Simulation 1 (Account Setup)"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/sim2-intro'),
              child: const Text("Simulation 2 (Scam Detection)"),
            ),

            const SizedBox(height: 10),

            // 👇 YOUR NEW BUTTON
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/sim3-intro'),
              child: const Text("Simulation 3 (Job Scam)"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/quiz'),
              child: const Text("Quiz"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/dashboard'),
              child: const Text("Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}