import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

// Classes
class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        questionText,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 30, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback submitAnswer;

  Answer(this.answerText, this.submitAnswer);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 50,
        margin: EdgeInsets.all(5),
        child: (RaisedButton(
          color: Colors.redAccent,
          textColor: Colors.white,
          child: Text(
            answerText,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 17),
          ),
          onPressed: submitAnswer as VoidCallback,
        )));
  }
}

class Result extends StatelessWidget {
  final int resultScore;

  Result(this.resultScore);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Your Score is: ' + resultScore.toString(),
        style: TextStyle(
            fontSize: 60, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  State<QuizApp> createState() => QuizAppState();
}

class QuizAppState extends State<QuizApp> {
  var questionIndex = 0;
  var totalScore = 0;

  // Functions
  void submitAnswer(int points) {
    totalScore = totalScore + points;
    setState(() {
      questionIndex = questionIndex + 1;
    });
  }

  final questions = const [
    {
      'questionText': "What is the name of Luffy's Devil Fruit?",
      'answer': [
        {'text': 'Jake Jake no Mi', 'points': 0},
        {'text': 'Ito Ito no Mi', 'points': 0},
        {'text': 'Gomu Gomu no Mi', 'points': 1},
        {'text': 'Bara Bara no Mi', 'points': 0},
      ]
    },
    {
      'questionText': "What is the name of Boa's Devil Fruit?",
      'answer': [
        {'text': 'Mero Mero no Mi', 'points': 1},
        {'text': 'Ito Ito no Mi', 'points': 0},
        {'text': 'Gomu Gomu no Mi', 'points': 0},
        {'text': 'Bara Bara no Mi', 'points': 0},
      ]
    },
    {
      'questionText': "What is the name of Whitebread's Devil Fruit?",
      'answer': [
        {'text': 'Jake Jake no Mi', 'points': 0},
        {'text': 'Ito Ito no Mi', 'points': 0},
        {'text': 'Gura Gura no Mi', 'points': 1},
        {'text': 'Bara Bara no Mi', 'points': 0},
      ]
    },
    {
      'questionText': "What is the name of Cracker's Devil Fruit?",
      'answer': [
        {'text': 'Jake Jake no Mi', 'points': 0},
        {'text': 'Ito Ito no Mi', 'points': 0},
        {'text': 'Gomu Gomu no Mi', 'points': 0},
        {'text': 'Bisu Bisu no Mi', 'points': 1},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: const Text(
              'Name That Devil Fruit',
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: questionIndex < questions.length
              ? Column(
                  children: [
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(50),
                        child: Question(questions[questionIndex]['questionText']
                            as String)),
                    ...(questions[questionIndex]['answer']
                            as List<Map<String, Object>>)
                        .map((answer) {
                      return Answer(answer['text'] as String,
                          () => submitAnswer(answer['points'] as int));
                    })
                  ],
                )
              : Result(totalScore)),
    );
  }
}
