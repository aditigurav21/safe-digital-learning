import 'package:safe_digital_learning/l10n/app_localizations.dart';




class Sim1Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Sim1Question({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

/// Call this with AppLocalizations.of(context)! to get localized questions.
List<Sim1Question> getSim1Questions(AppLocalizations l) => [
  Sim1Question(
    question: l.sim1_q1,
    options: [l.sim1_q1_opt1, l.sim1_q1_opt2, l.sim1_q1_opt3],
    correctIndex: 1,
  ),
  Sim1Question(
    question: l.sim1_q2,
    options: [l.sim1_q2_opt1, l.sim1_q2_opt2, l.sim1_q2_opt3],
    correctIndex: 2,
  ),
  Sim1Question(
    question: l.sim1_q3,
    options: [l.sim1_q3_opt1, l.sim1_q3_opt2, l.sim1_q3_opt3],
    correctIndex: 1,
  ),
  Sim1Question(
    question: l.sim1_q4,
    options: [l.sim1_q4_opt1, l.sim1_q4_opt2],
    correctIndex: 1,
  ),
  Sim1Question(
    question: l.sim1_q5,
    options: [l.sim1_q5_opt1, l.sim1_q5_opt2, l.sim1_q5_opt3],
    correctIndex: 1,
  ),
];