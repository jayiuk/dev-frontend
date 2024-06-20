import 'package:flutter/material.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Map<String, List<Map<String, dynamic>>> quizMap = {
    '상': [
      {
        '질문': '월당관은 이재정 석좌교수의 장인의 유산을 기부받아 지어졌습니다. 그 분의 호는 무엇일까요?',
        '정답': '월당',
        '선택지': ['월당', '현덕', '인지', '삼봉'],
        '해설': '이 건물은 기부하신 분의 호를 따 월당관으로 명명되었습니다.'
      }
    ],
    '중': [
      {
        '질문': '월당관에는 ??을 할 수 있는 곳이 있다',
        '정답': 'A/S',
        '선택지': ['학점 수정', '게임', '졸업', 'A/S'],
        '해설': '정답은 A/S입니다. 월당관에는 A/S실이 있어요.'
      }
    ],
    '하': [
      {
        '질문': '월당관 OO에서 공부를 많이 한다.',
        '정답': '열람실',
        '선택지': ['프로젝트실', '3302', '열람실', '3301'],
        '해설': '월당관에는 열람실이 있습니다. 시험기간에 많은 학생들이 애용하는 곳이에요.'
      }
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퀴즈'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showRandomQuiz(context);
          },
          child: Text('퀴즈 시작하기'),
        ),
      ),
    );
  }

  void _showRandomQuiz(BuildContext context) {
    final random = Random();
    String difficulty;

    if (random.nextDouble() < 0.33) {
      difficulty = '상';
    } else if (random.nextDouble() < 0.66) {
      difficulty = '중';
    } else {
      difficulty = '하';
    }

    final randomQuiz = quizMap[difficulty]![random.nextInt(quizMap[difficulty]!.length)];

    _showQuizDialog(
        context,
        difficulty,
        randomQuiz['질문'],
        randomQuiz['정답'],
        randomQuiz['선택지'],
        randomQuiz['해설']
    );
  }

  void _showQuizDialog(
      BuildContext context,
      String difficulty,
      String question,
      String answer,
      List<String> options,
      String explanation
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('퀴즈'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(question),
              SizedBox(height: 16),
              ...options.map((option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: null,
                onChanged: (value) {
                  Navigator.of(context).pop();
                  _checkAnswer(context, value!, answer, explanation);
                },
              )),
            ],
          ),
        );
      },
    );
  }

  void _checkAnswer(BuildContext context, String userAnswer, String correctAnswer, String explanation) {
    bool isCorrect = userAnswer == correctAnswer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? '정답' : '오답'),
          content: Text(isCorrect
              ? '정답입니다!\n\n해설: $explanation'
              : '오답입니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
