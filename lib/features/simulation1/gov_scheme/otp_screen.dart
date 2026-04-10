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
      builder: (context) => AlertDialog(
        title: const Text("⚠ Urgent Message"),
        content: const Text(
          "Dear user,\n\n"
          "To receive your subsidy immediately, please share your OTP.\n\n"
          "This is required for verification.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // ❌ Wrong choice
              Navigator.pushNamed(context, '/sim1-link', arguments: false);
            },
            child: const Text("Share OTP ❌"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // ✅ Correct choice
              Navigator.pushNamed(context, '/sim1-link', arguments: true);
            },
            child: const Text("Do NOT share OTP ✅"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // 🔥 Show scam popup automatically after screen loads
    Future.delayed(const Duration(seconds: 2), () {
      showScamPopup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Enter OTP sent to your mobile",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Even if user enters OTP → show warning
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("⚠ Warning"),
                    content: const Text(
                      "Never share OTP with anyone.\n\n"
                      "Banks and government never ask for OTP.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/sim1-link',
                              arguments: false);
                        },
                        child: const Text("Understood"),
                      )
                    ],
                  ),
                );
              },
              child: const Text("Submit OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
