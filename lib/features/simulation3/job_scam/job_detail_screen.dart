import 'package:flutter/material.dart';
import 'package:safe_digital_learning/core/constants/colors.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  final List<int> _tappedFlags = [];

  final List<_RedFlag> _redFlags = [
    _RedFlag(
      id: 0,
      label: '🚨 Fake URL',
      detail:
          'The website is "unstop-jobs.site" — not the real unstop.com. Scammers create lookalike domains to trick you.',
    ),
    _RedFlag(
      id: 1,
      label: '🚨 Too-Good Salary',
      detail:
          '₹40,000/month for an intern with zero experience required? Legitimate companies match pay to skill level.',
    ),
    _RedFlag(
      id: 2,
      label: '🚨 Urgency Pressure',
      detail:
          '"Apply in 10 minutes" is a pressure tactic. Real jobs never expire in minutes. Scammers rush you so you don\'t think clearly.',
    ),
    _RedFlag(
      id: 3,
      label: '🚨 No Company Info',
      detail:
          'No LinkedIn, no website, no employee count. Legitimate companies are transparent and easy to verify.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Job Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: const BackButton(color: Colors.black87),
        // Fake URL bar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: GestureDetector(
            onTap: () {
              if (!_tappedFlags.contains(0)) {
                setState(() => _tappedFlags.add(0));
                _showFlagDialog(context, _redFlags[0]);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _tappedFlags.contains(0)
                    ? Colors.red.shade50
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _tappedFlags.contains(0)
                      ? Colors.red
                      : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _tappedFlags.contains(0) ? Icons.warning : Icons.http,
                    size: 14,
                    color:
                        _tappedFlags.contains(0) ? Colors.red : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'unstop-jobs.site/apply/techminds',
                    style: TextStyle(
                      fontSize: 12,
                      color: _tappedFlags.contains(0)
                          ? Colors.red
                          : Colors.grey.shade700,
                    ),
                  ),
                  const Spacer(),
                  if (!_tappedFlags.contains(0))
                    const Text(
                      'Tap to inspect 👆',
                      style: TextStyle(fontSize: 10, color: Colors.orange),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hint banner
            if (_tappedFlags.length < 3)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Text(
                  '💡 Tip: Tap on highlighted elements to inspect them for red flags. Found ${_tappedFlags.length}/3 so far.',
                  style: const TextStyle(fontSize: 13, color: Colors.brown),
                ),
              ),

            // Company header
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'T',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remote Software Intern',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'TechMinds Solutions Pvt Ltd',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Salary - tappable red flag
            _tappableRow(
              context: context,
              flagId: 1,
              child: Row(
                children: [
                  const Icon(Icons.currency_rupee, color: Colors.green, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '₹40,000/month  ',
                    style: TextStyle(
                      fontSize: 16,
                      color: _tappedFlags.contains(1)
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!_tappedFlags.contains(1))
                    const Text(
                      '⚠️',
                      style: TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Urgency timer - tappable
            _tappableRow(
              context: context,
              flagId: 2,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _tappedFlags.contains(2)
                      ? Colors.red.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _tappedFlags.contains(2)
                        ? Colors.red
                        : Colors.orange.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: _tappedFlags.contains(2) ? Colors.red : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '⚡ Hurry! Only 3 slots left. Apply within 10 minutes!',
                        style: TextStyle(
                          color: _tappedFlags.contains(2)
                              ? Colors.red
                              : Colors.orange.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Job Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'We are looking for a passionate Software Intern to join our growing team. No experience necessary! You will work on exciting projects from home.\n\n• Flexible hours\n• No interview required\n• Instant selection\n• ₹40,000/month stipend',
              style: TextStyle(color: Colors.black87, height: 1.6),
            ),

            const SizedBox(height: 16),

            // No company info - tappable
            _tappableRow(
              context: context,
              flagId: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.business, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About Company',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _tappedFlags.contains(3)
                                ? '⚠️ No website, no LinkedIn, no verifiable info!'
                                : 'TechMinds Solutions — a fast-growing startup. (No website listed)',
                            style: TextStyle(
                              fontSize: 13,
                              color: _tappedFlags.contains(3)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Flags found summary
            if (_tappedFlags.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🚩 Red Flags Found: ${_tappedFlags.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ..._tappedFlags.map(
                      (id) => Text(
                        _redFlags[id].label,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/sim3-reveal',
                            arguments: {'reported': true, 'flagsFound': _tappedFlags.length}),
                    icon: const Icon(Icons.flag, color: Colors.orange),
                    label: const Text(
                      'Report as Scam',
                      style: TextStyle(color: Colors.orange),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/sim3-form'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Apply Now →',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _tappableRow({
    required BuildContext context,
    required int flagId,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        if (!_tappedFlags.contains(flagId)) {
          setState(() => _tappedFlags.add(flagId));
          _showFlagDialog(context, _redFlags[flagId]);
        }
      },
      child: child,
    );
  }

  void _showFlagDialog(BuildContext context, _RedFlag flag) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          flag.label,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
        content: Text(flag.detail),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}

class _RedFlag {
  final int id;
  final String label;
  final String detail;
  const _RedFlag({required this.id, required this.label, required this.detail});
}