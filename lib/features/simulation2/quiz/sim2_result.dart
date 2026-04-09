import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class Sim2ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final int score = args?['score'] ?? 0;
    final int total = args?['total'] ?? 5;
    final double percent = score / total;

    final String grade = percent == 1.0
        ? 'Digital Guardian! 🛡️'
        : percent >= 0.8
        ? 'Scam Spotter! 🔍'
        : percent >= 0.6
        ? 'Getting Safer 📈'
        : 'Keep Practicing 💪';

    final Color gradeColor = percent >= 0.8
        ? Colors.green
        : percent >= 0.6
        ? Colors.orange
        : Colors.red;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: gradeColor.withOpacity(0.1),
                ),
                child: Text(
                  '$score/$total',
                  style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      color: gradeColor),
                ),
              ),
              const SizedBox(height: 20),
              Text(grade,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: gradeColor)),
              const SizedBox(height: 12),
              Text(
                percent == 1.0
                    ? 'Perfect score! You can identify Instagram scams like a pro.'
                    : percent >= 0.6
                    ? 'Good effort! Review the red flags and try again.'
                    : 'Don\'t worry — learning these skills takes practice. Review the debrief and try again!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    height: 1.5),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (r) => false),
                  child: const Text('Back to Home',
                      style:
                      TextStyle(fontSize: 17, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/sim2-intro', (r) => false),
                child: const Text('Retry Simulation',
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}