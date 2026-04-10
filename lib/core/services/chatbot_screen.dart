import 'package:flutter/material.dart';
import 'chat_service.dart';
import 'chatbot_utils.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {

  final TextEditingController controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isTyping = false;

  void sendMessage() async {
    final userMessage = controller.text.trim();

    if (userMessage.isEmpty) return;

    // ✅ FILTER CHECK
    if (!isScamRelated(userMessage)) {
      setState(() {
        messages.add({"role": "bot", "text":
        "I can only help with scam and online safety questions."});
      });
      controller.clear();
      return;
    }

    setState(() {
      messages.add({"role": "user", "text": userMessage});
      isTyping = true;
    });

    controller.clear();

    final reply = await ChatbotService.sendMessage(userMessage);

    setState(() {
      messages.add({"role": "bot", "text": reply});
      isTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Assistant")),

      body: Column(
        children: [

          // 🔹 CHAT LIST
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                return ListTile(
                  title: Align(
                    alignment: msg["role"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: msg["role"] == "user"
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      child: Text(msg["text"] ?? ""),
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔹 TYPING INDICATOR
          if (isTyping)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Typing..."),
            ),

          // 🔹 INPUT BOX
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Ask about scams, fraud, safety...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}