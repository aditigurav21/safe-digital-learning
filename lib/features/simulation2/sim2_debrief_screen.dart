import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class Sim2DebriefScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final bool caughtByScammer = args?['caughtByScammer'] ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Result badge
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: caughtByScammer
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                  ),
                  child: Icon(
                    caughtByScammer
                        ? Icons.warning_rounded
                        : Icons.shield_outlined,
                    size: 60,
                    color: caughtByScammer ? Colors.red : Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  caughtByScammer
                      ? 'You were caught this time'
                      : 'You stayed safe! 🎉',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: caughtByScammer ? Colors.red : Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'But now you know exactly how this scam works.',
                  style:
                  TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),

              const Text('All Red Flags in This Scam',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              _RedFlagCard(
                number: '1',
                title: 'Fake Instagram account',
                description:
                'Only 12 likes, new account, username mimics a real brand with "_99".',
                color: Colors.red,
              ),
              _RedFlagCard(
                number: '2',
                title: 'Impossible price',
                description:
                '₹4,999 for iPhone 15 Pro (real price ₹1,39,900). If it\'s too good to be true, it is.',
                color: Colors.orange,
              ),
              _RedFlagCard(
                number: '3',
                title: 'Fake urgent timer',
                description:
                '"Only 3 left!" and "Offer ends in 47 min" are psychological tricks to stop you from thinking.',
                color: Colors.amber,
              ),
              _RedFlagCard(
                number: '4',
                title: 'Suspicious URL',
                description:
                'flipkart-deals99.in is NOT flipkart.com. Always check the full URL.',
                color: Colors.red,
              ),
              _RedFlagCard(
                number: '5',
                title: 'No HTTPS / Open lock',
                description:
                'The site had no security certificate. Real payment pages always show 🔒.',
                color: Colors.orange,
              ),
              _RedFlagCard(
                number: '6',
                title: 'Aadhaar number requested',
                description:
                'No shopping site needs your Aadhaar. This is identity theft.',
                color: Colors.red,
              ),
              _RedFlagCard(
                number: '7',
                title: 'Fake delivery agent asking for OTP',
                description:
                'Delivery agents never need OTPs. OTPs are only for YOU and should never be shared.',
                color: Colors.red,
              ),

              const SizedBox(height: 32),

              // Side by side comparison
              const Text('Real vs Fake',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _CompareCard(
                      title: '✅ Real Flipkart',
                      points: const [
                        'flipkart.com',
                        '🔒 HTTPS secure',
                        'Never asks Aadhaar',
                        'Payment via Razorpay',
                        'Never asks for OTP',
                      ],
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CompareCard(
                      title: '❌ Fake Site',
                      points: const [
                        'flipkart-deals99.in',
                        '🔓 No HTTPS',
                        'Asked for Aadhaar',
                        'Direct card entry',
                        'Agent asked OTP',
                      ],
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/sim2-quiz'),
                  child: const Text('Take the Final Quiz →',
                      style:
                      TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (r) => false),
                  child: const Text('Back to Home',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RedFlagCard extends StatelessWidget {
  final String number, title, description;
  final Color color;
  const _RedFlagCard(
      {required this.number,
        required this.title,
        required this.description,
        required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha:0.3)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha:0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: color,
            child: Text(number,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: color)),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  final String title;
  final List<String> points;
  final Color color;
  const _CompareCard(
      {required this.title,
        required this.points,
        required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha:0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14)),
          const SizedBox(height: 8),
          ...points.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(p,
                style: const TextStyle(fontSize: 13)),
          )),
        ],
      ),
    );
  }
}
