/*import 'package:flutter/material.dart';

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
}*/
/*

import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool result = ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text("Simulation Result"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Big result icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: result ? Colors.green.shade50 : Colors.red.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: result ? Colors.green : Colors.red, width: 3),
              ),
              child: Icon(
                result ? Icons.shield : Icons.warning_amber_rounded,
                size: 72,
                color: result ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              result ? "You Stayed Safe! 🎉" : "You Almost Got Scammed! ❌",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: result ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: result ? Colors.green.shade300 : Colors.red.shade300),
              ),
              child: Text(
                result
                    ? "Excellent! You made the right choice.\n\n"
                      "You checked the website carefully and avoided sharing sensitive information. "
                      "This is exactly how you protect yourself from scammers."
                    : "Don't worry — this is a simulation to help you learn.\n\n"
                      "Scammers use urgency, fake links, and fake calls to steal your money. "
                      "Now you know their tricks. Next time you will catch it!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, height: 1.7),
              ),
            ),

            const SizedBox(height: 24),

            // Performance symbols
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Key Learnings:", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _learning("🔒", "Never share OTP with anyone on phone"),
                  _learning("🔗", "Only visit websites ending in .gov.in"),
                  _learning("⏰", "Ignore 'URGENT' messages — that is a panic trick"),
                  _learning("📞", "If in doubt, call your family or 1930 helpline"),
                  _learning("🏦", "Government NEVER asks for money to give benefits"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Score symbols
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _badge(result ? "✅" : "❌", result ? "Safe Choice" : "Risky Choice", result ? Colors.green : Colors.red),
                const SizedBox(width: 16),
                _badge("📚", "Keep Learning", Colors.blue),
              ],
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/sim1-quiz'),
                icon: const Icon(Icons.quiz, size: 24),
                label: const Text("Take the Quiz", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                icon: const Icon(Icons.home),
                label: const Text("Go Home", style: TextStyle(fontSize: 16)),
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

  Widget _learning(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15, height: 1.5))),
        ],
      ),
    );
  }

  Widget _badge(String emoji, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late bool result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    result = ModalRoute.of(context)?.settings.arguments as bool? ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakScreen());
  }

  void _speakScreen() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final texts = [
      result ? "Congratulations! You Stayed Safe!" : "You Almost Got Scammed!",
      result
        ? "Excellent! You made the right choice. You checked the website carefully and avoided sharing sensitive information. This is exactly how you protect yourself from scammers."
        : "Do not worry — this is a simulation to help you learn. Scammers use urgency, fake links, and fake calls to steal your money. Now you know their tricks. Next time you will catch it!",
      "Key Learnings.",
      "Never share OTP with anyone on phone.",
      "Only visit websites ending in dot gov dot in.",
      "Ignore URGENT messages — that is a panic trick.",
      "If in doubt, call your family or 1930 helpline.",
      "Government never asks for money to give benefits.",
      "Tap Take the Quiz to test what you learned.",
    ];
    tts.speak(texts.join(' '));
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    result = ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text("Simulation Result"),
        actions: [TtsToggleButton(onToggled: _speakScreen)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: result ? Colors.green.shade50 : Colors.red.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: result ? Colors.green : Colors.red, width: 3),
              ),
              child: Icon(result ? Icons.shield : Icons.warning_amber_rounded,
                  size: 72, color: result ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 20),
            Text(result ? "You Stayed Safe! 🎉" : "You Almost Got Scammed! ❌",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: result ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: result ? Colors.green.shade300 : Colors.red.shade300),
              ),
              child: Text(
                result
                    ? "Excellent! You made the right choice.\n\nYou checked the website carefully and avoided sharing sensitive information. This is exactly how you protect yourself from scammers."
                    : "Don't worry — this is a simulation to help you learn.\n\nScammers use urgency, fake links, and fake calls to steal your money. Now you know their tricks. Next time you will catch it!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, height: 1.7),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Key Learnings:", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _learning("🔒", "Never share OTP with anyone on phone"),
                  _learning("🔗", "Only visit websites ending in .gov.in"),
                  _learning("⏰", "Ignore 'URGENT' messages — that is a panic trick"),
                  _learning("📞", "If in doubt, call your family or 1930 helpline"),
                  _learning("🏦", "Government NEVER asks for money to give benefits"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _badge(result ? "✅" : "❌", result ? "Safe Choice" : "Risky Choice", result ? Colors.green : Colors.red),
                const SizedBox(width: 16),
                _badge("📚", "Keep Learning", Colors.blue),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () { 
                   context.read<TtsProvider>().stop();
                  Navigator.pushNamed(context, '/sim1-quiz');
                },
                 
                icon: const Icon(Icons.quiz, size: 24),
                label: const Text("Take the Quiz", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
  context.read<TtsProvider>().stop();
  Navigator.popUntil(context, ModalRoute.withName('/'));
},
                icon: const Icon(Icons.home),
                 
                label: const Text("Go Home", style: TextStyle(fontSize: 16)),
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

  Widget _learning(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15, height: 1.5))),
        ],
      ),
    );
  }

  Widget _badge(String emoji, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}