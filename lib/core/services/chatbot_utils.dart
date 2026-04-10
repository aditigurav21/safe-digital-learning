bool isScamRelated(String input) {
  final keywords = [
    "scam", "fraud", "phishing", "otp", "bank",
    "hack", "cyber", "password", "upi", "fake",
    "job scam", "link", "message", "call"
  ];

  return keywords.any((word) =>
      input.toLowerCase().contains(word));
}