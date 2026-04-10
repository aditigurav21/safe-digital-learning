/*import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController bankController = TextEditingController();

  void showWarning(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("⚠ Warning"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Understood"),
          )
        ],
      ),
    );
  }

  void submitForm() {
    if (nameController.text.isEmpty ||
        aadhaarController.text.isEmpty ||
        bankController.text.isEmpty) {
      showWarning("Please fill all details.");
      Future.delayed(const Duration(seconds: 2), () {
  Navigator.pushNamed(context, '/sim1-call');// call to call
});
      return;
    }

    // 🔥 SIMULATION WARNING
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure?"),
        content: const Text(
          "You are entering sensitive information.\n\n"
          "Make sure you are on a trusted government website.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim1-otp');
            },
            child: const Text("Continue"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apply for Scheme")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // 🔷 Title
            const Text(
              "Fill Details for Scheme Application",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // 🔷 Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // 🔷 Aadhaar
            TextField(
              controller: aadhaarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Aadhaar Number",
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showWarning(
                  "Never share Aadhaar on unknown websites.",
                );
              },
            ),

            const SizedBox(height: 15),

            // 🔷 Bank
            TextField(
              controller: bankController,
              decoration: const InputDecoration(
                labelText: "Bank Account Number",
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showWarning(
                  "Bank details should only be entered on official websites.",
                );
              },
            ),

            const SizedBox(height: 30),

            // 🔷 Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitForm,
                child: const Text("Submit Application"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController bankController = TextEditingController();

  void showWarning(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("⚠ Warning"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Understood"),
          )
        ],
      ),
    );
  }

  void submitForm() {
    if (nameController.text.isEmpty ||
        aadhaarController.text.isEmpty ||
        bankController.text.isEmpty) {
      showWarning("Please fill all details.");
      // Navigate to fake call even if fields are empty for simulation
      Navigator.pushNamed(context, '/sim1-call');
      return;
    }

    // Confirmation dialog before submitting real data
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure?"),
        content: const Text(
          "You are entering sensitive information.\n\n"
          "Make sure you are on a trusted government website.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to fake call screen first
              Navigator.pushNamed(context, '/sim1-call');
            },
            child: const Text("Continue"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apply for Scheme")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔷 Title
            const Text(
              "Fill Details for Scheme Application",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 🔷 Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // 🔷 Aadhaar
            TextField(
              controller: aadhaarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Aadhaar Number",
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showWarning("Never share Aadhaar on unknown websites.");
              },
            ),
            const SizedBox(height: 15),

            // 🔷 Bank
            TextField(
              controller: bankController,
              decoration: const InputDecoration(
                labelText: "Bank Account Number",
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showWarning(
                  "Bank details should only be entered on official websites.",
                );
              },
            ),
            const SizedBox(height: 30),

            // 🔷 Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitForm,
                child: const Text("Submit Application"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
