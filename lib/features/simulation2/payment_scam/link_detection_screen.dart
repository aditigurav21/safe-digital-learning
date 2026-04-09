class LinkDetectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Safe Link")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("http://secure-bank.com ✅"),
            ),

            ElevatedButton(
              onPressed: () {},
              child: Text("http://bank-login.xyz ❌"),
            ),
          ],
        ),
      ),
    );
  }
}