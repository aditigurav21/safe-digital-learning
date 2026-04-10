import 'package:flutter/material.dart';

class Sim4ScamDetectorScreen extends StatefulWidget {
  const Sim4ScamDetectorScreen({super.key});

  @override
  State<Sim4ScamDetectorScreen> createState() =>
      _Sim4ScamDetectorScreenState();
}

class _Sim4ScamDetectorScreenState
    extends State<Sim4ScamDetectorScreen> {
  int _current = 0;
  bool _answered = false;
  bool? _wasCorrect;

  final List<_ScamScenario> _scenarios = [
    _ScamScenario(
      type: ScenarioType.sms,
      sender: 'PM-HEALTHGOV',
      message:
          '🎉 Congratulations! You are selected for FREE Senior Citizen Health Cover ₹5 Lakh. '
          'Just share your Aadhaar OTP to activate. Valid for 24 hours only! Reply OTP now.',
      isScam: true,
      redFlags: [
        '🚩 Government schemes NEVER ask for OTP via SMS',
        '🚩 "24 hours only" creates fake urgency to stop you from thinking',
        '🚩 Aadhaar OTP gives access to your identity — never share it',
        '🚩 Legitimate schemes are enrolled at offices or official portals, not via SMS',
      ],
      safeAction:
          'DELETE this message. Block the number. Visit your nearest government health office to check real schemes.',
    ),
    _ScamScenario(
      type: ScenarioType.call,
      sender: 'Caller: +91-98XXXXXXXX',
      message:
          '"Namaste ji, I am calling from LIC Health Department. Your policy is about to expire. '
          'Pay ₹999 NOW to activate lifetime senior cover. I will stay on call while you pay via UPI."',
      isScam: true,
      redFlags: [
        '🚩 Real insurers send written renewal notices, not urgent phone calls',
        '🚩 "Stay on call while you pay" is a classic pressure tactic',
        '🚩 ₹999 for "lifetime cover" is impossibly cheap — a red flag',
        '🚩 Legitimate agents give you policy documents BEFORE payment',
      ],
      safeAction:
          'HANG UP. Call LIC\'s official number (1800-209-7070) directly to verify. Never pay while someone is on the phone.',
    ),
    _ScamScenario(
      type: ScenarioType.whatsapp,
      sender: 'WhatsApp: "Govt Health Officer"',
      message:
          '📋 Dear Senior Citizen,\nGovernment is offering FREE Ayushman Bharat upgrade. '
          'Send photo of your Aadhaar card + bank passbook to this number within 2 hours to avail benefit.',
      isScam: true,
      redFlags: [
        '🚩 Government does NOT collect documents via WhatsApp',
        '🚩 Sending Aadhaar + bank passbook enables identity theft & fraud',
        '🚩 Real Ayushman Bharat enrollment happens at empanelled hospitals or CSCs',
        '🚩 "2 hours" deadline is a pressure tactic',
      ],
      safeAction:
          'DO NOT send any documents. Call Ayushman Bharat helpline: 14555 to verify your eligibility.',
    ),
    _ScamScenario(
      type: ScenarioType.call,
      sender: 'Caller: Star Health Insurance',
      message:
          '"Hello, this is Star Health Insurance. Your claim #SH-2024-8821 has been processed. '
          'Please visit our website or call 1800-425-2255 to check your claim status. '
          'No further action needed from your side."',
      isScam: false,
      redFlags: [],
      safeAction:
          '✅ This is a LEGITIMATE call. The agent gave you a claim number, official website, and toll-free number — and asked for NOTHING from you. Always call back on the official number to confirm.',
    ),
  ];

  void _onDecision(bool userSaysScam) {
    if (_answered) return;
    final correct = userSaysScam == _scenarios[_current].isScam;
    setState(() {
      _answered = true;
      _wasCorrect = correct;
    });
  }

  void _next() {
    if (_current < _scenarios.length - 1) {
      setState(() {
        _current++;
        _answered = false;
        _wasCorrect = null;
      });
    } else {
      Navigator.pushNamed(context, '/sim4-policy-decoder');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _scenarios[_current];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade600,
        automaticallyImplyLeading: false,
        title: Text(
          'Scam Detector: ${_current + 1}/${_scenarios.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            LinearProgressIndicator(
              value: (_current + 1) / _scenarios.length,
              backgroundColor: Colors.grey.shade300,
              color: Colors.teal.shade600,
              minHeight: 6,
            ),
            const SizedBox(height: 16),
            // Instruction
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.touch_app, color: Colors.teal),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Read the message below. Is it LEGIT or a SCAM?',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Message card (simulates SMS/Call/WhatsApp)
            _buildMessageCard(s),
            const SizedBox(height: 20),

            // Decision buttons
            if (!_answered) ...[
              Row(
                children: [
                  Expanded(
                    child: _DecisionButton(
                      label: '✅ Looks Legit',
                      color: Colors.green.shade600,
                      onTap: () => _onDecision(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DecisionButton(
                      label: '🚨 It\'s a Scam!',
                      color: Colors.red.shade600,
                      onTap: () => _onDecision(true),
                    ),
                  ),
                ],
              ),
            ],

            // Result
            if (_answered) ...[
              _buildResult(s),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _next,
                  child: Text(
                    _current < _scenarios.length - 1
                        ? 'Next Scenario →'
                        : 'Continue to Policy Decoder →',
                    style: const TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMessageCard(_ScamScenario s) {
    final Color headerColor;
    final IconData headerIcon;
    final String headerLabel;

    switch (s.type) {
      case ScenarioType.sms:
        headerColor = Colors.blue.shade700;
        headerIcon = Icons.sms_outlined;
        headerLabel = 'SMS Message';
        break;
      case ScenarioType.call:
        headerColor = Colors.green.shade700;
        headerIcon = Icons.call_outlined;
        headerLabel = 'Phone Call';
        break;
      case ScenarioType.whatsapp:
        headerColor = const Color(0xFF25D366);
        headerIcon = Icons.chat_outlined;
        headerLabel = 'WhatsApp';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(headerIcon, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(headerLabel,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Sender
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              s.sender,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),
          // Message body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              s.message,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult(_ScamScenario s) {
    final bool correct = _wasCorrect ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Correct / Wrong banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: correct ? Colors.green.shade50 : Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: correct
                    ? Colors.green.shade300
                    : Colors.red.shade300),
          ),
          child: Row(
            children: [
              Icon(
                correct ? Icons.check_circle : Icons.cancel,
                color: correct ? Colors.green : Colors.red,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  correct
                      ? (s.isScam
                          ? 'Correct! 🎉 You spotted the scam!'
                          : 'Correct! ✅ This was indeed legitimate.')
                      : (s.isScam
                          ? '❌ This was a SCAM — be careful!'
                          : '❌ This was actually legitimate.'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: correct ? Colors.green.shade800 : Colors.red.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Red flags
        if (s.redFlags.isNotEmpty) ...[
          const Text('Red Flags in this message:',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          ...s.redFlags.map((flag) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(flag,
                      style: const TextStyle(fontSize: 14, height: 1.4)),
                ),
              )),
          const SizedBox(height: 8),
        ],

        // Safe action
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('✅ What to do:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.teal)),
              const SizedBox(height: 6),
              Text(s.safeAction,
                  style:
                      const TextStyle(fontSize: 14, height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}

enum ScenarioType { sms, call, whatsapp }

class _ScamScenario {
  final ScenarioType type;
  final String sender;
  final String message;
  final bool isScam;
  final List<String> redFlags;
  final String safeAction;

  const _ScamScenario({
    required this.type,
    required this.sender,
    required this.message,
    required this.isScam,
    required this.redFlags,
    required this.safeAction,
  });
}

class _DecisionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DecisionButton(
      {required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        ),
      ),
    );
  }
}