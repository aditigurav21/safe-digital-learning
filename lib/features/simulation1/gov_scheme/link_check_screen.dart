import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

class LinkCheckScreen extends StatefulWidget {
  const LinkCheckScreen({super.key});

  @override
  State<LinkCheckScreen> createState() => _LinkCheckScreenState();
}

class _LinkCheckScreenState extends State<LinkCheckScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakScreen());
  }

  void _speakScreen() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    tts.speak([
      l.sim1_link_appBarTitle,
      l.sim1_link_question,
      l.sim1_link_fakeTitle + '. ' + l.sim1_link_fakeUrl + '. ' + l.sim1_link_fakeExplanation,
      l.sim1_link_safeTitle + '. ' + l.sim1_link_safeUrl + '. ' + l.sim1_link_safeExplanation,
      l.sim1_link_tapHint,
      l.sim1_link_tip,
    ].join(' '));
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  void checkAnswer(BuildContext context, bool isCorrect) {
    final l = AppLocalizations.of(context)!;
    final tts = context.read<TtsProvider>();
    tts.speak(isCorrect
        ? l.sim1_link_correctSpeak
        : l.sim1_link_wrongSpeak);
    showDialog(
      context: context,
      builder: (context) {
        final l = AppLocalizations.of(context)!;
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
          backgroundColor:
          isCorrect ? Colors.green.shade50 : Colors.red.shade50,
          title: Row(
            children: [
              Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.red,
                  size: 32),
              const SizedBox(width: 10),
              Text(
                  isCorrect
                      ? l.sim1_link_correctTitle
                      : l.sim1_link_wrongTitle,
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
          content: Text(
            isCorrect
                ? l.sim1_link_correctBody
                : l.sim1_link_wrongBody,
            style: const TextStyle(fontSize: 15, height: 1.7),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sim1-success',
                    arguments: isCorrect);
              },
              icon: const Icon(Icons.arrow_forward),
              label: Text(l.sim1_common_continue,
                  style: const TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isCorrect ? Colors.green : Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
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
        side: BorderSide(
            color: isSafe
                ? Colors.green.shade300
                : Colors.red.shade300,
            width: 1.5),
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
                backgroundColor: isSafe
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                child: Icon(
                    isSafe
                        ? Icons.verified
                        : Icons.warning_amber_rounded,
                    color: isSafe ? Colors.green : Colors.red,
                    size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(link,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontFamily: 'monospace')),
                    const SizedBox(height: 6),
                    Text(explanation,
                        style: const TextStyle(
                            fontSize: 13, height: 1.4)),
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
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text(l.sim1_link_appBarTitle),
        actions: [TtsToggleButton(onToggled: _speakScreen)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(l.sim1_link_question,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(l.sim1_link_tapHint,
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            buildLinkCard(
              title: l.sim1_link_fakeTitle,
              link: l.sim1_link_fakeUrl,
              isSafe: false,
              explanation: l.sim1_link_fakeExplanation,
              onTap: () => checkAnswer(context, false),
            ),
            const SizedBox(height: 14),
            buildLinkCard(
              title: l.sim1_link_safeTitle,
              link: l.sim1_link_safeUrl,
              isSafe: true,
              explanation: l.sim1_link_safeExplanation,
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
                  Row(
                    children: [
                      const Icon(Icons.lightbulb_outline,
                          color: Colors.blue, size: 22),
                      const SizedBox(width: 8),
                      Text(l.sim1_link_tipHeader,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _tipRow('✅', l.sim1_link_tip1),
                  _tipRow('✅', l.sim1_link_tip2),
                  _tipRow('❌', l.sim1_link_tip3),
                  _tipRow('❌', l.sim1_link_tip4),
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
          Expanded(
              child: Text(text,
                  style:
                  const TextStyle(fontSize: 14, height: 1.4))),
        ],
      ),
    );
  }
}