import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:safe_digital_learning/l10n/app_localizations.dart';


import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  List<String> _screenTexts(AppLocalizations l) => [
    l.sim1_intro_heroTitle.replaceAll('\n', ' '),
    l.sim1_intro_heroSubtitle.replaceAll('\n', ' '),
    l.sim1_intro_youWillLearn,
    l.sim1_intro_fakeLinksTitle + '. ' + l.sim1_intro_fakeLinksDesc,
    l.sim1_intro_fakeOtpTitle + '. ' + l.sim1_intro_fakeOtpDesc,
    l.sim1_intro_safeInfoTitle + '. ' + l.sim1_intro_safeInfoDesc,
    l.sim1_intro_urgencyTitle + '. ' + l.sim1_intro_urgencyDesc,
    l.sim1_intro_warningText,
    l.sim1_intro_startBtn,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakScreen());
  }

  void _speakScreen() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    tts.speak(_screenTexts(l).join(' '));
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TtsProvider>().enabled;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(l.sim1_intro_appBarTitle, style: const TextStyle(fontSize: 18)),
        actions: [TtsToggleButton(onToggled: _speakScreen)],
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.security, color: Colors.white, size: 52),
                  const SizedBox(height: 12),
                  Text(
                    l.sim1_intro_heroTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l.sim1_intro_heroSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text(l.sim1_intro_youWillLearn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),

            _lessonCard(Icons.link_off, l.sim1_intro_fakeLinksTitle, l.sim1_intro_fakeLinksDesc, Colors.red.shade50, Colors.red),
            _lessonCard(Icons.sms_failed, l.sim1_intro_fakeOtpTitle, l.sim1_intro_fakeOtpDesc, Colors.orange.shade50, Colors.orange),
            _lessonCard(Icons.lock, l.sim1_intro_safeInfoTitle, l.sim1_intro_safeInfoDesc, Colors.green.shade50, Colors.green),
            _lessonCard(Icons.alarm, l.sim1_intro_urgencyTitle, l.sim1_intro_urgencyDesc, Colors.purple.shade50, Colors.purple),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l.sim1_intro_warningText,
                      style: const TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/sim1-form'),
                icon: const Icon(Icons.play_circle_fill, size: 26),
                label: Text(l.sim1_intro_startBtn, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lessonCard(IconData icon, String title, String desc, Color bgColor, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: iconColor)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(fontSize: 14, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}