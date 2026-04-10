import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  DateTime? selectedDOB;
  bool _loading = false;
  bool _obscure = true;

  Future<void> _pickDOB() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 15),
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year - 5, now.month, now.day),
    );
    if (picked != null) setState(() => selectedDOB = picked);
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedDOB == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your date of birth")),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      // Step 1: Create user in Firebase Auth
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Step 2: Save to Firestore — don't await, do it in background
      FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'dob': selectedDOB!.toIso8601String(),
        'createdAt': FieldValue.serverTimestamp(),
      }).catchError((e) {
        print("Firestore write failed silently: $e");
      });

      // Step 3: Navigate immediately — don't wait for Firestore
      if (mounted) {
        setState(() => _loading = false);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dob = selectedDOB;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.orange),
                ),
                const SizedBox(height: 24),
                // Header
                const Text("Create Account",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A))),
                const SizedBox(height: 6),
                const Text("Join Safe Digital Learning",
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                const SizedBox(height: 36),

                // Name
                _buildLabel("Full Name"),
                _buildField(
                  controller: nameController,
                  hint: "e.g. Vaishnavi Sharma",
                  icon: Icons.person_outline,
                  validator: (v) =>
                  v == null || v.trim().isEmpty ? "Name is required" : null,
                ),
                const SizedBox(height: 20),

                // Email
                _buildLabel("Email Address"),
                _buildField(
                  controller: emailController,
                  hint: "you@example.com",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return "Email is required";
                    if (!v.contains('@')) return "Enter a valid email";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Date of Birth
                _buildLabel("Date of Birth"),
                GestureDetector(
                  onTap: _pickDOB,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.orange.shade100),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.orange.withValues(alpha:0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.cake_outlined, color: Colors.orange),
                        const SizedBox(width: 12),
                        Text(
                          dob == null
                              ? "Select your date of birth"
                              : "${dob.day}/${dob.month}/${dob.year}",
                          style: TextStyle(
                              color:
                              dob == null ? Colors.grey : Colors.black87,
                              fontSize: 15),
                        ),
                        const Spacer(),
                        const Icon(Icons.calendar_today,
                            size: 18, color: Colors.orange),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                _buildLabel("Password"),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscure,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Password is required";
                    if (v.length < 6) return "Minimum 6 characters";
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Min. 6 characters",
                    prefixIcon:
                    const Icon(Icons.lock_outline, color: Colors.orange),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.orange.shade100)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                        const BorderSide(color: Colors.orange, width: 1.5)),
                  ),
                ),
                const SizedBox(height: 36),

                // Signup Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 3,
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Create Account",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                              text: "Login",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xFF444444))),
  );

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.orange),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.orange.shade100)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.orange, width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}