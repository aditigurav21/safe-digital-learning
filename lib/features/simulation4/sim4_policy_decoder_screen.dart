import 'package:flutter/material.dart';

class Sim4PolicyDecoderScreen extends StatefulWidget {
  const Sim4PolicyDecoderScreen({super.key});

  @override
  State<Sim4PolicyDecoderScreen> createState() =>
      _Sim4PolicyDecoderScreenState();
}

class _Sim4PolicyDecoderScreenState
    extends State<Sim4PolicyDecoderScreen> {
  final Set<String> _tapped = {};

//   final List<_PolicySection> _sections = [
//     _PolicySection(
//       id: 'coverage',
//       icon: Icons.shield_outlined,
//       color: Colors.teal,
//       title: 'Coverage Amount',
//       legalText: 'Sum Insured: ₹5,00,000 per annum on floater basis',
//       plainText:
//           'Your insurance will pay UP TO ₹5 lakh per year for your family together.\n\n'
//           '⚠️ This is the MAXIMUM — not everything is covered. Read exclusions carefully.',
//       example:
//           '📌 Example: If your hospital bill is ₹3 lakh, insurance pays ₹3 lakh. If the bill is ₹6 lakh, insurance pays only ₹5 lakh — YOU pay the remaining ₹1 lakh.',
//     ),
//     _PolicySection(
//       id: 'waiting',
//       icon: Icons.hourglass_empty_outlined,
//       color: Colors.orange,
//       title: 'Waiting Period',
//       legalText:
//           'Pre-existing disease waiting period: 36 months. Specific illness waiting period: 24 months.',
//       plainText:
//           'If you already had a health problem BEFORE buying insurance, the insurance will NOT pay for it for the first 3 years.\n\n'
//           '⚠️ Many elderly people buy insurance during illness and are shocked when claims are rejected.',
//       example:
//           '📌 Example: You have diabetes and you buy insurance today. Any diabetes-related hospital visit for the next 3 years will NOT be covered by insurance.',
//     ),
//     _PolicySection(
//       id: 'copayment',
//       icon: Icons.account_balance_wallet_outlined,
//       color: Colors.purple,
//       title: 'Co-payment',
//       legalText:
//           'Co-payment clause: Insured shall bear 20% of each and every admissible claim.',
//       plainText:
//           'Even when insurance pays, YOU must also pay 20% of every bill from your own pocket.\n\n'
//           '⚠️ Many people don\'t realise this. They expect 100% payment but get only 80%.',
//       example:
//           '📌 Example: Hospital bill = ₹1,00,000. Insurance pays ₹80,000. You pay ₹20,000 yourself. Always keep some savings for co-payment.',
//     ),
//     _PolicySection(
//       id: 'exclusions',
//       icon: Icons.block_outlined,
//       color: Colors.red,
//       title: 'Exclusions (What is NOT Covered)',
//       legalText:
//           'Exclusions: Cosmetic surgery, dental treatment, spectacles, OPD consultations, self-inflicted injuries, experimental treatments.',
//       plainText:
//           'These are things insurance will NEVER pay for, no matter what:\n\n'
//           '• Doctor visits for routine check-ups (OPD)\n'
//           '• Eye glasses or dental treatment\n'
//           '• Any surgery just for looks\n\n'
//           '⚠️ OPD (outpatient) is where most elderly people spend money. Insurance usually does NOT cover this.',
//       example:
//           '📌 Example: You visit a doctor every month for ₹500. Annual cost = ₹6,000. Insurance covers NONE of this. You pay everything.',
//     ),
//     _PolicySection(
//       id: 'claim',
//       icon: Icons.assignment_outlined,
//       color: Colors.blue,
//       title: 'Claim Process',
//       legalText:
//           'Cashless facility available at network hospitals only. For reimbursement, submit original bills within 30 days of discharge.',
//       plainText:
//           'There are 2 ways to use your insurance:\n\n'
//           '1️⃣ CASHLESS: Go to a hospital in the insurance company\'s list. They pay the hospital directly. You pay nothing upfront.\n\n'
//           '2️⃣ REIMBURSEMENT: Go to ANY hospital. Pay the bill yourself. Then submit all original bills to the insurance company within 30 days to get your money back.',
//       example:
//           '📌 Tip: Always check if your nearest hospital is in the "network" list. Going to a non-network hospital means you pay first and wait for refund.',
//     ),
//     _PolicySection(
//       id: 'rejection',
//       icon: Icons.warning_amber_outlined,
//       color: Colors.deepOrange,
//       title: 'Claim Rejection Conditions',
//       legalText:
//           'Claim shall be rejected if: (a) non-disclosure of pre-existing conditions at policy inception, (b) claims within waiting period, (c) treatment not medically necessary per treating physician\'s certification.',
//       plainText:
//           'Insurance CAN REJECT your claim if:\n\n'
//           '• You did NOT mention your existing diseases when buying the policy\n'
//           '• You claim during the waiting period\n'
//           '• The doctor\'s certificate is missing or incomplete\n\n'
//           '⚠️ ALWAYS be honest about your health when buying insurance. Hiding diseases leads to rejection later.',
//       example:
//           '📌 Very common mistake: People hide diabetes or BP to get cheaper premium. When they claim, the company finds out and rejects the claim. Always be honest — it protects you.',
//     ),
//   ];

final List<_PolicySection> _sections = [
  _PolicySection(
    id: 'fake_links',
    icon: Icons.link_off,
    color: Colors.red,
    title: 'Fake Links in Messages',
    legalText: 'Messages asking you to click unknown links.',
    plainText:
        '🚨 SCAM SIGNAL:\nYou receive SMS/WhatsApp like:\n“Your account will be blocked. Click here.”\n\n'
        '⚠️ WHY IT’S DANGEROUS:\nThese links steal your personal data or install malware.\n\n'
        '✅ WHAT YOU SHOULD DO:\n• NEVER click unknown links\n• Verify by calling official number\n• Delete message immediately',
    example:
        '📌 Example: “KYC update required urgently → click link” = ALWAYS FAKE',
  ),

  _PolicySection(
    id: 'otp_scam',
    icon: Icons.lock_outline,
    color: Colors.orange,
    title: 'OTP / PIN Asking Calls',
    legalText: 'Anyone asking OTP or PIN on call.',
    plainText:
        '🚨 SCAM SIGNAL:\nCaller says: “Give OTP to verify account”\n\n'
        '⚠️ WHY IT’S DANGEROUS:\nOTP gives full access to your bank/account.\n\n'
        '✅ WHAT YOU SHOULD DO:\n• NEVER share OTP\n• Banks never ask OTP on call\n• Hang up immediately',
    example:
        '📌 Even police or bank NEVER ask OTP. It is always a scam.',
  ),

  _PolicySection(
    id: 'fake_doctor',
    icon: Icons.local_hospital,
    color: Colors.purple,
    title: 'Fake Medical Advice / Reports',
    legalText: 'Unexpected health warnings or reports.',
    plainText:
        '🚨 SCAM SIGNAL:\nMessage says: “Your medical report is positive. Click link.”\n\n'
        '⚠️ WHY IT’S DANGEROUS:\nScammers use fear to trick you into clicking links.\n\n'
        '✅ WHAT YOU SHOULD DO:\n• Contact real hospital directly\n• Do NOT click links\n• Ask family before acting',
    example:
        '📌 Hospitals NEVER send diagnosis via WhatsApp links.',
  ),

  _PolicySection(
    id: 'emergency_money',
    icon: Icons.person_off,
    color: Colors.deepOrange,
    title: 'Emergency Fake Family Messages',
    legalText: 'Messages pretending to be relatives in trouble.',
    plainText:
        '🚨 SCAM SIGNAL:\n“Hi Mom, I lost my phone, send money urgently.”\n\n'
        '⚠️ WHY IT’S DANGEROUS:\nScammer impersonates your family.\n\n'
        '✅ WHAT YOU SHOULD DO:\n• Call the person directly\n• Ask personal question only family knows\n• Never send immediately',
    example:
        '📌 Always VERIFY before reacting emotionally.',
  ),

  _PolicySection(
    id: 'qr_scam',
    icon: Icons.qr_code_scanner,
    color: Colors.teal,
    title: 'QR Code Payment Scams',
    legalText: 'Unknown QR codes in public places.',
    plainText:
        '🚨 SCAM SIGNAL:\nSomeone asks you to scan QR to “receive money”.\n\n'
        '⚠️ WHY IT’S DANGEROUS:\nQR codes are used to trick you into sending money instead.\n\n'
        '✅ WHAT YOU SHOULD DO:\n• Only scan trusted shop QR\n• Never scan random posters\n• Confirm before payment',
    example:
        '📌 QR code = PAY money, NOT RECEIVE money.',
  ),
];

//till here changed
  @override
  Widget build(BuildContext context) {
    final allTapped = _tapped.length == _sections.length;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade600,
        automaticallyImplyLeading: false,
        title: const Text('Policy Document Decoder',
            style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Instruction banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.touch_app, color: Colors.teal),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tap each section to understand what the legal language really means for you.',
                    style: TextStyle(
                        fontSize: 14, color: Colors.teal.shade800),
                  ),
                ),
              ],
            ),
          ),

          // Progress chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${_tapped.length}/${_sections.length} sections read',
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey.shade600),
                ),
                const Spacer(),
                if (allTapped)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('✅ All read!',
                        style: TextStyle(
                            fontSize: 12, color: Colors.green)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _sections.length,
              itemBuilder: (_, i) =>
                  _buildSectionCard(_sections[i]),
            ),
          ),

          // Continue button
          if (allTapped)
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/sim4-claim'),
                  child: const Text('Continue to Claim Simulation →',
                      style: TextStyle(
                          fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(_PolicySection section) {
    final isRead = _tapped.contains(section.id);

    return GestureDetector(
      onTap: () {
        _showDecoder(section);
        setState(() => _tapped.add(section.id));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRead
                ? section.color.withValues(alpha: 0.5)
                : Colors.grey.shade200,
            width: isRead ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: section.color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(section.icon, color: section.color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isRead ? section.color : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    section.legalText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isRead ? Icons.check_circle : Icons.touch_app,
              color: isRead ? Colors.green : Colors.grey.shade400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  void _showDecoder(_PolicySection section) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(24),
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: section.color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(section.icon,
                        color: section.color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(section.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: section.color)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Legal text box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('📄 What your policy says:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.grey)),
                    const SizedBox(height: 6),
                    Text(
                      section.legalText,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          fontStyle: FontStyle.italic,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Plain language
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: section.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: section.color.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('💬 What this means for you:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: section.color)),
                    const SizedBox(height: 8),
                    Text(section.plainText,
                        style: const TextStyle(
                            fontSize: 15, height: 1.6)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Example
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Text(
                  section.example,
                  style:
                      const TextStyle(fontSize: 14, height: 1.6),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: section.color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it! ✓',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PolicySection {
  final String id;
  final IconData icon;
  final Color color;
  final String title;
  final String legalText;
  final String plainText;
  final String example;

  const _PolicySection({
    required this.id,
    required this.icon,
    required this.color,
    required this.title,
    required this.legalText,
    required this.plainText,
    required this.example,
  });
}