/*import 'package:flutter/material.dart';

class LinkCheckScreen extends StatelessWidget {
  const LinkCheckScreen({super.key});

  void checkAnswer(BuildContext context, bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? "Correct ✅" : "Wrong ❌"),
        content: Text(
          isCorrect
              ? "This is the official government website.\n\nAlways check for https and correct domain."
              : "This is a fake or shortened link.\n\nScammers use these to steal your data.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-success',
                  arguments: isCorrect);
            },
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }

  Widget buildLinkCard({
    required String title,
    required String link,
    required bool isSafe,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          isSafe ? Icons.verified : Icons.warning,
          color: isSafe ? Colors.green : Colors.red,
        ),
        title: Text(title),
        subtitle: Text(link),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previousResult =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text("Check Website Link")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Select the SAFE website to continue:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // ❌ Fake link
            buildLinkCard(
              title: "Quick Subsidy Portal",
              link: "http://bit.ly/kisan-help",
              isSafe: false,
              onTap: () => checkAnswer(context, false),
            ),

            const SizedBox(height: 10),

            // ✅ Real link
            buildLinkCard(
              title: "PM Kisan Official Website",
              link: "https://pmkisan.gov.in",
              isSafe: true,
              onTap: () => checkAnswer(context, true),
            ),

            const SizedBox(height: 20),

            // 🔷 Info box
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Tip:\n\nAlways check:\n"
                "• https:// in URL\n"
                "• Correct spelling of website\n"
                "• Avoid shortened links",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class LinkCheckScreen extends StatelessWidget {
  const LinkCheckScreen({super.key});

  void checkAnswer(BuildContext context, bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
        title: Row(
          children: [
            Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red, size: 32),
            const SizedBox(width: 10),
            Text(isCorrect ? "Correct! ✅" : "Wrong! ❌", style: const TextStyle(fontSize: 20)),
          ],
        ),
        content: Text(
          isCorrect
              ? "You chose the REAL government website!\n\n"
                "Remember:\n"
                "• 'https://' = secure\n"
                "• '.gov.in' = official Indian government\n"
                "• Long, clear address = safe\n\n"
                "Always bookmark real sites: pmkisan.gov.in"
              : "You chose a FAKE or shortened link!\n\n"
                "Scammers use 'bit.ly' or 'tinyurl' to HIDE the real website.\n\n"
                "The real PM Kisan site is:\nhttps://pmkisan.gov.in",
          style: const TextStyle(fontSize: 15, height: 1.7),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-success', arguments: isCorrect);
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Continue", style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: isCorrect ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLinkCard({
    required String title,
    required String link,
    required bool isSafe,
    required String explanation,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: isSafe ? Colors.green.shade300 : Colors.red.shade300, width: 1.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: isSafe ? Colors.green.shade100 : Colors.red.shade100,
                child: Icon(
                  isSafe ? Icons.verified : Icons.warning_amber_rounded,
                  color: isSafe ? Colors.green : Colors.red,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(link, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, fontFamily: 'monospace')),
                    const SizedBox(height: 6),
                    Text(explanation, style: const TextStyle(fontSize: 13, height: 1.4)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text("Choose the Safe Website"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Which website is SAFE to visit?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Tap the one you think is the real government website.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            buildLinkCard(
              title: "Quick Subsidy Portal",
              link: "http://bit.ly/kisan-help",
              isSafe: false,
              explanation: "⚠ 'bit.ly' hides the real link. 'http' has no security. Avoid.",
              onTap: () => checkAnswer(context, false),
            ),

            const SizedBox(height: 14),

            buildLinkCard(
              title: "PM Kisan Official Website",
              link: "https://pmkisan.gov.in",
              isSafe: true,
              explanation: "✅ 'https' = secure. '.gov.in' = real Indian government website.",
              onTap: () => checkAnswer(context, true),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.blue, size: 22),
                      SizedBox(width: 8),
                      Text("How to check a safe website:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _tipRow("✅", "Starts with https://"),
                  _tipRow("✅", "Ends with .gov.in for Indian government"),
                  _tipRow("❌", "Avoid bit.ly, tinyurl, or unknown names"),
                  _tipRow("❌", "Avoid sites with spelling mistakes (e.g. 'g0v.in')"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tipRow(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, height: 1.4))),
        ],
      ),
    );
  }
}