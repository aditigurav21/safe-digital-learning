import 'package:flutter/material.dart';
import 'package:safe_digital_learning/core/constants/colors.dart';

class Sim3ResultScreen extends StatelessWidget {
  const Sim3ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
            {'score': 0, 'total': 5};
    final int score = args['score'] as int;
    final int total = args['total'] as int;
    final double percent = score / total;

    String badge;
    String message;
    Color badgeColor;

    if (percent == 1.0) {
      badge = '🏆 Scam Buster';
      message = 'Perfect score! You can spot a job scam from a mile away. Share this knowledge with friends and family!';
      badgeColor = Colors.amber;
    } else if (percent >= 0.6) {
      badge = '🛡️ Digital Guardian';
      message = 'Good job! You caught most of the red flags. Review the ones you missed and stay sharp!';
      badgeColor = AppColors.primary;
    } else {
      badge = '📚 Keep Learning';
      message = 'Job scams are getting more sophisticated. Retry the simulation to sharpen your instincts!';
      badgeColor = Colors.orange;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(badge, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                Text(
                  badge,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                  ),
                ),
                const SizedBox(height: 16),

                // Score ring
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: badgeColor, width: 6),
                    color: badgeColor.withValues(alpha:0.1),
                  ),
                  child: Center(
                    child: Text(
                      '$score/$total',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: badgeColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamedAndRemoveUntil(context, '/sim3-intro', (r) => false),
                  child: const Text(
                    'Retry Simulation',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
