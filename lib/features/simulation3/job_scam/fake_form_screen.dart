import 'package:flutter/material.dart';
import 'package:safe_digital_learning/core/constants/colors.dart';

class FakeFormScreen extends StatefulWidget {
  const FakeFormScreen({super.key});

  @override
  State<FakeFormScreen> createState() => _FakeFormScreenState();
}

class _FakeFormScreenState extends State<FakeFormScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _aadhaarController = TextEditingController();
  final _bankController = TextEditingController();
  final _otpController = TextEditingController();

  bool _showAadhaarWarning = false;
  bool _showBankWarning = false;
  bool _showOtpWarning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Application Form',
              style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '⚠️ unstop-jobs.site',
              style: TextStyle(color: Colors.red, fontSize: 11),
            ),
          ],
        ),
        leading: const BackButton(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Safety reminder
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Watch for fields that ask for sensitive info. Legitimate job forms NEVER ask for Aadhaar, bank details, or OTPs.',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'TechMinds — Intern Application',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            const Text(
              'Fill all fields to complete your application.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 20),

            // Safe fields
            _buildSafeField('Full Name', 'Enter your name', _nameController, Icons.person),
            const SizedBox(height: 14),
            _buildSafeField('Email Address', 'Enter your email', _emailController, Icons.email),
            const SizedBox(height: 14),
            _buildSafeField('Phone Number', 'Enter your phone', _phoneController, Icons.phone,
                keyboardType: TextInputType.phone),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),

            // Danger section header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '🚨 DANGER ZONE — The following fields are NOT safe',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Aadhaar field
            _buildDangerField(
              label: 'Aadhaar Card Number',
              hint: 'XXXX XXXX XXXX',
              controller: _aadhaarController,
              icon: Icons.credit_card,
              showWarning: _showAadhaarWarning,
              warningText:
                  '🚨 STOP! No legitimate job form asks for your Aadhaar number. This is used for identity theft.',
              onTap: () => setState(() => _showAadhaarWarning = true),
            ),

            const SizedBox(height: 14),

            // Bank field
            _buildDangerField(
              label: 'Bank Account Number',
              hint: 'For stipend transfer',
              controller: _bankController,
              icon: Icons.account_balance,
              showWarning: _showBankWarning,
              warningText:
                  '🚨 STOP! Employers NEVER need your bank account before hiring you. This is financial fraud.',
              onTap: () => setState(() => _showBankWarning = true),
            ),

            const SizedBox(height: 14),

            // OTP field
            _buildDangerField(
              label: 'Enter OTP (sent to your phone)',
              hint: 'Enter 6-digit OTP',
              controller: _otpController,
              icon: Icons.lock,
              showWarning: _showOtpWarning,
              warningText:
                  '🚨 STOP! NEVER share an OTP with anyone, ever. This OTP can be used to steal your money or accounts.',
              onTap: () => setState(() => _showOtpWarning = true),
            ),

            const SizedBox(height: 30),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/sim3-reveal',
                    arguments: {
                      'reported': false,
                      'flagsFound': (_showAadhaarWarning ? 1 : 0) +
                          (_showBankWarning ? 1 : 0) +
                          (_showOtpWarning ? 1 : 0),
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit Application',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/sim3-reveal',
                  arguments: {'reported': true, 'flagsFound': 3},
                ),
                icon: const Icon(Icons.flag, color: Colors.orange),
                label: const Text(
                  'I think this is a scam — Report it',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSafeField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDangerField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required bool showWarning,
    required String warningText,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.red),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: !showWarning,
            child: TextField(
              controller: controller,
              onTap: onTap,
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(icon, size: 20, color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: showWarning ? Colors.red : Colors.red.shade200,
                  ),
                ),
                fillColor: Colors.red.shade50,
                filled: true,
              ),
            ),
          ),
        ),
        if (showWarning)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.red, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    warningText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}