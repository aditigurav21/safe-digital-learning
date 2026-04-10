import 'package:flutter/material.dart';


class OtpChatScreen extends StatefulWidget {
  @override
  State<OtpChatScreen> createState() => _OtpChatScreenState();
}

class _OtpChatScreenState extends State<OtpChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];

  bool _simulationEnded = false;
  int _refusalCount = 0;

  @override
  void initState() {
    super.initState();

    _messages.add(const _ChatMessage(
      text:
      'Hello ji! 😊 Main Flipkart delivery agent Rahul bol raha hoon.\nAapka order #FL994821 out for delivery hai!\nDelivery confirm karne ke liye OTP share karein.',
      isUser: false,
      isSystem: false,
    ));
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty || _simulationEnded) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true, isSystem: false));
    });

    _controller.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 600), () {
      _handleBotReply(text.toLowerCase());
    });
  }

  void _handleBotReply(String userText) {
    String reply = '';

    // 🔴 Check OTP (any 6 digit number)
    final otpRegex = RegExp(r'\b\d{6}\b');
    if (otpRegex.hasMatch(userText)) {
      _simulationEnded = true;

      setState(() {
        _messages.add(const _ChatMessage(
          text:
          'Thank you for the OTP! Your order is confirmed! 😊',
          isUser: false,
          isSystem: false,
        ));
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        _showResult(caught: true);
      });

      return;
    }

    // 🟢 Detect refusal keywords
    if (userText.contains('no') ||
        userText.contains('nahi') ||
        userText.contains('not sharing') ||
        userText.contains('don’t')) {
      _refusalCount++;
    }

    // 🧠 Response logic
    if (_refusalCount == 0) {
      reply =
      'Sir OTP de dijiye na, delivery confirm karni hai. 😊';
    } else if (_refusalCount == 1) {
      reply =
      'Jaldi karein ji, warna order 10 min mein cancel ho jayega!';
    } else if (_refusalCount == 2) {
      reply =
      'Last warning! Manager aapka order aur account block kar dega!';
    } else {
      _simulationEnded = true;

      setState(() {
        _messages.add(const _ChatMessage(
          text: 'No problem ji, have a good day. 👋',
          isUser: false,
          isSystem: false,
        ));
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        _showResult(caught: false);
      });

      return;
    }

    setState(() {
      _messages.add(_ChatMessage(
        text: reply,
        isUser: false,
        isSystem: false,
      ));
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showResult({required bool caught}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor:
        caught ? Colors.red.shade50 : Colors.green.shade50,
        title: Text(
          caught ? '⚠️ You shared the OTP!' : '🛡️ You stayed safe!',
          style: TextStyle(
              color: caught ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold),
        ),
        content: Text(
          caught
              ? 'You shared your OTP.\n\nIn real life, this could lead to fraud.\nNever share OTP with anyone.'
              : 'Great! You refused to share OTP.\n\nAlways keep OTP private.',
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim2-debrief',
                  arguments: {'caughtByScammer': caught});
            },
            child: const Text('Continue →'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: const Text('R'),
          ),
        ),
        title: const Text('Rahul (Flipkart Delivery)',
            style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _buildBubble(_messages[i]),
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildBubble(_ChatMessage msg) {
    return Align(
      alignment:
      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: msg.isUser ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
              color: msg.isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !_simulationEnded,
              decoration: const InputDecoration(
                hintText: 'Type...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _sendMessage,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final bool isSystem;

  const _ChatMessage({
    required this.text,
    required this.isUser,
    required this.isSystem,
  });
}