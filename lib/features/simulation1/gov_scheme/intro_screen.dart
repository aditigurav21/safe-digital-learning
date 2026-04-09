import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gov Scheme Safety"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔷 Title
            const Text(
              "Stay Safe from Government Scheme Scams",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 🔷 Description
            const Text(
              "Many fraud messages target farmers with fake schemes.\n\n"
              "This simulation will teach you:",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 15),

            // 🔷 Bullet points
            const Text("• How to identify fake links"),
            const Text("• When NOT to share OTP"),
            const Text("• What information is safe to give"),
            const Text("• How scams trick people"),

            const SizedBox(height: 30),

            // 🔷 Warning card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Never trust unknown links or urgent messages asking for money or OTP.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🔷 Start Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sim1-examples');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Start Learning",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}