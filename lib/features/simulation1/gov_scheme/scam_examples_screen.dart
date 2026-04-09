import 'package:flutter/material.dart';

class ScamExamplesScreen extends StatefulWidget {
  const ScamExamplesScreen({super.key});

  @override
  State<ScamExamplesScreen> createState() => _ScamExamplesScreenState();
}

class _ScamExamplesScreenState extends State<ScamExamplesScreen> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> scenarios = [
    {
      "message":
          "Dear Farmer, you will receive ₹5000 subsidy. Click here: bit.ly/kisan-help",
      "isScam": true,
      "reason":
          "This is a scam because it uses a short link and creates urgency."
    },
    {
      "message":
          "Visit official website: https://pmkisan.gov.in to check your payment status.",
      "isScam": false,
      "reason":
          "This is safe because it uses the official government website."
    },
    {
      "message":
          "URGENT: Your scheme will be cancelled. Share OTP immediately.",
      "isScam": true,
      "reason":
          "Scammers create panic and ask for OTP. Never share OTP."
    },
  ];

  void checkAnswer(bool userChoice) {
    bool correct = scenarios[currentIndex]["isScam"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(userChoice == correct ? "Correct ✅" : "Wrong ❌"),
        content: Text(scenarios[currentIndex]["reason"]),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              if (currentIndex < scenarios.length - 1) {
                setState(() {
                  currentIndex++;
                });
              } else {
                Navigator.pushNamed(context, '/sim1-form');
              }
            },
            child: const Text("Next"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var current = scenarios[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Identify Scam")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔷 Progress
            Text(
              "Example ${currentIndex + 1} of ${scenarios.length}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // 🔷 Message Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                current["message"],
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            // 🔷 Question
            const Text(
              "Is this a scam?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // 🔷 Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => checkAnswer(true),
                child: const Text("SCAM ❌"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => checkAnswer(false),
                child: const Text("SAFE ✅"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}