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

// Simulation 2 (Scam Detection)
import '../features/simulation2/sim2_intro_screen.dart';
import '../features/simulation2/instagram_feed_screen.dart';
import '../features/simulation2/scam_shop_screen.dart';
import '../features/simulation2/otp_chat_screen.dart';
import '../features/simulation2/sim2_debrief_screen.dart';
import '../features/simulation2/quiz/sim2_quiz_screen.dart';
import '../features/simulation2/quiz/sim2_result.dart';

// Simulation 3 — Job Scam
import '../features/simulation3/job_scam/intro_screen.dart';
import '../features/simulation3/job_scam/job_feed_screen.dart';
import '../features/simulation3/job_scam/job_detail_screen.dart';
import '../features/simulation3/job_scam/fake_form_screen.dart';
import '../features/simulation3/job_scam/scam_reveal_screen.dart';
import '../features/simulation3/job_scam/sim3_quiz_screen.dart';
import '../features/simulation3/job_scam/sim3_result_screen.dart';

//simulation 4 - health insaurance
import '../features/simulation4/sim4_intro_screen.dart';
import '../features/simulation4/sim4_scam_detector_screen.dart';
import '../features/simulation4/sim4_policy_decoder_screen.dart';
import '../features/simulation4/sim4_claim_screen.dart';
import '../features/simulation4/quiz/sim4_quiz_screen.dart';
import '../features/simulation4/quiz/sim4_result_screen.dart';

// Quiz
import '../features/quiz/level_map_screen.dart';
import '../features/quiz/quiz_screen.dart';
import '../features/quiz/result_screen.dart';

// Dashboard
import '../features/dashboard/dashboard_screen.dart';

// Simulation 1 Quiz
import '../features/simulation1/quiz/sim1_quiz_screen.dart';
import '../features/simulation1/quiz/sim1_result.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {

    // Home no need added auth wrapper will handle it
   // '/': (context) => HomeScreen(),

    // -------------------------
    // SIMULATION 1 (Gov Scheme)
    // -------------------------
    '/sim1-intro': (context) => IntroScreen(),
    '/sim1-examples': (context) => ScamExamplesScreen(),
    '/sim1-form': (context) => FormScreen(),
    '/sim1-otp': (context) => OtpScreen(),
    '/sim1-link': (context) => LinkCheckScreen(),
    '/sim1-success': (context) => SuccessScreen(),
    '/sim1-call': (context) => CallScreen(),

    // Simulation 1 Quiz
    '/sim1-quiz': (context) => Sim1QuizScreen(),
    '/sim1-quiz-result': (context) => Sim1ResultScreen(),

    // -------------------------
    // SIMULATION 2
    // -------------------------
    '/sim2-intro': (context) => Sim2IntroScreen(),
    '/sim2-feed': (context) => InstagramFeedScreen(),
    '/sim2-shop': (context) => ScamShopScreen(),
    '/sim2-chat': (context) => OtpChatScreen(),
    '/sim2-debrief': (context) => Sim2DebriefScreen(),
    '/sim2-quiz': (context) => Sim2QuizScreen(),
    '/sim2-quiz-result': (context) => Sim2ResultScreen(),

    // -------------------------
    // SIMULATION 3 (Job Scam)
    // -------------------------
    '/sim3-intro': (context) => const Sim3IntroScreen(),
    '/sim3-feed': (context) => const JobFeedScreen(),
    '/sim3-job-detail': (context) => const JobDetailScreen(),
    '/sim3-form': (context) => const FakeFormScreen(),
    '/sim3-reveal': (context) => const ScamRevealScreen(),
    '/sim3-quiz': (context) => const Sim3QuizScreen(),
    '/sim3-result': (context) => const Sim3ResultScreen(),

    //simulation 4

    '/sim4-intro': (_) => const Sim4IntroScreen(),
    '/sim4-scam-detector': (_) => const Sim4ScamDetectorScreen(),
    '/sim4-policy-decoder': (_) => const Sim4PolicyDecoderScreen(),
    //'/sim4-claim': (_) => const Sim4ClaimScreen(),
    '/sim4-claim': (_) => const InsuranceFormSimulation(),
    '/sim4-quiz': (_) => const Sim4QuizScreen(),
    '/sim4-quiz-result': (_) => const Sim4ResultScreen(),


    // -------------------------
    // GLOBAL QUIZ
    // -------------------------
    '/levels': (context) => LevelMapScreen(),
    // '/quiz': (context) => QuizScreen(),
    // '/quiz-result': (context) => ResultScreen(),

    // -------------------------
    // DASHBOARD
    // -------------------------
    '/dashboard': (context) => DashboardScreen(),
  };
}
