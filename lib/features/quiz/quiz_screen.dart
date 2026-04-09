class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;

  List questions = [
    {"q": "Share OTP?", "a": false},
    {"q": "Click unknown link?", "a": false},
  ];

  void answer(bool val) {
    if (val == questions[index]['a']) score++;

    if (index < questions.length - 1) {
      setState(() => index++);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Score"),
          content: Text("$score / ${questions.length}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(questions[index]['q']),

          ElevatedButton(
              onPressed: () => answer(true), child: Text("Yes")),
          ElevatedButton(
              onPressed: () => answer(false), child: Text("No")),
        ],
      ),
    );
  }
}