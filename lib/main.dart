/*import 'package:flutter/material.dart';
import 'app.dart';


void main() {
  runApp(const MyApp());   // add const
}
*/import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // 👈 ADD THIS
import 'providers/tts_provider.dart';
import 'core/locale/locale_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // 👈 ADD THIS LINE

  final localeProvider = LocaleProvider();
  await localeProvider.loadSavedLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TtsProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
        
      ],
      child: const MyApp(),
    ),
  );
}