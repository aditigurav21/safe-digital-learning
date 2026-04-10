import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/home/home_screen.dart';
import '../../features/auth/login_screen.dart';
import '../locale/locale_provider.dart';   // ← add

class AuthWrapper extends StatelessWidget {
  final LocaleProvider localeProvider;     // ← add
  const AuthWrapper({super.key, required this.localeProvider});  // ← add

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(localeProvider: localeProvider);  // ← pass it
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}