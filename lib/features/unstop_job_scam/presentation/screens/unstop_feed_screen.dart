import 'package:flutter/material.dart';

class UnstopFeedScreen extends StatelessWidget {
  const UnstopFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unstop Job Scam Module")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Fake Job Offers on Unstop‑like apps",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: navigate to fake job offer screen
              },
              child: const Text("Apply for this fake job"),
            ),
          ],
        ),
      ),
    );
  }
}
