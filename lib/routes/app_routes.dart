import 'package:flutter/material.dart';

// Home
import '../features/home/home_screen.dart';

// Simulation 1 (Account Setup)
import '../features/simulation1/account_setup/create_account_screen.dart';
import '../features/simulation1/account_setup/password_screen.dart';
import '../features/simulation1/account_setup/otp_screen.dart';
import '../features/simulation1/account_setup/success_screen.dart';

// Simulation 2 (Scam Detection)
import '../features/simulation2/payment_scam/intro_screen.dart';
import '../features/simulation2/payment_scam/link_detection_screen.dart';
import '../features/simulation2/payment_scam/result_screen.dart';

// Quiz
import '../features/quiz/quiz_screen.dart';
import '../features/quiz/result_screen.dart';

// Dashboard
import '../features/dashboard/dashboard_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {

    // Home
    '/': (context) => HomeScreen(),

    // -------------------------
    // SIMULATION 1 ROUTES
    // -------------------------
    '/create-account': (context) => CreateAccountScreen(),
    '/password': (context) => PasswordScreen(),
    '/otp': (context) => OTPScreen(),
    '/success': (context) => SuccessScreen(),

    // -------------------------
    // SIMULATION 2 ROUTES
    // -------------------------
    '/sim2-intro': (context) => IntroScreen(),
    '/sim2-link': (context) => LinkDetectionScreen(),
    '/sim2-result': (context) => Sim2ResultScreen(),

    // -------------------------
    // QUIZ ROUTES
    // -------------------------
    '/quiz': (context) => QuizScreen(),
    '/quiz-result': (context) => QuizResultScreen(),

    // -------------------------
    // DASHBOARD
    // -------------------------
    '/dashboard': (context) => DashboardScreen(),
  };
}