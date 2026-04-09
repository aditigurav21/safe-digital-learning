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

List<Sim1Question> sim1Questions = [
  Sim1Question(
    question: "Is it safe to share OTP with anyone?",
    options: ["Yes", "No", "Only with bank"],
    correctIndex: 1,
  ),
  Sim1Question(
    question: "Which link is safe?",
    options: [
      "bit.ly/kisan-help",
      "pmkisan-support.xyz",
      "https://pmkisan.gov.in"
    ],
    correctIndex: 2,
  ),
  Sim1Question(
    question: "What should you do if a message asks for urgent payment?",
    options: [
      "Pay immediately",
      "Ignore and verify",
      "Share bank details"
    ],
    correctIndex: 1,
  ),
  Sim1Question(
    question: "Should you enter Aadhaar on unknown websites?",
    options: ["Yes", "No"],
    correctIndex: 1,
  ),
  Sim1Question(
    question: "Scammers usually create:",
    options: [
      "Trust slowly",
      "Urgency and fear",
      "Official ID cards"
    ],
    correctIndex: 1,
  ),
];