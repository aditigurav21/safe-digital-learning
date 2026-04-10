// class Sim4Question {
//   final String question;
//   final List<String> options;
//   final int correctIndex;
//   final String explanation;

//   const Sim4Question({
//     required this.question,
//     required this.options,
//     required this.correctIndex,
//     required this.explanation,
//   });
// }

// const List<Sim4Question> sim4Questions = [
//   Sim4Question(
//     question:
//         'You receive an SMS: "FREE Senior Citizen Insurance! Share Aadhaar OTP to activate NOW." What should you do?',
//     options: [
//       'Share the OTP quickly before the offer expires',
//       'Call a family member and then share the OTP',
//       'Delete the SMS and block the number — it is a scam',
//       'Reply "Yes" to get more information',
//     ],
//     correctIndex: 2,
//     explanation:
//         'No government or insurance scheme ever asks for Aadhaar OTP via SMS. '
//         'OTPs give access to your identity. This is a scam designed to steal your identity. Always delete such messages.',
//   ),
//   Sim4Question(
//     question:
//         'Your health insurance has a "3-year pre-existing disease waiting period." You have diabetes. When can you claim for diabetes treatment?',
//     options: [
//       'Immediately after buying the policy',
//       'After 6 months',
//       'After 1 year',
//       'After 3 years from the policy start date',
//     ],
//     correctIndex: 3,
//     explanation:
//         'Waiting period means the insurance will NOT pay for that disease during that time. '
//         'If you have diabetes and buy insurance today, diabetes-related claims are covered only after 3 years. '
//         'This is why you should buy insurance early, before diseases develop.',
//   ),
//   Sim4Question(
//     question:
//         'Your policy has a "20% co-payment clause." Your hospital bill is ₹1,00,000. How much does insurance pay?',
//     options: [
//       '₹1,00,000 — full amount',
//       '₹80,000 — you pay ₹20,000',
//       '₹50,000 — you pay ₹50,000',
//       '₹20,000 — you pay ₹80,000',
//     ],
//     correctIndex: 1,
//     explanation:
//         'Co-payment means YOU pay that percentage. 20% co-payment on ₹1 lakh = you pay ₹20,000. '
//         'Insurance pays the remaining ₹80,000. Always keep savings for co-payment — insurance never covers 100%.',
//   ),
//   Sim4Question(
//     question:
//         'For a cashless claim, which hospital must you visit?',
//     options: [
//       'Any hospital near your home',
//       'Only government hospitals',
//       'A hospital on the insurance company\'s network list',
//       'The most expensive hospital for best treatment',
//     ],
//     correctIndex: 2,
//     explanation:
//         'Cashless facility works ONLY at network hospitals — hospitals empanelled with your insurance company. '
//         'Going to a non-network hospital means you pay first and then request reimbursement, which takes weeks.',
//   ),
//   Sim4Question(
//     question:
//         'A caller says "I\'m from LIC, your policy expires today. Pay ₹999 NOW while I stay on call to activate lifetime cover." What is true?',
//     options: [
//       'It is urgent — pay immediately to save the policy',
//       'It is a scam — real insurers never pressure payment on a live call',
//       'Call them back on the same number to verify',
//       'Share your bank OTP to make the payment quickly',
//     ],
//     correctIndex: 1,
//     explanation:
//         'Real insurance companies send written renewal notices by post or email — never urgent phone calls. '
//         '"Stay on call while you pay" is a pressure tactic to stop you from thinking. '
//         'Hang up and call LIC\'s official helpline (1800-209-7070) to verify.',
//   ),
//   Sim4Question(
//     question:
//         'Which of these is NOT covered by most health insurance policies?',
//     options: [
//       'Emergency surgery',
//       'ICU admission',
//       'Regular doctor visits for check-ups (OPD)',
//       'Hospitalisation for 2+ nights',
//     ],
//     correctIndex: 2,
//     explanation:
//         'Most health insurance policies only cover hospitalisation (admitted for 24+ hours). '
//         'OPD (outpatient) visits — regular doctor consultations — are usually NOT covered. '
//         'Always check your policy\'s OPD clause separately.',
//   ),
//   Sim4Question(
//     question:
//         'To file a reimbursement claim, you must submit bills within how many days of discharge?',
//     options: [
//       '7 days',
//       '15 days',
//       '30 days',
//       '90 days',
//     ],
//     correctIndex: 2,
//     explanation:
//         'Most insurance companies require submission of original bills within 30 days of discharge. '
//         'Missing this deadline can result in your claim being rejected. '
//         'Keep all original bills safely — do not lose them.',
//   ),
// ];


class Sim4Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const Sim4Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

