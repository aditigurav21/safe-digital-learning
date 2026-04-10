
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen>
    with SingleTickerProviderStateMixin {
  bool callAccepted = false;
  bool _disposed = false;
  final AudioPlayer player = AudioPlayer();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  int _callSeconds = 0;
  late final Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulseAnimation =
        Tween<double>(begin: 1.0, end: 1.18).animate(_pulseController);
    playRingtone();
    _stopwatch = Stopwatch();
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

  void _startCallTimer() {
    _stopwatch.start();
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_disposed || !callAccepted) return false;
      setState(() => _callSeconds = _stopwatch.elapsed.inSeconds);
      return true;
    });
  }

  String get _callDuration {
    final m = (_callSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_callSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _disposed = true;
    _pulseController.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: callAccepted ? _buildCallConversation() : _buildIncomingCall(),
    );
  }

  // ── Incoming Call Screen ──
  Widget _buildIncomingCall() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Caller info
                const Text(
                  "Incoming Call",
                  style: TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 15,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 20),

                // Pulsing avatar
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1C2333),
                      border: Border.all(
                          color: const Color(0xFF388BFD), width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF388BFD).withOpacity(0.35),
                          blurRadius: 28,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.account_circle,
                        size: 66, color: Color(0xFF388BFD)),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Gov Scheme Officer",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3),
                ),
                const SizedBox(height: 6),
                const Text(
                  "+91 98765 43210",
                  style: TextStyle(color: Color(0xFF8B949E), fontSize: 15),
                ),

                const SizedBox(height: 14),

                // Warning banner
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade900.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: Colors.orange.shade700, width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.orange, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Unknown number — be careful!",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Swipe hint
                const Text(
                  "Slide to answer or decline",
                  style: TextStyle(color: Color(0xFF8B949E), fontSize: 13),
                ),
                const SizedBox(height: 20),

                // Accept / Reject buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Reject
                      _callButton(
                        icon: Icons.call_end,
                        color: Colors.red.shade700,
                        label: "Decline",
                        onTap: () {
                          stopAudio();
                          Navigator.pop(context);
                        },
                      ),

                      // Accept
                      _callButton(
                        icon: Icons.call,
                        color: Colors.green.shade600,
                        label: "Accept",
                        onTap: () {
                          setState(() => callAccepted = true);
                          playScamVoice();
                          _pulseController.stop();
                          _startCallTimer();
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _callButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                    color: color.withOpacity(0.45),
                    blurRadius: 18,
                    spreadRadius: 2),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 10),
          Text(label,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 14, letterSpacing: 0.3)),
        ],
      ),
    );
  }

  // ── Active Call / Conversation Screen ──
  Widget _buildCallConversation() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const SizedBox(height: 28),

                // Status
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.green.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Text(
                        "Call Connected  $_callDuration",
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Avatar
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1C2333),
                    border:
                        Border.all(color: Colors.green.shade700, width: 2),
                  ),
                  child: const Icon(Icons.account_circle,
                      size: 60, color: Colors.white54),
                ),
                const SizedBox(height: 10),
                const Text("Gov Scheme Officer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 20),

                // Scammer script bubble
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2333),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    border: Border.all(color: const Color(0xFF30363D)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.record_voice_over,
                              color: Color(0xFF388BFD), size: 18),
                          const SizedBox(width: 8),
                          Text("Scammer is saying...",
                              style: TextStyle(
                                  color: Colors.blue.shade300,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "\"Namaste ji! Main PM Kisan office se bol raha hoon.\n\n"
                        "Aapka ₹6000 payment ready hai. Sirf OTP share karo — abhi ke abhi — varna payment cancel ho jayegi!\"",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.6,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Scam warning card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade900.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.shade700, width: 1),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.gpp_bad, color: Colors.red, size: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Government NEVER asks for OTP on a call. This is a scam.",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Question
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "What will you do?",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 14),

                // Choices
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Wrong choice
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: () => _showResult(false),
                          icon: const Icon(Icons.share, size: 22),
                          label: const Text("Share OTP",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Correct choice
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: () => _showResult(true),
                          icon: const Icon(Icons.call_end, size: 22),
                          label: const Text("Hang Up — Never Share OTP",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResult(bool safe) {
    stopAudio();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor:
            safe ? Colors.green.shade50 : Colors.red.shade50,
        title: Row(
          children: [
            Icon(safe ? Icons.shield : Icons.warning_amber_rounded,
                color: safe ? Colors.green : Colors.red, size: 32),
            const SizedBox(width: 10),
            Text(safe ? "Well Done! ✅" : "Oops! ❌",
                style: const TextStyle(fontSize: 22)),
          ],
        ),
        content: Text(
          safe
              ? "You made the RIGHT choice!\n\n"
                  "Real government officers NEVER ask for OTP on a phone call.\n\n"
                  "PM Kisan payments happen automatically — no OTP needed. "
                  "Anyone asking for OTP is a SCAMMER."
              : "You fell for the scam!\n\n"
                  "Real government officers NEVER ask for OTP.\n\n"
                  "If you share OTP, scammers can empty your bank account in minutes. "
                  "Always hang up and call 1930 (Cyber Crime Helpline).",
          style: const TextStyle(fontSize: 15, height: 1.7),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-otp');
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Continue", style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: safe ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}