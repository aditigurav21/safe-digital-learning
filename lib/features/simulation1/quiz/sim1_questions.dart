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
    question: "Someone calls and says 'Share your OTP to get your PM Kisan money'. What should you do?",
    options: [
      "Share the OTP with them",
      "Refuse and hang up — it is a scam",
      "Share only if they say please",
    ],
    correctIndex: 1,
  ),
  Sim1Question(
    question: "Which of these websites is SAFE for PM Kisan?",
    options: [
      "bit.ly/kisan-help",
      "pmkisan-support.xyz",
      "https://pmkisan.gov.in",
    ],
    correctIndex: 2,
  ),
  Sim1Question(
    question: "You get a message: 'Pay ₹200 now or your scheme will be cancelled!' What should you do?",
    options: [
      "Pay immediately",
      "Ignore it and verify on the official website",
      "Share your bank details",
    ],
    correctIndex: 1,
  ),
  Sim1Question(
    question: "A WhatsApp message asks for your Aadhaar number for scheme benefit. Is this safe?",
    options: [
      "Yes, share it",
      "No — never share Aadhaar on WhatsApp",
    ],
    correctIndex: 1,
  ),
  Sim1Question(
    question: "Scammers send urgent messages because...?",
    options: [
      "They are very helpful people",
      "Panic makes people act without thinking",
      "They work for the government",
    ],
    correctIndex: 1,
  ),
];