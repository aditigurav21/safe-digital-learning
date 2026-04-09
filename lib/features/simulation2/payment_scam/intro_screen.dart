class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Learn to detect scams!", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/sim2-link'),
              child: Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}