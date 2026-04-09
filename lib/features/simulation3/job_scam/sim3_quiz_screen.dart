import 'package:flutter/material.dart';
import 'package:safe_digital_learning/core/constants/colors.dart';

class Sim3QuizScreen extends StatefulWidget {
  const Sim3QuizScreen({super.key});

  @override
  State<Sim3QuizScreen> createState() => _Sim3QuizScreenState();
}

class _Sim3QuizScreenState extends State<Sim3QuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;

  final List<_QuizQuestion> _questions = [
    _QuizQuestion(
      question: 'A job post says "₹50,000/month for freshers, no experience needed, apply in 5 mins!" What should you do?',
      options: [
        'Apply immediately to grab the slot',
        'Be suspicious — this has too many red flags',
        'Share it with friends so they can apply too',
        'It\'s fine if the company name looks familiar',
      ],
      correctIndex: 1,
      explanation:
          'Unrealistic pay + urgency + no experience required = classic job scam formula. Real companies set requirements for a reason.',
    ),
    _QuizQuestion(
      question: 'You receive a job application link: "unstop-jobs.site/apply". Is this safe?',
      options: [
        'Yes, it says "unstop" so it must be real',
        'Yes, all .site domains are official',
        'No — the real Unstop URL is unstop.com, not unstop-jobs.site',
        'Only safe if it uses HTTPS',
      ],
      correctIndex: 2,
      explanation:
          'Scammers create lookalike domains like "unstop-jobs.site". Always check that the domain exactly matches the official site.',
    ),
    _QuizQuestion(
      question: 'A job application form asks for your Aadhaar number for "identity verification". What do you do?',
      options: [
        'Fill it in — verification is normal',
        'Fill it in only if the form uses HTTPS',
        'Stop immediately — legitimate job forms never ask for Aadhaar',
        'Send a photo of the card instead',
      ],
      correctIndex: 2,
      explanation:
          'Legitimate job applications never need your Aadhaar. This is used for identity theft. Report the form.',
    ),
    _QuizQuestion(
      question: 'After clicking a job link, the page asks for an OTP sent to your phone. What should you do?',
      options: [
        'Enter it quickly to secure your application slot',
        'Never enter an OTP on a form — this is always a scam tactic',
        'Enter it only if you recognize the company',
        'Enter it if the page looks professional',
      ],
      correctIndex: 1,
      explanation:
          'OTPs are like keys to your accounts. NEVER share them on any form or with any person, ever. This is used to take over your accounts.',
    ),
    _QuizQuestion(
      question: 'You find a job post but can\'t find the company on LinkedIn, MCA India, or Google. What does this mean?',
      options: [
        'The company is new — that\'s fine',
        'You searched wrong — try again',
        'Strong red flag — legitimate companies are always verifiable online',
        'Only big companies are on LinkedIn',
      ],
      correctIndex: 2,
      explanation:
          'Any legitimate registered company can be verified on MCA India (mca.gov.in) or LinkedIn. No trace = likely fake.',
    ),
  ];

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentQuestion].correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/sim3-result',
          arguments: {'score': _score, 'total': _questions.length});
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Spot the Red Flags',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: (_currentQuestion + 1) / _questions.length,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Question ${_currentQuestion + 1} of ${_questions.length}',
              style: const TextStyle(
                  color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              q.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(q.options.length, (i) {
              Color bgColor = Colors.white;
              Color borderColor = Colors.grey.shade300;
              Widget? trailingIcon;

              if (_answered) {
                if (i == q.correctIndex) {
                  bgColor = Colors.green.shade50;
                  borderColor = Colors.green;
                  trailingIcon = const Icon(Icons.check_circle, color: Colors.green);
                } else if (i == _selectedAnswer) {
                  bgColor = Colors.red.shade50;
                  borderColor = Colors.red;
                  trailingIcon = const Icon(Icons.cancel, color: Colors.red);
                }
              } else if (_selectedAnswer == i) {
                borderColor = AppColors.primary;
              }

              return GestureDetector(
                onTap: () => _selectAnswer(i),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          q.options[i],
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                      if (trailingIcon != null) trailingIcon,
                    ],
                  ),
                ),
              );
            }),

            // Explanation
            if (_answered)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('💡 ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        q.explanation,
                        style: const TextStyle(fontSize: 13, color: Colors.brown, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),

            const Spacer(),

            if (_answered)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentQuestion < _questions.length - 1
                        ? 'Next Question →'
                        : 'See Results →',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}