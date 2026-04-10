
// import 'package:flutter/material.dart';
// import 'quiz/sim4_quiz_screen.dart'; // <-- your existing quiz file

// class InsuranceFormSimulation extends StatefulWidget {
//   const InsuranceFormSimulation({super.key});

//   @override
//   State<InsuranceFormSimulation> createState() => _InsuranceFormSimulationState();
// }

// class _InsuranceFormSimulationState extends State<InsuranceFormSimulation> {
//   int mode = 0; // 0 = selection, 1 = claim, 2 = policy
//   bool otpWarned = false;
//   bool aadhaarWarned = false;
//   bool paymentWarned = false;
//   bool uploadWarned = false;

//   final _formKey = GlobalKey<FormState>();

//   // form controllers
//   final nameCtrl = TextEditingController();
//   final hospitalCtrl = TextEditingController();
//   final billCtrl = TextEditingController();
//   final bankCtrl = TextEditingController();

//   // ───────────────────────── UI COLORS ─────────────────────────
//   final primary = const Color(0xFF1565C0);
//   final danger = const Color(0xFFC62828);
//   final warn = const Color(0xFFF57F17);
//   final safe = const Color(0xFF2E7D32);

//   Widget _sectionTitle(String text) {
//   return Container(
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
//     decoration: BoxDecoration(
//       color: const Color(0xFFE3F2FD),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: const Color(0xFF1565C0)),
//     ),
//     child: Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w800,
//         color: Color(0xFF0D1B2A),
//       ),
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("🧓 Safe Insurance Simulator"),
//         backgroundColor: primary,
//       ),
//       body: mode == 0 ? _buildModeSelect() : _buildForm(),
//     );
//   }

//   // ───────────────────────── MODE SELECT ─────────────────────────
//   Widget _buildModeSelect() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           const SizedBox(height: 30),
//           const Text(
//             "Choose Simulation Mode",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 40),

//           _modeCard(
//             title: "🏥 Claim Insurance Form",
//             desc: "Hospital bill reimbursement simulation (fraud heavy)",
//             color: primary,
//             onTap: () => setState(() => mode = 1),
//           ),

//           const SizedBox(height: 20),

//           _modeCard(
//             title: "📄 Policy Purchase Form",
//             desc: "Buying insurance + payment scam simulation",
//             color: warn,
//             onTap: () => setState(() => mode = 2),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _modeCard({
//     required String title,
//     required String desc,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: color),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.bold, color: color)),
//             const SizedBox(height: 8),
//             Text(desc),
//           ],
//         ),
//       ),
//     );
//   }

//   // ───────────────────────── FORM UI ─────────────────────────
//   Widget _buildForm() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             _sectionTitle("🧾 Insurance Form (Simulation)"),

//             const SizedBox(height: 20),

//             _inputField(
//               label: "Patient Name",
//               controller: nameCtrl,
//               icon: Icons.person,
//             ),

//             _inputField(
//               label: "Hospital Name",
//               controller: hospitalCtrl,
//               icon: Icons.local_hospital,
//             ),

//             _inputField(
//               label: "Bill Amount",
//               controller: billCtrl,
//               icon: Icons.currency_rupee,
//               keyboard: TextInputType.number,
//             ),

//             // ───────── FRAUD POINT 1 ─────────
//             _dangerField(
//               label: "OTP Verification (DON'T ENTER)",
//               icon: Icons.lock,
//               warned: otpWarned,
//               onTap: () => _showWarning(
//                 title: "⚠️ OTP Scam Alert",
//                 msg:
//                     "Insurance companies NEVER ask OTP for claims.\n\n"
//                     "If you share OTP → your bank account can be hacked.",
//               ),
//             ),

//             // ───────── FRAUD POINT 2 ─────────
//             _dangerField(
//               label: "Aadhaar Number",
//               icon: Icons.badge,
//               warned: aadhaarWarned,
//               onTap: () => _showWarning(
//                 title: "🛑 Aadhaar Risk",
//                 msg:
//                     "Aadhaar is sensitive.\nFraudsters can misuse it for loans and fake accounts.",
//               ),
//             ),

//             // ───────── FRAUD POINT 3 ─────────
//             _dangerField(
//               label: "Upload Documents (WhatsApp/Link)",
//               icon: Icons.upload,
//               warned: uploadWarned,
//               onTap: () => _showWarning(
//                 title: "❌ Document Scam",
//                 msg:
//                     "Never upload documents to WhatsApp or unknown links.\n\nUse only official insurance portals.",
//               ),
//             ),

