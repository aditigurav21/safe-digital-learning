import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



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
    final l = AppLocalizations.of(context)!;
    final texts = [
      result ? l.sim1_success_stayedSafe : l.sim1_success_almostScammed,
      result ? l.sim1_success_safeMsg : l.sim1_success_scammedMsg,
      l.sim1_success_keyLearnings,
      l.sim1_success_learn1,
      l.sim1_success_learn2,
      l.sim1_success_learn3,
      l.sim1_success_learn4,
      l.sim1_success_learn5,
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
    final l = AppLocalizations.of(context)!;
    result = ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text(l.sim1_success_appBarTitle),
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
            Text(result ? l.sim1_success_stayedSafe : l.sim1_success_almostScammed,
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
                result ? l.sim1_success_safeMsg : l.sim1_success_scammedMsg,
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
                  Text(l.sim1_success_keyLearnings, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _learning("🔒", l.sim1_success_learn1),
                  _learning("🔗", l.sim1_success_learn2),
                  _learning("⏰", l.sim1_success_learn3),
                  _learning("📞", l.sim1_success_learn4),
                  _learning("🏦", l.sim1_success_learn5),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _badge(result ? "✅" : "❌",
                    result ? l.sim1_success_badgeSafe : l.sim1_success_badgeRisky,
                    result ? Colors.green : Colors.red),
                const SizedBox(width: 16),
                _badge("📚", l.sim1_success_badgeLearn, Colors.blue),
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
                label: Text(l.sim1_success_quizBtn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                label: Text(l.sim1_success_homeBtn, style: const TextStyle(fontSize: 16)),
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
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
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