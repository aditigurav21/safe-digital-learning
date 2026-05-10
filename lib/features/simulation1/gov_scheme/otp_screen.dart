import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakScreen();
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) showScamPopup();
      });
    });
  }

  void _speakScreen() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    tts.speak([
      l.sim1_otp_title,
      l.sim1_otp_subtitle,
      l.sim1_otp_warningText,
      l.sim1_otp_submitBtn,
    ].join(' '));
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  void showScamPopup() {
    final l = AppLocalizations.of(context)!;
    final tts = context.read<TtsProvider>();
    tts.speak(l.sim1_otp_scamPopupSpeak);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final l = AppLocalizations.of(context)!;
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          backgroundColor: Colors.red.shade50,
          title: Row(
            children: [
              const Icon(Icons.message, color: Colors.red, size: 30),
              const SizedBox(width: 10),
              Text(l.sim1_otp_scamPopupTitle,
                  style: const TextStyle(fontSize: 20, color: Colors.red)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.sim1_otp_scamPopupBody,
                style: const TextStyle(
                    fontSize: 16,
                    height: 1.7,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 14),
              Text(l.sim1_otp_scamPopupQuestion,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sim1-link',
                    arguments: false);
              },
              icon: const Icon(Icons.share),
              label: Text(l.sim1_otp_shareOtpBtn,
                  style: const TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _showSafeChoice();
              },
              icon: const Icon(Icons.block),
              label: Text(l.sim1_otp_refuseBtn,
                  style: const TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }

  void _showSafeChoice() {
    final l = AppLocalizations.of(context)!;
    final tts = context.read<TtsProvider>();
    tts.speak(l.sim1_otp_safeChoiceSpeak);
    showDialog(
      context: context,
      builder: (context) {
        final l = AppLocalizations.of(context)!;
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
          backgroundColor: Colors.green.shade50,
          title: Row(
            children: [
              const Icon(Icons.shield, color: Colors.green, size: 32),
              const SizedBox(width: 10),
              Text(l.sim1_otp_safeChoiceTitle,
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
          content: Text(
            l.sim1_otp_safeChoiceBody,
            style: const TextStyle(fontSize: 15, height: 1.7),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sim1-link',
                    arguments: true);
              },
              icon: const Icon(Icons.arrow_forward),
              label: Text(l.sim1_common_continue,
                  style: const TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text(l.sim1_otp_appBarTitle),
        actions: [TtsToggleButton(onToggled: _speakScreen)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.lock_clock, size: 60, color: Colors.blue),
            const SizedBox(height: 16),
            Text(l.sim1_otp_title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(l.sim1_otp_subtitle,
                style:
                const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 24),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              style:
              const TextStyle(fontSize: 22, letterSpacing: 10),
              maxLength: 6,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: l.sim1_otp_fieldLabel,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: Colors.orange, size: 26),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l.sim1_otp_warningText,
                      style: const TextStyle(fontSize: 14, height: 1.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  final tts = context.read<TtsProvider>();
                  tts.speak(l.sim1_otp_submitWarningSpeak);
                  showDialog(
                    context: context,
                    builder: (context) {
                      final l = AppLocalizations.of(context)!;
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: Colors.red, size: 30),
                            const SizedBox(width: 10),
                            Text(l.sim1_otp_submitDialogTitle,
                                style:
                                const TextStyle(fontSize: 20)),
                          ],
                        ),
                        content: Text(
                          l.sim1_otp_submitDialogBody,
                          style: const TextStyle(
                              fontSize: 15, height: 1.7),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, '/sim1-link',
                                  arguments: false);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: Text(l.sim1_common_understood,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white)),
                          )
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l.sim1_otp_submitBtn,
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}