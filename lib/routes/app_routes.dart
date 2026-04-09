import 'package:flutter/material.dart';

// Home
import '../features/home/home_screen.dart';

// Simulation 1
import '../features/simulation1/account_setup/create_account_screen.dart';
import '../features/simulation1/account_setup/password_screen.dart';
import '../features/simulation1/account_setup/otp_screen.dart';
import '../features/simulation1/account_setup/success_screen.dart';

// Simulation 2
import '../features/simulation2/payment_scam/intro_screen.dart';
import '../features/simulation2/payment_scam/link_detection_screen.dart';
import '../features/simulation2/payment_scam/result_screen.dart';

// Simulation 3 — Job Scam
import '../features/simulation3/job_scam/intro_screen.dart';
import '../features/simulation3/job_scam/job_feed_screen.dart';
import '../features/simulation3/job_scam/job_detail_screen.dart';
import '../features/simulation3/job_scam/fake_form_screen.dart';
import '../features/simulation3/job_scam/scam_reveal_screen.dart';
import '../features/simulation3/job_scam/sim3_quiz_screen.dart';
import '../features/simulation3/job_scam/sim3_result_screen.dart';

// Quiz
import '../features/quiz/quiz_screen.dart';
import '../features/quiz/result_screen.dart';

// Dashboard
import '../features/dashboard/dashboard_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {

    // Home
    '/': (context) => HomeScreen(),

    // Simulation 1
    '/create-account': (context) => CreateAccountScreen(),
    '/password': (context) => PasswordScreen(),
    '/otp': (context) => OTPScreen(),
    '/success': (context) => SuccessScreen(),

    // Simulation 2
    '/sim2-intro': (context) => IntroScreen(),
    '/sim2-link': (context) => LinkDetectionScreen(),
    '/sim2-result': (context) => Sim2ResultScreen(),

    // Simulation 3
    '/sim3-intro': (context) => const Sim3IntroScreen(),
    '/sim3-feed': (context) => const JobFeedScreen(),
    '/sim3-job-detail': (context) => const JobDetailScreen(),
    '/sim3-form': (context) => const FakeFormScreen(),
    '/sim3-reveal': (context) => const ScamRevealScreen(),
    '/sim3-quiz': (context) => const Sim3QuizScreen(),
    '/sim3-result': (context) => const Sim3ResultScreen(),

    // Quiz
    '/quiz': (context) => QuizScreen(),
    '/quiz-result': (context) => QuizResultScreen(),

    // Dashboard
    '/dashboard': (context) => DashboardScreen(),
  };
}