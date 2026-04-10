import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool callAccepted = false;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playRingtone();
  }

  void playRingtone() async {
    await player.play(AssetSource('audio/ringtone.mp3'));
  }

  void playScamVoice() async {
    await player.stop();
    await player.play(AssetSource('audio/scam_voice.mp3'));
  }

  void stopAudio() async {
    await player.stop();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

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
                stopAudio();
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
                playScamVoice();
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

  // 📞 Conversation UI
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
              "Scammer is speaking...\n\n"
              "They are asking for your OTP urgently.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          const Spacer(),

          const Text(
            "What will you do?",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

          const SizedBox(height: 20),

          // ❌ Wrong
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              showResult(false);
            },
            child: const Text("Share OTP ❌"),
          ),

          const SizedBox(height: 10),

          // ✅ Correct
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              showResult(true);
            },
            child: const Text("Do NOT Share OTP ✅"),
          ),
        ],
      ),
    );
  }

  void showResult(bool safe) {
    stopAudio();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(safe ? "Correct ✅" : "Scam ❌"),
        content: Text(
          safe
              ? "Good! Never share OTP on calls."
              : "This was a scam. Never share OTP on calls.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-otp');
            },
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }
}
