import 'package:flutter/material.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text("Guardian Path")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),

            PrimaryButton(
              text: "Simulation 1 (Account Setup)",
              onPressed: () => Navigator.pushNamed(context, '/create-account'),
            ),

            SizedBox(height: 10),

            PrimaryButton(
              text: "Simulation 2 (Scam Detection)",
              onPressed: () => Navigator.pushNamed(context, '/sim2-intro'),
            ),

            SizedBox(height: 10),

            PrimaryButton(
              text: "Quiz",
              onPressed: () => Navigator.pushNamed(context, '/quiz'),
            ),

            SizedBox(height: 10),

            PrimaryButton(
              text: "Dashboard",
              onPressed: () => Navigator.pushNamed(context, '/dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}