/*import 'package:flutter/material.dart';
import 'app.dart';


void main() {
  runApp(const MyApp());   // add const
}
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tts_provider.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TtsProvider(),
      child: const MyApp(),
    ),
  );
}