//             // ───────── FRAUD POINT 4 ─────────
//             _dangerField(
//               label: "Pay Processing Fee (₹499)",
//               icon: Icons.payment,
//               warned: paymentWarned,
//               onTap: () => _showWarning(
//                 title: "💰 Fee Scam Alert",
//                 msg:
//                     "Insurance companies NEVER ask money to release claims.\n\nIf someone asks fee → it is fraud.",
//               ),
//             ),

//             const SizedBox(height: 25),

//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: safe,
//                 minimumSize: const Size(double.infinity, 55),
//               ),
//               onPressed: _finishSimulation,
//               child: const Text(
//                 "Finish Simulation → Start Quiz",
//                 style: TextStyle(fontSize: 16),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // ───────────────────────── INPUT FIELD ─────────────────────────
//   Widget _inputField({
//     required String label,
//     required TextEditingController controller,
//     required IconData icon,
//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboard,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }

//   // ───────────────────────── DANGER FIELD ─────────────────────────
//   Widget _dangerField({
//     required String label,
//     required IconData icon,
//     required bool warned,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: warned ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: warned ? safe : danger),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: warned ? safe : danger),
//             const SizedBox(width: 12),
//             Expanded(child: Text(label)),
//             Icon(Icons.info_outline, color: warned ? safe : danger),
//           ],
//         ),
//       ),
//     );
//   }

//   // ───────────────────────── WARNING POPUP ─────────────────────────
//   void _showWarning({required String title, required String msg}) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(title),
//         content: Text(msg),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           )
//         ],
//       ),
//     );
//   }

//   // ───────────────────────── FINISH ─────────────────────────
//   void _finishSimulation() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => Sim4QuizScreen()),
//     );
//   }
// }

//---------------------------------------------------------------------------------SECOND CODE-----------------------------------------------

// import 'package:flutter/material.dart';
// import 'quiz/sim4_quiz_screen.dart';

// class InsuranceFormSimulation extends StatefulWidget {
//   const InsuranceFormSimulation({super.key});

//   @override
//   State<InsuranceFormSimulation> createState() =>
//       _InsuranceFormSimulationState();
// }

// class _InsuranceFormSimulationState extends State<InsuranceFormSimulation> {
//   int mode = 1;

//   bool otpWarned = false;
//   bool aadhaarWarned = false;
//   bool paymentWarned = false;
//   bool uploadWarned = false;

//   final _formKey = GlobalKey<FormState>();

//   final nameCtrl = TextEditingController();
//   final hospitalCtrl = TextEditingController();
//   final billCtrl = TextEditingController();
//   final aadhaarCtrl = TextEditingController();
//   final otpCtrl = TextEditingController();
//   final uploadCtrl = TextEditingController();
//   final paymentCtrl = TextEditingController();

//   final primary = const Color(0xFF1565C0);
//   final danger = const Color(0xFFC62828);
//   final warn = const Color(0xFFF57F17);
//   final safe = const Color(0xFF2E7D32);

//   // ───────────────── WARNING POPUP ─────────────────
//   void _warnOnce(String title, String msg, VoidCallback markWarned) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(title),
//         content: Text(msg),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           )
//         ],
//       ),
//     );

//     markWarned();
//   }

//   Widget _sectionTitle(String text) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE3F2FD),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFF1565C0)),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("🧓 Safe Insurance Simulator"),
//         backgroundColor: primary,
//       ),
//       body: _buildForm(),
//     );
//   }

//   Widget _buildForm() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             _sectionTitle("🧾 Insurance Form (Simulation)"),
//             const SizedBox(height: 20),

//             _inputField("Patient Name", nameCtrl, Icons.person),
//             _inputField("Hospital Name", hospitalCtrl, Icons.local_hospital),
//             _inputField("Bill Amount", billCtrl, Icons.currency_rupee,
//                 keyboard: TextInputType.number),

//             const SizedBox(height: 20),

//             _inputField("OTP (Enter freely)", otpCtrl, Icons.lock,
//                 keyboard: TextInputType.number),
//             _warnArea(
//               warned: otpWarned,
//               title: "⚠️ OTP Scam Alert",
//               msg: "Never share OTP. Banks never ask OTP for claims.",
//               mark: () => setState(() => otpWarned = true),
//             ),

//             _inputField("Aadhaar Number", aadhaarCtrl, Icons.badge,
//                 keyboard: TextInputType.number),
//             _warnArea(
//               warned: aadhaarWarned,
//               title: "🛑 Aadhaar Risk",
//               msg: "Aadhaar can be misused for fraud loans & fake accounts.",
//               mark: () => setState(() => aadhaarWarned = true),
//             ),

