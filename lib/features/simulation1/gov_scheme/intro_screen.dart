/*import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gov Scheme Safety"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔷 Title
            const Text(
              "Stay Safe from Government Scheme Scams",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 🔷 Description
            const Text(
              "Many fraud messages target farmers with fake schemes.\n\n"
              "This simulation will teach you:",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 15),

            // 🔷 Bullet points
            const Text("• How to identify fake links"),
            const Text("• When NOT to share OTP"),
            const Text("• What information is safe to give"),
            const Text("• How scams trick people"),

            const SizedBox(height: 30),

            // 🔷 Warning card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Never trust unknown links or urgent messages asking for money or OTP.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🔷 Start Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sim1-examples');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Start Learning",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text("Stay Safe Online", style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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