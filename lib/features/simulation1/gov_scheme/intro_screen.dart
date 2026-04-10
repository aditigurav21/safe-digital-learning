/*import 'package:provider/provider.dart';
import '../../../providers/tts_provider.dart';  // adjust path depth
import '../../../widgets/tts_toggle_button.dart';
import 'package:flutter/material.dart';
import '../../../widgets/tts_screen_reader.dart';
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      
    appBar: AppBar(
        // ✅ CHANGE 5 — removed duplicate title, kept actions with TtsToggleButton
        title: const Text("Stay Safe Online", style: TextStyle(fontSize: 18)),
        actions: const [TtsToggleButton()],
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
       body: TtsScreenReader(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Hero banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.security, color: Colors.white, size: 52),
                  SizedBox(height: 12),
                  Text(
                    "Stay Safe from\nGovernment Scheme Scams",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.4),
                  ),
              
                  SizedBox(height: 8),
                  Text(
                    "Many fraud calls and messages target farmers.\nThis lesson will help you protect yourself.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text("You will learn:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),

            _lessonCard(Icons.link_off, "Fake links", "Bit.ly or unknown links are dangerous. Real sites end in .gov.in", Colors.red.shade50, Colors.red),
            _lessonCard(Icons.sms_failed, "Fake OTP requests", "No government officer ever asks for OTP. That's a scam.", Colors.orange.shade50, Colors.orange),
            _lessonCard(Icons.lock, "Safe information", "Only share basic details — never passwords, PINs, or full bank info.", Colors.green.shade50, Colors.green),
            _lessonCard(Icons.alarm, "Urgency tricks", "Scammers say 'Act now or lose money!' — this is a trick to panic you.", Colors.purple.shade50, Colors.purple),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.deepOrange, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Never trust unknown links or urgent messages asking for money or OTP. When in doubt — CALL YOUR FAMILY FIRST.",
                      style: TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w500),
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
                label: const Text("Start Learning", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
        border: Border.all(color: iconColor.withOpacity(0.3)),
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
*/

/*2**************


// ✅ CHANGE 1 — imports (yours already have these, just clean up order)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';
import '../../../widgets/tts_screen_reader.dart';

// ✅ CHANGE 2 — StatelessWidget changed to StatefulWidget (needed for initState)
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  // ✅ CHANGE 3 — initState added: this fires TTS automatically when screen opens
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TtsProvider>().speak(
        "Stay Safe from Government Scheme Scams. "
        "Many fraud calls and messages target farmers. "
        "This lesson will help you protect yourself. "
        "You will learn about: Fake links. Fake OTP requests. Safe information. Urgency tricks. "
        "Never trust unknown links or urgent messages asking for money or OTP. "
        "When in doubt, call your family first. "
        "Tap Start Learning when you are ready."
      );
    });
  }

  // ✅ CHANGE 4 — dispose() added: stops TTS when user leaves this screen
  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,

      appBar: AppBar(
        // ✅ CHANGE 5 — removed duplicate title, kept actions with TtsToggleButton
        title: const Text("Stay Safe Online", style: TextStyle(fontSize: 18)),
        actions: const [TtsToggleButton()],
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      // ✅ CHANGE 6 — body wrapped with TtsScreenReader
      // Your original body was: body: SingleChildScrollView(...)
      // Now it is:              body: TtsScreenReader(child: SingleChildScrollView(...))
      body: TtsScreenReader(
        child: SingleChildScrollView(        // ← this is your ORIGINAL body, untouched
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Hero banner — UNCHANGED
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.security, color: Colors.white, size: 52),
                    SizedBox(height: 12),
                    Text(
                      "Stay Safe from\nGovernment Scheme Scams",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.4),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Many fraud calls and messages target farmers.\nThis lesson will help you protect yourself.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.6),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text("You will learn:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),

              _lessonCard(Icons.link_off, "Fake links", "Bit.ly or unknown links are dangerous. Real sites end in .gov.in", Colors.red.shade50, Colors.red),
              _lessonCard(Icons.sms_failed, "Fake OTP requests", "No government officer ever asks for OTP. That's a scam.", Colors.orange.shade50, Colors.orange),
              _lessonCard(Icons.lock, "Safe information", "Only share basic details — never passwords, PINs, or full bank info.", Colors.green.shade50, Colors.green),
              _lessonCard(Icons.alarm, "Urgency tricks", "Scammers say 'Act now or lose money!' — this is a trick to panic you.", Colors.purple.shade50, Colors.purple),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.deepOrange, size: 30),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Never trust unknown links or urgent messages asking for money or OTP. When in doubt — CALL YOUR FAMILY FIRST.",
                        style: TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w500),
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
                  label: const Text("Start Learning", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
      ), // ← this closes TtsScreenReader
    );
  }

  // _lessonCard — COMPLETELY UNCHANGED
  Widget _lessonCard(IconData icon, String title, String desc, Color bgColor, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.3)),
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
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

class IntroScreen extends StatefulWidget {        // ← changed to StatefulWidget
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  // All screen text in one place — change here, TTS updates automatically
  static const _screenTexts = [
    "Stay Safe from Government Scheme Scams.",
    "Many fraud calls and messages target farmers. This lesson will help you protect yourself.",
    "You will learn:",
    "Fake links. Bit.ly or unknown links are dangerous. Real sites end in gov.in.",
    "Fake OTP requests. No government officer ever asks for OTP. That is a scam.",
    "Safe information. Only share basic details. Never passwords, PINs, or full bank info.",
    "Urgency tricks. Scammers say Act now or lose money. This is a trick to panic you.",
    "Never trust unknown links or urgent messages asking for money or OTP. When in doubt, call your family first.",
    "Tap Start Learning button when you are ready.",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakScreen();
    });
  }

  void _speakScreen() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final fullText = _screenTexts.join(' ');
    tts.speak(fullText);
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to TTS toggle — if user just turned ON, read the screen
    final ttsEnabled = context.watch<TtsProvider>().enabled;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Stay Safe Online", style: TextStyle(fontSize: 18)),
        actions: [
          TtsToggleButton(onToggled: _speakScreen),   // ← pass callback
        ],
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
              child: const Column(
                children: [
                  Icon(Icons.security, color: Colors.white, size: 52),
                  SizedBox(height: 12),
                  Text(
                    "Stay Safe from\nGovernment Scheme Scams",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.4),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Many fraud calls and messages target farmers.\nThis lesson will help you protect yourself.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text("You will learn:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),

            _lessonCard(Icons.link_off, "Fake links", "Bit.ly or unknown links are dangerous. Real sites end in .gov.in", Colors.red.shade50, Colors.red),
            _lessonCard(Icons.sms_failed, "Fake OTP requests", "No government officer ever asks for OTP. That's a scam.", Colors.orange.shade50, Colors.orange),
            _lessonCard(Icons.lock, "Safe information", "Only share basic details — never passwords, PINs, or full bank info.", Colors.green.shade50, Colors.green),
            _lessonCard(Icons.alarm, "Urgency tricks", "Scammers say 'Act now or lose money!' — this is a trick to panic you.", Colors.purple.shade50, Colors.purple),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.deepOrange, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Never trust unknown links or urgent messages asking for money or OTP. When in doubt — CALL YOUR FAMILY FIRST.",
                      style: TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w500),
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
                label: const Text("Start Learning", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
        border: Border.all(color: iconColor.withOpacity(0.3)),
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