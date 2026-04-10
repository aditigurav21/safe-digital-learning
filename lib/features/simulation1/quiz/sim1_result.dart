import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

class Sim1ResultScreen extends StatefulWidget {
  const Sim1ResultScreen({super.key});

  @override
  State<Sim1ResultScreen> createState() => _Sim1ResultScreenState();
}

class _Sim1ResultScreenState extends State<Sim1ResultScreen> {
  late int score;
  late String message;
  late String badge;
  bool _spoken = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    score = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    _computeResult(AppLocalizations.of(context)!);
    if (!_spoken) {
      _spoken = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _speakScreen());
    }
  }

  void _computeResult(AppLocalizations l) {
    const total = 5;
    if (score == total) {
      message = l.sim1_result_msg_perfect;
      badge = l.sim1_result_badge_gold;
    } else if (score >= 4) {
      message = l.sim1_result_msg_great;
      badge = l.sim1_result_badge_aware;
    } else if (score >= 3) {
      message = l.sim1_result_msg_good;
      badge = l.sim1_result_badge_learning;
    } else if (score >= 2) {
      message = l.sim1_result_msg_keepGoing;
      badge = l.sim1_result_badge_practice;
    } else {
      message = l.sim1_result_msg_tryAgain;
      badge = l.sim1_result_badge_retry;
    }
  }

  void _speakScreen() {
    if (!mounted) return;
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    tts.speak(
      "Quiz complete. ${l.sim1_result_score(score, 5)}. "
          "$message "
          "Badge: $badge. "
          "${l.sim1_result_rules} "
          "${l.sim1_result_rule1}. ${l.sim1_result_rule2}. ${l.sim1_result_rule3}. "
          "${l.sim1_result_homeBtn} or ${l.sim1_result_retryBtn}.",
    );
  }

  void _stopAndNavigate(VoidCallback navigate) {
    context.read<TtsProvider>().stop();
    navigate();
  }

  @override
  void dispose() {
    if (mounted) context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    score = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    _computeResult(l);

    const total = 5;
    Color color;
    String emoji;
    List<String> symbols;

    if (score == total) {
      color = Colors.green; emoji = "🏆";
      symbols = ["🥇", "🛡️", "⭐", "⭐", "⭐"];
    } else if (score >= 4) {
      color = Colors.green; emoji = "🎉";
      symbols = ["🥈", "🛡️", "⭐", "⭐", "☆"];
    } else if (score >= 3) {
      color = Colors.orange; emoji = "👍";
      symbols = ["🥉", "🔰", "⭐", "☆", "☆"];
    } else if (score >= 2) {
      color = Colors.orange; emoji = "⚠️";
      symbols = ["📚", "🔰", "⭐", "☆", "☆"];
    } else {
      color = Colors.red; emoji = "💪";
      symbols = ["📚", "🔴", "☆", "☆", "☆"];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text(l.sim1_result_appBarTitle),
        leading: BackButton(
          onPressed: () => _stopAndNavigate(() => Navigator.pop(context)),
        ),
        actions: [TtsToggleButton(onToggled: _speakScreen)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(emoji, style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(
              l.sim1_result_score(score, total),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: symbols
                  .map((s) => Text(s, style: const TextStyle(fontSize: 28)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold, height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "🏅 $badge",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
            Text(l.sim1_result_scoreLabel(score, total),
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(l.sim1_result_rules,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(l.sim1_result_rule1, style: const TextStyle(fontSize: 15, height: 1.8)),
                  Text(l.sim1_result_rule2, style: const TextStyle(fontSize: 15, height: 1.8)),
                  Text(l.sim1_result_rule3, style: const TextStyle(fontSize: 15, height: 1.8)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () => _stopAndNavigate(
                      () => Navigator.popUntil(context, ModalRoute.withName('/')),
                ),
                icon: const Icon(Icons.home, size: 24),
                label: Text(l.sim1_result_homeBtn,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                onPressed: () => _stopAndNavigate(
                      () => Navigator.pushNamedAndRemoveUntil(
                      context, '/sim1-quiz', ModalRoute.withName('/')),
                ),
                icon: const Icon(Icons.refresh),
                label: Text(l.sim1_result_retryBtn, style: const TextStyle(fontSize: 16)),
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