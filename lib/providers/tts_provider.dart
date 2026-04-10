import 'package:flutter/material.dart';
import '../services/tts_service.dart';

class TtsProvider extends ChangeNotifier {
  bool _enabled = false;
  final TtsService _service = TtsService();

  bool get enabled => _enabled;

  void toggle() {
    _enabled = !_enabled;
    if (!_enabled) {
      _service.stop();  // immediately stop if user turns off
    }
    notifyListeners();
  }

  void setEnabled(bool value) {
    _enabled = value;
    if (!_enabled) _service.stop();
    notifyListeners();
  }

  // Call this from any screen when TTS is ON
  Future<void> speak(String text) async {
    if (_enabled) {
      await _service.speak(text);
    }
  }

  Future<void> stop() async {
    await _service.stop();
  }
}