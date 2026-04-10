import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class ScamShopScreen extends StatefulWidget {
  @override
  State<ScamShopScreen> createState() => _ScamShopScreenState();
}

class _ScamShopScreenState extends State<ScamShopScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cardController = TextEditingController();
  final _aadhaarController = TextEditingController();

  // Which red flags have been revealed
  final Set<String> _revealedFlags = {};
  int _step = 0; // 0=landed, 1=filled name, 2=filled phone, 3=card, 4=aadhaar

  @override
  void initState() {
    super.initState();
    // Show URL red flag immediately on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showFlag(
        context,
        '🚩 Suspicious URL Detected',
        'The address bar shows:\n\nflipkart-deals99.in/iphone-offer\n\n'
            'Real Flipkart URL is: flipkart.com\n\n'
            '"flipkart-deals99" is a fake domain designed to trick you!',
        'url',
      );
    });
  }

  void _showFlag(
      BuildContext context, String title, String body, String flagKey) {
    if (_revealedFlags.contains(flagKey)) return;
    _revealedFlags.add(flagKey);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.red.shade50,
        title: Row(
          children: [
            const Icon(Icons.warning_rounded, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.red, fontSize: 16))),
          ],
        ),
        content: Text(body,
            style: const TextStyle(fontSize: 15, height: 1.5)),
        actions: [
          ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildFakeBrowser(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildShopHeader(),
                    _buildProductCard(),
                    _buildOrderForm(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFakeBrowser() {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.lock_open,
                      size: 14, color: Colors.red.shade400),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'flipkart-deals99.in/iphone-offer',
                      style: TextStyle(fontSize: 12, color: Colors.red),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showFlag(
              context,
              '🚩 Not Secure!',
              'Notice the open lock icon 🔓\n\nReal shopping sites show a '
                  'closed lock 🔒 (HTTPS). This site is NOT secure.\n\n'
                  'Never enter payment details on sites without HTTPS!',
              'https',
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(6)),
              child: Icon(Icons.info_outline,
                  size: 18, color: Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade700,
      child: Row(
        children: [
          Text(
            'Fllipkart',  // intentional typo — teaching moment
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _showFlag(
              context,
              '🚩 Logo Misspelling!',
              'The logo says "Fllipkart" — notice the double "l"!\n\n'
                  'Scammers copy real brand logos but make tiny spelling '
                  'mistakes hoping you won\'t notice. Always check carefully!',
              'logo',
            ),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('🚩 Spot this!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_iphone,
                      size: 80, color: Colors.blue.shade400),
                  const Text('iPhone 15 Pro',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('iPhone 15 Pro — 256GB',
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('₹4,999',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text('₹1,39,900',
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('⏰ Offer ends in 00:47:23',
                style: TextStyle(color: Colors.red, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Complete Your Order',
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          _buildField(
            label: 'Full Name',
            controller: _nameController,
            hint: 'Enter your name',
            icon: Icons.person_outline,
            onTap: null,
          ),
          const SizedBox(height: 12),

          _buildField(
            label: 'Phone Number',
            controller: _phoneController,
            hint: 'Enter your mobile number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            onTap: () {
              if (_phoneController.text.isNotEmpty) {
                _showFlag(
                  context,
                  '🚩 Why do they need your phone?',
                  'A legitimate shopping site only needs your phone to '
                      'send delivery updates.\n\nBut scammers collect phone '
                      'numbers to send fake OTP requests later!\n\n'
                      'Notice: they\'ll ask you for an OTP next...',
                  'phone',
                );
              }
            },
          ),
          const SizedBox(height: 12),

          _buildField(
            label: 'Delivery Address',
            controller: _addressController,
            hint: 'Enter your full address',
            icon: Icons.location_on_outlined,
            onTap: null,
          ),
          const SizedBox(height: 12),

          _buildField(
            label: 'Card Number',
            controller: _cardController,
            hint: '0000 0000 0000 0000',
            icon: Icons.credit_card,
            keyboardType: TextInputType.number,
            onTap: () => _showFlag(
              context,
              '🚩 Never enter card details here!',
              'This site is NOT secure (no HTTPS, suspicious URL).\n\n'
                  'Real payment pages on Flipkart/Amazon go through '
                  'Razorpay or PayU — a trusted third-party payment gateway.\n\n'
                  'Never type your card number on any site you\'re not 100% sure about!',
              'card',
            ),
          ),
          const SizedBox(height: 12),

          // The Aadhaar field — the biggest red flag
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Aadhaar Number (for KYC)',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => _showFlag(
                      context,
                      '🚩 BIGGEST RED FLAG!',
                      'NO shopping website ever needs your Aadhaar number!\n\n'
                          'Your Aadhaar is a government identity document. '
                          'Giving it to a scammer allows:\n'
                          '• Identity theft\n'
                          '• Fake loan applications in your name\n'
                          '• SIM card fraud\n\n'
                          'NEVER share your Aadhaar on shopping sites!',
                      'aadhaar_label',
                    ),
                    child: Icon(Icons.warning_rounded,
                        color: Colors.red.shade600, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _aadhaarController,
                keyboardType: TextInputType.number,
                onTap: () => _showFlag(
                  context,
                  '🚩 BIGGEST RED FLAG!',
                  'NO shopping website ever needs your Aadhaar number!\n\n'
                      'Your Aadhaar is a government identity document. '
                      'Giving it to a scammer allows:\n'
                      '• Identity theft\n'
                      '• Fake loan applications in your name\n'
                      '• SIM card fraud\n\n'
                      'NEVER share your Aadhaar on shopping sites!',
                  'aadhaar',
                ),
                decoration: InputDecoration(
                  hintText: 'XXXX XXXX XXXX',
                  prefixIcon: const Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.red.shade50,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _onPlaceOrder(context),
              child: const Text('Place Order & Pay ₹4,999',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }

  void _onPlaceOrder(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.red.shade50,
        title: const Text('⛔ Stop! You\'re about to be scammed!',
            style: TextStyle(color: Colors.red)),
        content: const Text(
          'In a real scenario, clicking this would have:\n\n'
              '• Stolen your card details\n'
              '• Collected your Aadhaar for identity theft\n'
              '• Charged money with no product delivered\n\n'
              'Now let\'s see if you can resist the next trick — a fake delivery agent chat.',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim2-chat');
            },
            child: const Text('See next threat →',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cardController.dispose();
    _aadhaarController.dispose();
    super.dispose();
  }
}
