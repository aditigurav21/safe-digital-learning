import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class Sim2IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.orange.shade700, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Training Simulation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'The Instagram\nScam Trap',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'You will browse a fake Instagram feed. A scam ad will appear. '
                    'We will guide you through every red flag — step by step.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              _StepTile(
                  number: '1',
                  icon: Icons.photo_library_outlined,
                  label: 'Browse the Instagram feed'),
              _StepTile(
                  number: '2',
                  icon: Icons.ad_units_outlined,
                  label: 'Spot the suspicious ad'),
              _StepTile(
                  number: '3',
                  icon: Icons.language,
                  label: 'Examine the fake shopping site'),
              _StepTile(
                  number: '4',
                  icon: Icons.chat_bubble_outline,
                  label: 'Resist the AI scammer chat'),
              _StepTile(
                  number: '5',
                  icon: Icons.quiz_outlined,
                  label: 'Take the final quiz'),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/sim2-feed'),
                  child: const Text(
                    'Start Simulation',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final String number;
  final IconData icon;
  final String label;
  const _StepTile(
      {required this.number, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary,
            child: Text(number,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 14),
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 10),
          Text(label,
              style:
              const TextStyle(fontSize: 16, color: AppColors.text)),
        ],
      ),
    );
  }
}