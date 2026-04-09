class CreateAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/password'),
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}