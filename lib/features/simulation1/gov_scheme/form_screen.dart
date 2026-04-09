
/*import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController bankController = TextEditingController();

  void showWarning(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("⚠ Warning"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Understood"),
          )
        ],
      ),
    );
  }

  void submitForm() {
    if (nameController.text.isEmpty ||
        aadhaarController.text.isEmpty ||
        bankController.text.isEmpty) {
      showWarning("Please fill all details.");
      // Navigate to fake call even if fields are empty for simulation
      Navigator.pushNamed(context, '/sim1-call');
      return;
    }

    // Confirmation dialog before submitting real data
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure?"),
        content: const Text(
          "You are entering sensitive information.\n\n"
          "Make sure you are on a trusted government website.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to fake call screen first
              Navigator.pushNamed(context, '/sim1-call');
            },
            child: const Text("Continue"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apply for Scheme")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔷 Title
            const Text(
              "Fill Details for Scheme Application",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 🔷 Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // 🔷 Aadhaar
            TextField(
              controller: aadhaarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Aadhaar Number",
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showWarning("Never share Aadhaar on unknown websites.");
              },
            ),
            const SizedBox(height: 15),

            // 🔷 Bank
            TextField(
              controller: bankController,
              decoration: const InputDecoration(
                labelText: "Bank Account Number",
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showWarning(
                  "Bank details should only be entered on official websites.",
                );
              },
            ),
            const SizedBox(height: 30),

            // 🔷 Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitForm,
                child: const Text("Submit Application"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  String? selectedState;
  String? selectedDistrict;
  String? selectedScheme;
  bool declarationAccepted = false;
  bool _submitting = false;

  final List<String> stateList = [
    'Maharashtra', 'Uttar Pradesh', 'Bihar', 'Rajasthan',
    'Madhya Pradesh', 'Gujarat', 'Karnataka', 'Tamil Nadu'
  ];

  final List<String> schemeList = [
    'PM Kisan Samman Nidhi',
    'PM Fasal Bima Yojana',
    'Kisan Credit Card',
    'Soil Health Card Scheme',
  ];

  void _showWarning(String title, String message, {IconData icon = Icons.warning_amber_rounded}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 18))),
          ],
        ),
        content: Text(message, style: const TextStyle(fontSize: 16, height: 1.6)),
        actions: [
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text("I Understand", style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠ Please fill all required fields correctly."),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!declarationAccepted) {
      _showWarning(
        "Declaration Required",
        "Please read and accept the declaration at the bottom before submitting.",
        icon: Icons.info_outline,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.help_outline, color: Colors.blue, size: 28),
            SizedBox(width: 10),
            Text("Confirm Submission", style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You are about to submit your application.\n",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Text(
                "⚠ IMPORTANT: Real government websites NEVER ask for:\n"
                "• OTP over phone\n"
                "• Payment to process application\n"
                "• Password of any account\n\n"
                "This is a SIMULATION to help you learn.",
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(fontSize: 16)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-call');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Submit Application", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Divider(color: Colors.blue.shade200, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    String? warningMessage,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        style: const TextStyle(fontSize: 17),
        onTap: warningMessage != null
            ? () => _showWarning("⚠ Caution", warningMessage)
            : null,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(fontSize: 15),
          prefixIcon: Icon(icon, size: 22),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Government of India", style: TextStyle(fontSize: 12, color: Colors.white70)),
            Text("Scheme Application Form", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Emblem_of_India.svg/800px-Emblem_of_India.svg.png',
              height: 36,
              errorBuilder: (_, __, ___) => const Icon(Icons.account_balance, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Application Header Banner ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.blue.shade600],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "APPLICATION FOR GOVERNMENT SCHEME BENEFIT",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Form No: GOI/AGRI/2024 | This is a SIMULATION for learning purposes only",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),

              // ── SCAM ALERT BOX ──
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.shade200, width: 1.5),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.gpp_bad, color: Colors.red, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "SCAM ALERT: No government officer will call you after this form asking for OTP or money. If someone calls, IT IS A SCAM.",
                        style: TextStyle(fontSize: 13, color: Colors.red, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),

              // ── SECTION 1: Scheme Selection ──
              _sectionHeader("Part A: Scheme Details", Icons.assignment),

              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: DropdownButtonFormField<String>(
                  value: selectedScheme,
                  decoration: InputDecoration(
                    labelText: "Select Scheme *",
                    labelStyle: const TextStyle(fontSize: 15),
                    prefixIcon: const Icon(Icons.list_alt, size: 22),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  items: schemeList.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) => setState(() => selectedScheme = val),
                  validator: (val) => val == null ? "Please select a scheme" : null,
                ),
              ),

              // ── SECTION 2: Personal Details ──
              _sectionHeader("Part B: Personal Details", Icons.person),

              _buildField(
                controller: nameController,
                label: "Full Name (As per Aadhaar) *",
                icon: Icons.person_outline,
                hint: "e.g. Ramesh Kumar Sharma",
                validator: (v) => v == null || v.trim().length < 3 ? "Enter your full name" : null,
              ),

              _buildField(
                controller: fatherNameController,
                label: "Father's / Husband's Name *",
                icon: Icons.family_restroom,
                hint: "e.g. Suresh Kumar Sharma",
                validator: (v) => v == null || v.trim().length < 3 ? "Enter father/husband name" : null,
              ),

              _buildField(
                controller: mobileController,
                label: "Mobile Number (Linked to Aadhaar) *",
                icon: Icons.phone_android,
                hint: "10-digit mobile number",
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                validator: (v) => v == null || v.length != 10 ? "Enter valid 10-digit mobile number" : null,
              ),

              // ── SECTION 3: Aadhaar ──
              _sectionHeader("Part C: Identity Proof", Icons.badge),

              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "LESSON: Enter Aadhaar ONLY on official .gov.in websites. This form is a simulation.",
                        style: TextStyle(fontSize: 13, color: Colors.orange, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),

              _buildField(
                controller: aadhaarController,
                label: "Aadhaar Number *",
                icon: Icons.credit_card,
                hint: "12-digit Aadhaar number",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 12,
                warningMessage: "REAL Aadhaar should only be entered on official government websites ending in .gov.in\n\nExample: https://pmkisan.gov.in\n\nNEVER share Aadhaar on unknown sites or WhatsApp.",
                validator: (v) => v == null || v.length != 12 ? "Aadhaar must be 12 digits" : null,
              ),

              // ── SECTION 4: Bank Details ──
              _sectionHeader("Part D: Bank Account Details", Icons.account_balance),

              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "LESSON: Bank details are needed for direct benefit transfer (DBT). Never share your bank PASSSWORD or OTP — only account number is needed here.",
                        style: TextStyle(fontSize: 13, color: Colors.orange, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),

              _buildField(
                controller: bankController,
                label: "Bank Account Number *",
                icon: Icons.account_balance_wallet,
                hint: "e.g. 12345678901234",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                warningMessage: "Bank account number is used to send money directly to you (DBT).\n\nSafe to enter here.\nBUT: Never share your ATM PIN, internet banking password, or OTP.",
                validator: (v) => v == null || v.trim().length < 9 ? "Enter valid account number" : null,
              ),

              _buildField(
                controller: ifscController,
                label: "IFSC Code *",
                icon: Icons.code,
                hint: "e.g. SBIN0001234",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter IFSC code";
                  if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(v.toUpperCase())) {
                    return "Invalid IFSC. Example: SBIN0001234";
                  }
                  return null;
                },
              ),

              // ── SECTION 5: Address ──
              _sectionHeader("Part E: Address Details", Icons.location_on),

              _buildField(
                controller: villageController,
                label: "Village / Town / City *",
                icon: Icons.home,
                hint: "Your village or town name",
                validator: (v) => v == null || v.trim().isEmpty ? "Enter village/town name" : null,
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: DropdownButtonFormField<String>(
                  value: selectedState,
                  decoration: InputDecoration(
                    labelText: "State *",
                    labelStyle: const TextStyle(fontSize: 15),
                    prefixIcon: const Icon(Icons.map, size: 22),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  items: stateList.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) => setState(() => selectedState = val),
                  validator: (val) => val == null ? "Please select your state" : null,
                ),
              ),

              // ── SECTION 6: Declaration ──
              _sectionHeader("Declaration", Icons.verified_user),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: const Text(
                  "I hereby declare that the information provided in this form is true and correct to the best of my knowledge. "
                  "I understand that providing false information may lead to cancellation of benefits and legal action under relevant laws.",
                  style: TextStyle(fontSize: 14, height: 1.7),
                ),
              ),

              const SizedBox(height: 12),

              CheckboxListTile(
                value: declarationAccepted,
                onChanged: (val) => setState(() => declarationAccepted = val ?? false),
                title: const Text(
                  "I have read and accept the above declaration.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),

              const SizedBox(height: 24),

              // ── Submit Button ──
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _submitting ? null : _submitForm,
                  icon: _submitting
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.send, size: 22),
                  label: Text(
                    _submitting ? "Submitting..." : "Submit Application",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Footer ──
              const Center(
                child: Text(
                  "For help, call Kisan Helpline: 1800-180-1551 (Free)\nThis is a simulation. Not a real government website.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.6),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}