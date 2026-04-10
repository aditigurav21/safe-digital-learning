import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'sim4_policy_decoder_screen.dart'; // ✅ FIXED IMPORT

class Sim4IntroScreen extends StatelessWidget {
  const Sim4IntroScreen({super.key});

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
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.health_and_safety_outlined,
                        color: Colors.teal.shade700, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Health Insurance Training',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Healthcare\nInsurance Shield',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Learn how health insurance really works — and how to spot scams targeting senior citizens.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              const _StepTile(
                number: '1',
                icon: Icons.phone_callback_outlined,
                label: 'Identify insurance scam calls & messages',
              ),
              const _StepTile(
                number: '2',
                icon: Icons.description_outlined,
                label: 'Decode your policy document',
              ),
              const _StepTile(
                number: '3',
                icon: Icons.local_hospital_outlined,
                label: 'File a real insurance claim',
              ),
              const _StepTile(
                number: '4',
                icon: Icons.quiz_outlined,
                label: 'Take the final quiz',
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'This is a safe simulation. No real data is collected or stored.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Sim4PolicyDecoderScreen(), // ✅ FIXED
                      ),
                    );
                  },
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

  const _StepTile({
    required this.number,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.teal.shade600,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Icon(icon, color: Colors.teal.shade600, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}