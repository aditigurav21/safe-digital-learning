
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  void showScamPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: Colors.red.shade50,
        title: const Row(
          children: [
            Icon(Icons.message, color: Colors.red, size: 30),
            SizedBox(width: 10),
            Text("Incoming Message!", style: TextStyle(fontSize: 20, color: Colors.red)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\"Namaste ji, I am messaging from PM Kisan Office.\n\n"
              "Your ₹6000 payment is ready. Please share the OTP you just received to confirm your identity.\"",
              style: TextStyle(fontSize: 16, height: 1.7, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 14),
            Text(
              "What will you do?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-link', arguments: false);
            },
            icon: const Icon(Icons.share),
            label: const Text("Share OTP", style: TextStyle(fontSize: 15)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _showSafeChoice();
            },
            icon: const Icon(Icons.block),
            label: const Text("Refuse & Block", style: TextStyle(fontSize: 15)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
          ),
        ],
      ),
    );
  }

  void _showSafeChoice() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: Colors.green.shade50,
        title: const Row(
          children: [
            Icon(Icons.shield, color: Colors.green, size: 32),
            SizedBox(width: 10),
            Text("Great Choice!", style: TextStyle(fontSize: 20)),
          ],
        ),
        content: const Text(
          "You are RIGHT to refuse!\n\n"
          "No government officer EVER asks for OTP on phone or message.\n\n"
          "Real PM Kisan payments happen automatically — no OTP needed.\n\n"
          "If someone asks for OTP, it is ALWAYS a scam. Block and call 1930.",
          style: TextStyle(fontSize: 15, height: 1.7),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-link', arguments: true);
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Continue", style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) showScamPopup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.lock_clock, size: 60, color: Colors.blue),
            const SizedBox(height: 16),
            const Text("Enter OTP sent to your mobile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("OTP sent to ****56789",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 24),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 22, letterSpacing: 10),
              maxLength: 6,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "6-digit OTP",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
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
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 26),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Remember: NEVER share this OTP with anyone on phone — not even someone claiming to be from the government or bank.",
                      style: TextStyle(fontSize: 14, height: 1.6),
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
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      title: const Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
                          SizedBox(width: 10),
                          Text("Wait! ⚠", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      content: const Text(
                        "Did someone on the phone ask for this OTP?\n\n"
                        "If YES — that is a SCAM. Stop. Hang up.\n\n"
                        "You only enter OTP on the WEBSITE — never tell it to anyone.",
                        style: TextStyle(fontSize: 15, height: 1.7),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/sim1-link', arguments: false);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: const Text("Understood", style: TextStyle(fontSize: 16, color: Colors.white)),
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Submit OTP", style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
