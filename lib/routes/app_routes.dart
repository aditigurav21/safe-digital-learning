import 'package:flutter/material.dart';

// Home
import '../features/home/home_screen.dart';

// -------------------------
// SIMULATION 1 (Gov Scheme)
// -------------------------
import '../features/simulation1/gov_scheme/intro_screen.dart';
import '../features/simulation1/gov_scheme/scam_examples_screen.dart';
import '../features/simulation1/gov_scheme/form_screen.dart';
import '../features/simulation1/gov_scheme/otp_screen.dart';
import '../features/simulation1/gov_scheme/link_check_screen.dart';
import '../features/simulation1/gov_scheme/success_screen.dart';
import '../features/simulation1/gov_scheme/call_screen.dart';
// Quiz

import '../features/simulation1/quiz/sim1_quiz_screen.dart';
import '../features/simulation1/quiz/sim1_result.dart';
class AppRoutes {
  static Map<String, WidgetBuilder> routes = {

    // Home
    '/': (context) => HomeScreen(),

    // -------------------------
    // SIMULATION 1 (YOUR MODULE)
    // -------------------------
    '/sim1-intro': (context) => IntroScreen(),
    '/sim1-examples': (context) => ScamExamplesScreen(),
    '/sim1-form': (context) => FormScreen(),
    '/sim1-otp': (context) => OtpScreen(),
    '/sim1-link': (context) => LinkCheckScreen(),
    '/sim1-success': (context) => SuccessScreen(),

    // -------------------------
    // QUIZ
   '/sim1-quiz': (context) => Sim1QuizScreen(),
'/sim1-quiz-result': (context) => Sim1ResultScreen(),
'/sim1-call': (context) => CallScreen(),
  };
}