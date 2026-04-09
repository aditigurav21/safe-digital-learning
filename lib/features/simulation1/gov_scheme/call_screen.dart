import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool callAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: callAccepted ? buildCallConversation() : buildIncomingCall(),
    );
  }

  // 📞 Incoming Call UI
  Widget buildIncomingCall() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),

        const Icon(Icons.account_circle, size: 120, color: Colors.white),

        const SizedBox(height: 20),

        const Text(
          "Gov Scheme Officer",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),

        const SizedBox(height: 10),

        const Text(
          "Incoming Call...",
          style: TextStyle(color: Colors.grey),
        ),

        const Spacer(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // ❌ Reject
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.call_end, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text("Reject", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            // ✅ Accept
            GestureDetector(
              onTap: () {
                setState(() {
                  callAccepted = true;
                });
              },
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.call, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text("Accept", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 50),
      ],
    );
  }

  // 📞 Scam Conversation UI
  Widget buildCallConversation() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          const SizedBox(height: 50),

          const Text(
            "Call Connected",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Hello sir,\n\n"
              "You are eligible for ₹5000 government subsidy.\n"
              "To receive money immediately, please tell your OTP.\n\n"
              "This is urgent, otherwise your benefit will expire.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          const Spacer(),

          const Text(
            "What will you do?",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

          const SizedBox(height: 20),

          // ❌ Share OTP (wrong)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                showResult(false);
              },
              child: const Text("Share OTP ❌"),
            ),
          ),

          const SizedBox(height: 10),

          // ✅ Do NOT share OTP (correct)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                showResult(true);
              },
              child: const Text("Do NOT Share OTP ✅"),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // 🔥 Result Popup
  void showResult(bool isSafe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isSafe ? "Correct ✅" : "Scam Alert ❌"),
        content: Text(
          isSafe
              ? "Good job! Real officers never ask for OTP."
              : "This was a scam call!\n\nNever share OTP on phone calls.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              // 👉 Move to OTP Screen
              Navigator.pushNamed(context, '/sim1-otp');
            },
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }
}