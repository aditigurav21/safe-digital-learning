// import 'package:flutter/material.dart';
// import '../../../core/constants/colors.dart';

// class Sim4ResultScreen extends StatelessWidget {
//   const Sim4ResultScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments as Map?;
//     final int score = args?['score'] ?? 0;
//     final int total = args?['total'] ?? 7;
//     final double percent = score / total;

//     final String grade = percent == 1.0
//         ? 'Insurance Expert! 🏆'
//         : percent >= 0.8
//             ? 'Well Protected! 🛡️'
//             : percent >= 0.6
//                 ? 'Getting Smarter 📈'
//                 : 'Keep Learning 💪';

//     final Color gradeColor = percent >= 0.8
//         ? Colors.green
//         : percent >= 0.6
//             ? Colors.orange
//             : Colors.red;

//     final String message = percent == 1.0
//         ? 'Outstanding! You understand health insurance and can protect yourself from scams.'
//         : percent >= 0.8
//             ? 'Great job! You understand the basics. Review the policy decoder for any gaps.'
//             : percent >= 0.6
//                 ? 'Good effort! Go back to the simulation to reinforce your knowledge.'
//                 : 'Don\'t worry — this topic is confusing for everyone. Revisit the lessons and try again!';

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               const Spacer(),

//               // Score circle
//               Container(
//                 padding: const EdgeInsets.all(28),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: gradeColor.withValues(alpha: 0.1),
//                   border: Border.all(
//                       color: gradeColor.withValues(alpha: 0.3),
//                       width: 3),
//                 ),
//                 child: Text(
//                   '$score/$total',
//                   style: TextStyle(
//                       fontSize: 48,
//                       fontWeight: FontWeight.bold,
//                       color: gradeColor),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               Text(grade,
//                   style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: gradeColor)),
//               const SizedBox(height: 12),

//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey.shade700,
//                     height: 1.5),
//               ),
//               const SizedBox(height: 32),

//               // Key reminders
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.teal.shade50,
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(color: Colors.teal.shade200),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('🛡️ Always Remember:',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Colors.teal.shade800)),
//                     const SizedBox(height: 10),
//                     const Text(
//                       '• Never share OTP with anyone — ever\n'
//                       '• Check network hospital list before admission\n'
//                       '• Declare all diseases honestly when buying policy\n'
//                       '• Keep original bills for 30+ days after discharge\n'
//                       '• Co-payment = you always pay 20% yourself',
//                       style: TextStyle(fontSize: 14, height: 1.8),
//                     ),
//                   ],
//                 ),
//               ),

//               const Spacer(),

//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal.shade600,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14)),
//                   ),
//                   onPressed: () => Navigator.pushNamedAndRemoveUntil(
//                       context, '/', (r) => false),
//                   child: const Text('Back to Home',
//                       style:
//                           TextStyle(fontSize: 17, color: Colors.white)),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextButton(
//                 onPressed: () => Navigator.pushNamedAndRemoveUntil(
//                     context, '/sim4-intro', (r) => false),
//                 child: const Text('Retry Simulation',
//                     style: TextStyle(fontSize: 16)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class Sim4ResultScreen extends StatelessWidget {
  const Sim4ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final int score = args?['score'] ?? 0;
    final int total = args?['total'] ?? 7;
    final double percent = score / total;

    final String grade = percent == 1.0
        ? 'Insurance Expert! 🏆'
        : percent >= 0.8
            ? 'Well Protected! 🛡️'
            : percent >= 0.6
                ? 'Getting Smarter 📈'
                : 'Keep Learning 💪';

    final Color gradeColor = percent >= 0.8
        ? Colors.green
        : percent >= 0.6
            ? Colors.orange
            : Colors.red;

    final String message = percent == 1.0
        ? 'Outstanding! You understand health insurance and can protect yourself from scams.'
        : percent >= 0.8
            ? 'Great job! You understand the basics. Review the policy decoder for any gaps.'
            : percent >= 0.6
                ? 'Good effort! Go back to the simulation to reinforce your knowledge.'
                : 'Don\'t worry — this topic is confusing for everyone. Revisit the lessons and try again!';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(   // ✅ FIX
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Score circle
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: gradeColor.withOpacity(0.1),
                  border: Border.all(
                    color: gradeColor.withOpacity(0.3),
                    width: 3,
                  ),
                ),
                child: Text(
                  '$score/$total',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: gradeColor,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                grade,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: gradeColor,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // Key reminders
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🛡️ Always Remember:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '• Never share OTP with anyone — ever\n'
                      '• Check network hospital list before admission\n'
                      '• Declare all diseases honestly when buying policy\n'
                      '• Keep original bills for 30+ days after discharge\n'
                      '• Co-payment = you always pay 20% yourself',
                      style: TextStyle(fontSize: 14, height: 1.8),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (r) => false),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/sim4-intro', (r) => false),
                child: const Text(
                  'Retry Simulation',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}