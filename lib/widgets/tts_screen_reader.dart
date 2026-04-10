import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tts_provider.dart';

class TtsScreenReader extends StatefulWidget {
  final Widget child;
  final String? customText; // optional override if you want custom text for one screen

  const TtsScreenReader({
    super.key,
    required this.child,
    this.customText,
  });

  @override
  State<TtsScreenReader> createState() => _TtsScreenReaderState();
}

class _TtsScreenReaderState extends State<TtsScreenReader> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _readScreen();
    });
  }

  void _readScreen() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;

    if (widget.customText != null) {
      tts.speak(widget.customText!);
      return;
    }

    // Automatically walk the widget tree and collect all Text content
    final buffer = StringBuffer();
    _collectText(context, buffer);
    final fullText = buffer.toString().trim();
    if (fullText.isNotEmpty) {
      tts.speak(fullText);
    }
  }

  void _collectText(BuildContext context, StringBuffer buffer) {
    void visitor(Element element) {
      if (element.widget is Text) {
        final textWidget = element.widget as Text;
        final content = textWidget.data ?? textWidget.textSpan?.toPlainText() ?? '';
        if (content.trim().isNotEmpty) {
          buffer.write('$content. ');
        }
      }
      element.visitChildren(visitor);
    }
    context.visitChildElements(visitor);
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}