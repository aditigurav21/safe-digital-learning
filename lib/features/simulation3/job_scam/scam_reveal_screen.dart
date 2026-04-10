import 'package:flutter/material.dart';
import 'package:safe_digital_learning/core/constants/colors.dart';

class ScamRevealScreen extends StatelessWidget {
  const ScamRevealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
            {'reported': false, 'flagsFound': 0};
    final bool reported = args['reported'] as bool;
    //final int flagsFound = args['flagsFound'] as int;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Result icon
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: reported
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    reported ? '🛡️' : '😬',
                    style: const TextStyle(fontSize: 44),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                reported ? 'Great Catch!' : 'You Almost Got Scammed!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: reported ? Colors.green : Colors.orange.shade800,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                reported
                    ? 'You correctly identified this as a scam and reported it. That\'s exactly what you should do!'
                    : 'You submitted your personal data to a fake job site. In a real scenario, your information could now be used for fraud.',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Red flags reveal
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🚩 All Red Flags in This Scam:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.red),
                    ),
                    SizedBox(height: 12),
                    _FlagRevealItem(
                      flag: 'Fake URL',
                      detail: '"unstop-jobs.site" is NOT unstop.com. Always check the exact domain.',
                    ),
                    _FlagRevealItem(
                      flag: 'Unrealistic Salary',
                      detail: '₹40,000/month for zero-experience internship is a bait tactic.',
                    ),
                    _FlagRevealItem(
                      flag: 'Urgency Pressure',
                      detail: '"Apply in 10 minutes" forces panic — real jobs never expire this fast.',
                    ),
                    _FlagRevealItem(
                      flag: 'No Verifiable Company Info',
                      detail: 'No LinkedIn, no official website, no CIN number.',
                    ),
                    _FlagRevealItem(
                      flag: 'Asking for Aadhaar/Bank/OTP',
                      detail: 'NEVER share these in a job application. Ever.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Safety tips
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✅ How to Stay Safe:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    _SafetyTip(tip: 'Always verify the URL matches the official website'),
                    _SafetyTip(tip: 'Search the company name + "review" or "scam" online'),
                    _SafetyTip(tip: 'Never share Aadhaar, OTP, or bank details in a form'),
                    _SafetyTip(tip: 'Report suspicious jobs to cybercrime.gov.in'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/sim3-quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Take the Quiz →',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlagRevealItem extends StatelessWidget {
  final String flag;
  final String detail;
  const _FlagRevealItem({required this.flag, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🚩 ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(flag,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.red)),
                Text(detail,
                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SafetyTip extends StatelessWidget {
  final String tip;
  const _SafetyTip({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('✅ ', style: TextStyle(fontSize: 13)),
          Expanded(
            child: Text(tip,
                style: const TextStyle(fontSize: 13, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}