
import 'package:flutter/material.dart';

class Sim1ResultScreen extends StatelessWidget {
  const Sim1ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int score = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    final int total = 5;

    String message;
    String emoji;
    Color color;
    String badge;
    List<String> symbols;

    if (score == total) {
      message = "Outstanding! You are a Scam Expert!";
      emoji = "🏆";
      color = Colors.green;
      badge = "Gold Shield";
      symbols = ["🥇", "🛡️", "⭐", "⭐", "⭐"];
    } else if (score >= 4) {
      message = "Excellent! You are very aware of scams.";
      emoji = "🎉";
      color = Colors.green;
      badge = "Scam Aware";
      symbols = ["🥈", "🛡️", "⭐", "⭐", "☆"];
    } else if (score >= 3) {
      message = "Good! A little more practice and you'll be a pro.";
      emoji = "👍";
      color = Colors.orange;
      badge = "Learning";
      symbols = ["🥉", "🔰", "⭐", "☆", "☆"];
    } else if (score >= 2) {
      message = "Keep going! Scammers are tricky — practice more.";
      emoji = "⚠️";
      color = Colors.orange;
      badge = "Needs Practice";
      symbols = ["📚", "🔰", "⭐", "☆", "☆"];
    } else {
      message = "Don't worry — now you know the tricks. Try again!";
      emoji = "💪";
      color = Colors.red;
      badge = "Try Again";
      symbols = ["📚", "🔴", "☆", "☆", "☆"];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text("Quiz Result"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Text(emoji, style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 16),

            Text(
              "Your Score: $score / $total",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Star symbols
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: symbols.map((s) => Text(s, style: const TextStyle(fontSize: 28))).toList(),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: color.withValues(alpha:0.4)),
              ),
              child: Column(
                children: [
                  Text(message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold, height: 1.5)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("🏅 $badge",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Score bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: score / total,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text("$score out of $total correct",
                style: const TextStyle(fontSize: 14, color: Colors.grey)),

            const SizedBox(height: 28),

            // Reminder
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Column(
                children: [
                  Text("Remember these 3 rules:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("1. 🔒  NEVER share OTP with anyone", style: TextStyle(fontSize: 15, height: 1.8)),
                  Text("2. 🌐  Only use .gov.in websites", style: TextStyle(fontSize: 15, height: 1.8)),
                  Text("3. 📞  Call 1930 if something feels wrong", style: TextStyle(fontSize: 15, height: 1.8)),
                ],
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                icon: const Icon(Icons.home, size: 24),
                label: const Text("Go Home", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/sim1-quiz', ModalRoute.withName('/'));
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Retry Quiz", style: TextStyle(fontSize: 16)),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
