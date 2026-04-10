import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakIncoming());
  }

  void _speakIncoming() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    tts.speak(
      '${l.sim1_call_incomingCall}. '
          '${l.sim1_call_unknownWarning}. '
          '${l.sim1_call_acceptOrDecline}.',
    );
  }

  void _speakConversation() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    tts.speak(
      '${l.sim1_call_callConnected}. ${l.sim1_call_scammerSaying}. '
          '${l.sim1_call_scammerScript}. '
          '${l.sim1_call_govNeverOtp}. '
          '${l.sim1_call_whatWillYouDo}. '
          '${l.sim1_call_shareOtp}. ${l.sim1_call_hangUp}.',
    );
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
    if (mounted) context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: callAccepted ? _buildCallConversation() : _buildIncomingCall(),
    );
  }

  Widget _buildIncomingCall() {
    final l = AppLocalizations.of(context)!;
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
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TtsToggleButton(onToggled: _speakIncoming),
                  ),
                ),
                Text(
                  l.sim1_call_incomingCall,
                  style: const TextStyle(
                      color: Color(0xFF8B949E), fontSize: 15, letterSpacing: 1),
                ),
                const SizedBox(height: 20),
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
                          color: const Color(0xFF388BFD).withValues(alpha: 0.35),
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
                Text(
                  l.sim1_call_callerName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3),
                ),
                const SizedBox(height: 6),
                Text(l.sim1_call_callerNumber,
                    style: const TextStyle(
                        color: Color(0xFF8B949E), fontSize: 15)),
                const SizedBox(height: 14),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade900.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border:
                    Border.all(color: Colors.orange.shade700, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.orange, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l.sim1_call_unknownWarning,
                          style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(l.sim1_call_slideHint,
                    style: const TextStyle(
                        color: Color(0xFF8B949E), fontSize: 13)),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _callButton(
                        icon: Icons.call_end,
                        color: Colors.red.shade700,
                        label: l.sim1_call_decline,
                        onTap: () {
                          stopAudio();
                          Navigator.pop(context);
                        },
                      ),
                      _callButton(
                        icon: Icons.call,
                        color: Colors.green.shade600,
                        label: l.sim1_call_accept,
                        onTap: () {
                          setState(() => callAccepted = true);
                          playScamVoice();
                          _pulseController.stop();
                          _startCallTimer();
                          WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => _speakConversation());
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
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 18,
                    spreadRadius: 2)
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

  Widget _buildCallConversation() {
    final l = AppLocalizations.of(context)!;
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
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TtsToggleButton(onToggled: _speakConversation),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.green.withValues(alpha: 0.4)),
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
                        '${l.sim1_call_callConnected}  $_callDuration',
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                Text(l.sim1_call_callerName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
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
                          Text(l.sim1_call_scammerSaying,
                              style: TextStyle(
                                  color: Colors.blue.shade300,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l.sim1_call_scammerScript,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.6,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade900.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.shade700, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.gpp_bad, color: Colors.red, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l.sim1_call_govNeverOtp,
                          style: const TextStyle(
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
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(l.sim1_call_whatWillYouDo,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: () => _showResult(false),
                          icon: const Icon(Icons.share, size: 22),
                          label: Text(l.sim1_call_shareOtp,
                              style: const TextStyle(
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
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: () => _showResult(true),
                          icon: const Icon(Icons.call_end, size: 22),
                          label: Text(l.sim1_call_hangUp,
                              style: const TextStyle(
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
    final l = AppLocalizations.of(context)!;
    final tts = context.read<TtsProvider>();
    tts.speak(safe ? l.sim1_call_resultSafeSpeak : l.sim1_call_resultWrongSpeak);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: safe ? Colors.green.shade50 : Colors.red.shade50,
        title: Row(
          children: [
            Icon(safe ? Icons.shield : Icons.warning_amber_rounded,
                color: safe ? Colors.green : Colors.red, size: 32),
            const SizedBox(width: 10),
            Text(safe ? l.sim1_call_resultSafeTitle : l.sim1_call_resultWrongTitle,
                style: const TextStyle(fontSize: 22)),
          ],
        ),
        content: Text(
          safe ? l.sim1_call_resultSafeBody : l.sim1_call_resultWrongBody,
          style: const TextStyle(fontSize: 15, height: 1.7),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-otp');
            },
            icon: const Icon(Icons.arrow_forward),
            label: Text(l.sim1_common_continue,
                style: const TextStyle(fontSize: 16)),
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