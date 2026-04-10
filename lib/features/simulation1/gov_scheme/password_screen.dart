
import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController controller = TextEditingController();
  bool _obscure = true;
  String strength = "";
  Color strengthColor = Colors.grey;
  double strengthValue = 0;
  String strengthEmoji = "";

  void checkPasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() { strength = ""; strengthValue = 0; });
      return;
    }

    bool hasUpper = password.contains(RegExp(r'[A-Z]'));
    bool hasLower = password.contains(RegExp(r'[a-z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (password.length < 6) {
      setState(() { strength = "Very Weak"; strengthColor = Colors.red; strengthValue = 0.2; strengthEmoji = "❌"; });
    } else if (password.length >= 6 && (!hasUpper || !hasNumber || !hasSpecial)) {
      setState(() { strength = "Weak"; strengthColor = Colors.orange; strengthValue = 0.4; strengthEmoji = "⚠️"; });
    } else if (password.length >= 8 && hasUpper && hasLower && hasNumber && hasSpecial) {
      setState(() { strength = "Strong"; strengthColor = Colors.green; strengthValue = 1.0; strengthEmoji = "✅"; });
    } else {
      setState(() { strength = "Medium"; strengthColor = Colors.blue; strengthValue = 0.65; strengthEmoji = "👍"; });
    }
  }

  void submitPassword() {
    if (strength == "Strong") {
      Navigator.pushNamed(context, '/otp');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.lock_open, color: Colors.orange, size: 30),
              SizedBox(width: 10),
              Text("Improve Password", style: TextStyle(fontSize: 18)),
            ],
          ),
          content: const Text(
            "Your password is not strong enough yet.\n\n"
            "A strong password protects your account.\n\n"
            "Use:\n"
            "• At least 8 characters\n"
            "• Capital letters (A, B, C...)\n"
            "• Numbers (1, 2, 3...)\n"
            "• Symbols (@, #, !...)\n\n"
            "Example: Kisan@2024!",
            style: TextStyle(fontSize: 15, height: 1.7),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Try Again", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text("Set a Strong Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create a strong password to protect your account",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text("A strong password is like a strong lock on your door.",
                style: TextStyle(fontSize: 14, color: Colors.grey)),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              obscureText: _obscure,
              onChanged: checkPasswordStrength,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: "Enter Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),

            const SizedBox(height: 14),

            if (strength.isNotEmpty) ...[
              Row(
                children: [
                  Text(strengthEmoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 10),
                  Text(strength,
                      style: TextStyle(color: strengthColor, fontWeight: FontWeight.bold, fontSize: 17)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: strengthValue,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
                  minHeight: 10,
                ),
              ),
            ],

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Tips:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _tip("Use at least 8 characters"),
                  _tip("Mix Capital and small letters: Kisan / kisan"),
                  _tip("Add numbers: 2024"),
                  _tip("Add symbols: @, #, !"),
                  _tip("DON'T use your name or phone number"),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Good example: Kisan@2024!",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green)),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: submitPassword,
                icon: const Icon(Icons.arrow_forward, size: 24),
                label: const Text("Continue", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, height: 1.4))),
        ],
      ),
    );
  }
}