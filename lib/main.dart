// <<<<<<< HEAD
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'app.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// =======
// /*import 'package:flutter/material.dart';
// import 'app.dart';


// void main() {
//   runApp(const MyApp());   // add const
// }
// */

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/tts_provider.dart';
// import 'app.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => TtsProvider(),
//       child: const MyApp(),
//     ),
//   );

// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ ADD THIS

import 'providers/tts_provider.dart';
import 'app.dart';

void main() async {   // ✅ MAKE ASYNC
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // ✅ NOW WORKS

  runApp(
    ChangeNotifierProvider(
      create: (_) => TtsProvider(),
      child: const MyApp(),
    ),
  );
}