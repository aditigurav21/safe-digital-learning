class Sim2Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const Sim2Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

const List<Sim2Question> sim2Questions = [
  Sim2Question(
    question:
    'You see an Instagram ad offering iPhone 15 for ₹4,999. What should you do?',
    options: [
      'Click immediately — great deal!',
      'Check if the account is verified and the price is realistic',
      'Share it with friends so they can also buy',
      'Enter your card details quickly before stock runs out',
    ],
    correctIndex: 1,
    explanation:
    'Always verify: Is the account official? Is the price realistic? iPhone 15 costs ₹1,39,900. No one sells it for ₹4,999 — it\'s a scam.',
  ),
  Sim2Question(
    question: 'A shopping website URL shows: flipkart-deals99.in. Is this safe?',
    options: [
      'Yes, it has "flipkart" in the name',
      'Yes, all .in domains are safe',
      'No — the real Flipkart URL is flipkart.com',
      'Cannot tell from the URL alone',
    ],
    correctIndex: 2,
    explanation:
    'The real Flipkart is only at flipkart.com. "flipkart-deals99.in" is a fake domain. Always check the exact URL.',
  ),
  Sim2Question(
    question:
    'A website asks for your Aadhaar number to "complete KYC" for a shopping order. What do you do?',
    options: [
      'Enter it — KYC is mandatory',
      'Enter only the last 4 digits',
      'Close the site immediately — shopping sites never need Aadhaar',
      'Ask a friend if it\'s okay',
    ],
    correctIndex: 2,
    explanation:
    'No legitimate shopping website needs your Aadhaar number. This is identity theft. Close the site and report it.',
  ),
  Sim2Question(
    question:
    'Someone claiming to be a Flipkart delivery agent calls and says "Please share your OTP for delivery verification". What do you do?',
    options: [
      'Share the OTP — it\'s just for delivery',
      'Refuse — delivery agents never need OTPs',
      'Share only the first 3 digits',
      'Call back on the same number to verify',
    ],
    correctIndex: 1,
    explanation:
    'OTPs are One-Time Passwords meant ONLY for you. No delivery agent, bank, or company needs your OTP. Never share it.',
  ),
  Sim2Question(
    question:
    'You notice the lock icon on a shopping site is open 🔓 instead of closed 🔒. What does this mean?',
    options: [
      'The site is temporarily down',
      'The site is on a slow connection',
      'The site is NOT secure — do not enter payment details',
      'The lock icon doesn\'t matter for shopping',
    ],
    correctIndex: 2,
    explanation:
    '🔒 means HTTPS — encrypted and secure. 🔓 means no encryption — your card details can be stolen. Never pay on 🔓 sites.',
  ),
];
