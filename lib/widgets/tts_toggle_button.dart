/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tts_provider.dart';

class TtsToggleButton extends StatelessWidget {
  const TtsToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final tts = context.watch<TtsProvider>();
    return IconButton(
      tooltip: tts.enabled ? "Turn off voice" : "Turn on voice",
      icon: Icon(
        tts.enabled ? Icons.volume_up : Icons.volume_off,
        color: tts.enabled ? Colors.green : Colors.grey,
        size: 28,
      ),
      onPressed: () {
        tts.toggle();
        if (tts.enabled) {
          tts.speak("Voice reading is now on. I will read everything for you.");
        }
      },
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tts_provider.dart';

class TtsToggleButton extends StatelessWidget {
  final VoidCallback? onToggled;   // ← new optional callback

  const TtsToggleButton({super.key, this.onToggled});

  @override
  Widget build(BuildContext context) {
    final tts = context.watch<TtsProvider>();
    return IconButton(
      tooltip: tts.enabled ? "Turn off voice" : "Turn on voice",
      icon: Icon(
        tts.enabled ? Icons.volume_up : Icons.volume_off,
        color: tts.enabled ? Colors.green : Colors.grey,
        size: 28,
      ),
      onPressed: () {
        tts.toggle();
        if (tts.enabled) {
          // Small delay so toggle completes before speaking
          Future.delayed(const Duration(milliseconds: 200), () {
            onToggled?.call();   // ← calls the screen's _speakScreen()
          });
        }
      },
    );
  }
}