import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool result =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text("Simulation Result")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 20),

            // 🔷 Result Icon
            Icon(
              result ? Icons.verified : Icons.error,
              size: 80,
              color: result ? Colors.green : Colors.red,
            ),

            const SizedBox(height: 20),

            // 🔷 Result Text
            Text(
              result
                  ? "You Stayed Safe! 🎉"
                  : "You Fell for a Scam ❌",
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // 🔷 Explanation Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: result
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                result
                    ? "Great job! You avoided sharing sensitive information and chose the correct website.\n\nYou are learning to stay safe online."
                    : "You made a risky choice.\n\nScammers use urgency and fake links to steal your information.\n\nBe careful next time!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 25),

            // 🔷 Key Learning Points
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Key Takeaways:",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            const Text("• Never share OTP with anyone"),
            const Text("• Avoid clicking unknown links"),
            const Text("• Always check official websites"),
            const Text("• Do not trust urgent messages"),

            const Spacer(),

            // 🔷 Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sim1-quiz');
                },
                child: const Text("Take Quiz"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text("Go Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}