//             _inputField("Upload Documents Link", uploadCtrl, Icons.upload),
//             _warnArea(
//               warned: uploadWarned,
//               title: "❌ Document Scam",
//               msg: "Never upload documents on WhatsApp or unknown links.",
//               mark: () => setState(() => uploadWarned = true),
//             ),

//             _inputField("Processing Fee ₹499", paymentCtrl, Icons.payment,
//                 keyboard: TextInputType.number),
//             _warnArea(
//               warned: paymentWarned,
//               title: "💰 Fee Scam Alert",
//               msg: "Insurance NEVER asks money for claim processing.",
//               mark: () => setState(() => paymentWarned = true),
//             ),

//             const SizedBox(height: 25),

//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: safe,
//                 minimumSize: const Size(double.infinity, 55),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const Sim4QuizScreen(),
//                   ),
//                 );
//               },
//               child: const Text("Finish → Start Quiz"),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _inputField(
//     String label,
//     TextEditingController controller,
//     IconData icon, {
//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboard,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _warnArea({
//     required bool warned,
//     required String title,
//     required String msg,
//     required VoidCallback mark,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         if (!warned) {
//           _warnOnce(title, msg, mark);
//         }
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: warned
//               ? Colors.green.withOpacity(0.1)
//               : Colors.red.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: warned ? safe : danger,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(Icons.info_outline, color: warned ? safe : danger),
//             const SizedBox(width: 10),
//             const Expanded(
//               child: Text("Tap for safety warning"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'quiz/sim4_quiz_screen.dart';

class InsuranceFormSimulation extends StatefulWidget {
  const InsuranceFormSimulation({super.key});

  @override
  State<InsuranceFormSimulation> createState() =>
      _InsuranceFormSimulationState();
}

class _InsuranceFormSimulationState extends State<InsuranceFormSimulation> {
  final primary = const Color(0xFF1565C0);
  final safe = const Color(0xFF2E7D32);

  // controllers
  final nameCtrl = TextEditingController();
  final hospitalCtrl = TextEditingController();
  final billCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final aadhaarCtrl = TextEditingController();
  final uploadCtrl = TextEditingController();
  final paymentCtrl = TextEditingController();

  // lock flags
  bool otpLocked = false;
  bool aadhaarLocked = false;
  bool uploadLocked = false;
  bool paymentLocked = false;

  void _showPopup(String title, String msg, VoidCallback lockField) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              lockField(); // lock AFTER popup
              setState(() {});
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🧓 Safe Insurance Simulator"),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            _field("Patient Name", nameCtrl),
            _field("Hospital Name", hospitalCtrl),
            _field("Bill Amount", billCtrl, number: true),

            // ───── OTP ─────
            _field(
              "OTP",
              otpCtrl,
              number: true,
              locked: otpLocked,
              onTap: () {
                if (!otpLocked) {
                  _showPopup(
                    "⚠️ OTP Scam Alert",
                    "Never share OTP with anyone. Banks never ask OTP.",
                    () => otpLocked = true,
                  );
                }
              },
            ),

            // ───── AADHAAR ─────
            _field(
              "Aadhaar Number",
              aadhaarCtrl,
              number: true,
              locked: aadhaarLocked,
              onTap: () {
                if (!aadhaarLocked) {
                  _showPopup(
                    "🛑 Aadhaar Risk",
                    "Aadhaar can be misused for fraud. Be careful.",
                    () => aadhaarLocked = true,
                  );
                }
              },
            ),

            // ───── UPLOAD ─────
            _field(
              "Upload Documents",
              uploadCtrl,
              locked: uploadLocked,
              onTap: () {
                if (!uploadLocked) {
                  _showPopup(
                    "❌ Document Scam",
                    "Never upload documents on unknown links or WhatsApp.",
                    () => uploadLocked = true,
                  );
                }
              },
            ),

            // ───── PAYMENT ─────
            _field(
              "Processing Fee ₹499",
              paymentCtrl,
              number: true,
              locked: paymentLocked,
              onTap: () {
                if (!paymentLocked) {
                  _showPopup(
                    "💰 Fee Scam Alert",
                    "Insurance never asks money for claims.",
                    () => paymentLocked = true,
                  );
                }
              },
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: safe,
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Sim4QuizScreen(),
                  ),
                );
              },
              child: const Text("Finish → Start Quiz"),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool number = false,
    bool locked = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType:
            number ? TextInputType.number : TextInputType.text,
        readOnly: locked, // ✅ THIS BLOCKS AFTER POPUP
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.edit),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}