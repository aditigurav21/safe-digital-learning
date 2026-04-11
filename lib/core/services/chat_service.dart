import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  static const String apiKey = "AIzaSyA1OCZKJ3sSnpsj-v3KZRpxsk3LxCrsbCY";

  static Future<String> sendMessage(String userMessage) async {
  int retries = 3;

  while (retries > 0) {
    try {
      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$apiKey",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userMessage}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      }

      // Retry on 503
      if (response.statusCode == 503) {
        retries--;
        await Future.delayed(const Duration(seconds: 2));
        continue;
      }

      return "Error: ${response.statusCode}";
    } catch (e) {
      return "Something went wrong";
    }
  }

  return "Server busy. Try again later.";
}
}