const List<Sim4Question> sim4Questions = [
  Sim4Question(
    question:
        'You get an SMS: "FREE Senior Citizen Benefit! Share your Aadhaar OTP to claim ₹5,000 NOW." What should you do?',
    options: [
      'Share the OTP quickly before the offer expires',
      'Call a family member and then share the OTP',
      'Delete the SMS and block the number — it is a scam',
      'Reply "YES" to get more details first',
    ],
    correctIndex: 2,
    explanation:
        'No government scheme ever asks for your Aadhaar OTP via SMS. '
        'Sharing an OTP gives criminals full access to your identity and bank account. '
        'This is a classic scam. Always delete such messages and never share OTPs with anyone.',
  ),
  Sim4Question(
    question:
        'A caller says "I am from your bank. Your account will be blocked in 2 hours. Give me your ATM PIN to verify your identity." What is true?',
    options: [
      'It is urgent — share the PIN to save your account',
      'Ask them to call back tomorrow so you have time to think',
      'It is a scam — real banks NEVER ask for your PIN on a call',
      'Give only the last 4 digits of your PIN to be safe',
    ],
    correctIndex: 2,
    explanation:
        'Real bank employees never ask for your ATM PIN, OTP, or password — not even to "verify" you. '
        '"Your account will be blocked" is a fear tactic to make you act without thinking. '
        'Hang up immediately and call your bank\'s official number printed on your card.',
  ),
  Sim4Question(
    question:
        'Someone at your door says "I am from the government. Pay ₹500 cash now and get ₹10,000 in your account by tomorrow." What should you do?',
    options: [
      'Pay quickly — government schemes are always trustworthy',
      'Ask a neighbour to pay first and see if they receive the money',
      'Refuse to pay — government schemes never collect cash at your home',
      'Pay, but ask for a handwritten receipt',
    ],
    correctIndex: 2,
    explanation:
        'The government never sends people door-to-door to collect cash for benefits. '
        'This "pay small, get big" trick is one of the most common scams targeting senior citizens. '
        'No receipt will protect you — the money is simply gone. Refuse and report to police.',
  ),
  Sim4Question(
    question:
        'You receive a WhatsApp message: "Congratulations! You have won a KBC lottery of ₹25 lakh. Click the link to claim." What is this?',
    options: [
      'A real prize — KBC runs WhatsApp lotteries',
      'A scam — you cannot win a lottery you never entered',
      'Possibly real — click the link to check if it is official',
      'Forward it to family to verify before clicking',
    ],
    correctIndex: 1,
    explanation:
        'You cannot win a lottery or prize draw you never participated in. '
        'These messages are designed to steal your personal details or install malware when you click the link. '
        'KBC, government schemes, and companies do NOT announce prizes on WhatsApp. Delete and ignore.',
  ),
  Sim4Question(
    question:
        'A caller says "I am from the police. Your son is in trouble. Send ₹20,000 immediately and do NOT tell anyone." What should you do?',
    options: [
      'Send money immediately — your son\'s safety comes first',
      'Hang up and directly call your son on his personal number',
      'Send ₹5,000 first and wait for confirmation',
      'Ask the caller for a police ID number and then send money',
    ],
    correctIndex: 1,
    explanation:
        'This is called a "family emergency scam." Criminals create panic so you act without thinking. '
        '"Do not tell anyone" is the biggest warning sign — it stops you from getting help. '
        'Always hang up and directly call your family member yourself. Real police never demand cash on calls.',
  ),
  Sim4Question(
    question:
        'Someone asks you to install an app called "AnyDesk" or "TeamViewer" on your phone to "help fix a problem." What happens if you do this?',
    options: [
      'They can fix your phone remotely — it is completely safe',
      'They can see and control your entire phone, including your bank apps',
      'It only lets them see your screen but not touch anything',
      'The app is safe as long as you watch what they do',
    ],
    correctIndex: 1,
    explanation:
        'Remote access apps like AnyDesk give the other person FULL control of your phone. '
        'They can open your banking apps, transfer money, read OTPs, and steal passwords — all while you watch. '
        'Never install any app at a stranger\'s request. No real bank, government, or tech company asks you to do this.',
  ),
  Sim4Question(
    question:
        'Which of these is the SAFEST thing to do when you receive an unexpected call asking for personal information?',
    options: [
      'Answer all questions if the caller knows your name and address',
      'Share only your Aadhaar number — not your OTP or PIN',
      'Hang up and call back on the official number from the company\'s website or your documents',
      'Stay on the call but do not share your bank details',
    ],
    correctIndex: 2,
    explanation:
        'Scammers often already know your name, address, or Aadhaar number — this does NOT prove they are real. '
        'The safest move is always to hang up and call the official number yourself. '
        'Find that number from your bank passbook, card, or official government website — not from the caller.',
  ),
];