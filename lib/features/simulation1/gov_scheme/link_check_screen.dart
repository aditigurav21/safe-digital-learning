import 'package:flutter/material.dart';

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
