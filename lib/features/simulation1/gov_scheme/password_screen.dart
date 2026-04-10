import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController controller = TextEditingController();

  String strength = "";
  Color strengthColor = Colors.grey;

  void checkPasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        strength = "";
      });
      return;
    }

    bool hasUpper = password.contains(RegExp(r'[A-Z]'));
    bool hasLower = password.contains(RegExp(r'[a-z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (password.length < 6) {
      setState(() {
        strength = "Very Weak ❌";
        strengthColor = Colors.red;
      });
    } else if (password.length >= 6 &&
        (!hasUpper || !hasNumber || !hasSpecial)) {
      setState(() {
        strength = "Weak ⚠️";
        strengthColor = Colors.orange;
      });
    } else if (password.length >= 8 &&
        hasUpper &&
        hasLower &&
        hasNumber &&
        hasSpecial) {
      setState(() {
        strength = "Strong ✅";
        strengthColor = Colors.green;
      });
    } else {
      setState(() {
        strength = "Medium ⚠️";
        strengthColor = Colors.blue;
      });
    }
  }

  void submitPassword() {
    if (strength == "Strong ✅") {
      Navigator.pushNamed(context, '/otp');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("⚠ Improve Password"),
          content: const Text(
              "Your password is not strong enough.\n\n"
              "Use:\n"
              "• At least 8 characters\n"
              "• Uppercase & lowercase letters\n"
              "• Numbers\n"
              "• Special symbols"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Got it"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Secure Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔷 Instruction
            const Text(
              "Create a strong password to protect your account",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // 🔷 Password Field
            TextField(
              controller: controller,
              obscureText: true,
              onChanged: checkPasswordStrength,
              decoration: const InputDecoration(
                labelText: "Enter Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // 🔷 Strength Indicator
            Text(
              strength,
              style: TextStyle(
                color: strengthColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 🔷 Tips
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Tips for strong password:\n"
                "• Use at least 8 characters\n"
                "• Include uppercase & lowercase letters\n"
                "• Add numbers & symbols\n"
                "• Avoid using your name or mobile number",
              ),
            ),

            const Spacer(),

            // 🔷 Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitPassword,
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
