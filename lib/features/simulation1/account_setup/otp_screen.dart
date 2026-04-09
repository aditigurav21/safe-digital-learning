class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Which message is safe?"),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Bank OTP: 123456"),
            ),

            ElevatedButton(
              onPressed: () {},
              child: Text("Share OTP to verify account ❌"),
            ),
          ],
        ),
      ),
    );
  }
}