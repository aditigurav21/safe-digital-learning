import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController controller = TextEditingController();
  String message = "";

  void checkPassword() {
    if (controller.text.length < 6) {
      setState(() => message = "Weak Password ❌");
    } else {
      Navigator.pushNamed(context, '/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Password")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: controller, obscureText: true),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: checkPassword,
              child: Text("Submit"),
            ),

            Text(message),
          ],
        ),
      ),
    );
  }
}