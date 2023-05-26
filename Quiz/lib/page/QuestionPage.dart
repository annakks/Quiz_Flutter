import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> questions = [
    {
      'question': 'Qual bicho transmite Doença de Chagas?',
      'options': {
        'a': 'Aedes aegypti',
        'b': 'Barbeiro',
        'c': 'Pulga',
        'd': 'Caramujo',
        'e': 'Muriçoca',
      },
      'correctAnswer': 'b',
    },
    {
      'question': 'Qual fruto é conhecido no Norte e Nordeste como "jerimum"?',
      'options': {
        'a': 'Abacate',
        'b': 'Caju',
        'c': 'Dendê',
        'd': 'Melancia',
        'e': 'Abóbora',
      },
      'correctAnswer': 'e',
    },
    {
      'question': 'Qual é o coletivo de cães?',
      'options': {
        'a': 'Cardume',
        'b': 'Rebanho',
        'c': 'Alcateia',
        'd': 'Manada',
        'e': 'Matilha',
      },
      'correctAnswer': 'e',
    },
    {
      'question': 'Qual é o triângulo que tem todos os lados diferentes?',
      'options': {
        'a': 'Equilátero',
        'b': 'Isósceles',
        'c': 'Escaleno',
        'd': 'Retângulo',
        'e': 'Obtusângulo',
      },
      'correctAnswer': 'c',
    },
    {
      'question': 'Quem compôs o Hino da Independência?',
      'options': {
        'a': 'Castro Alves',
        'b': 'Machado de Assis',
        'c': 'Carlos Gomes',
        'd': 'Manuel Bandeira',
        'e': 'Dom Pedro I',
      },
      'correctAnswer': 'c',
    },
  ];

  String? selectedOption;
  int correctAnswersCount = 0;

  void checkAnswer() {
    String correctAnswer = questions[currentQuestionIndex]['correctAnswer'];

    if (selectedOption == correctAnswer) {
      setState(() {
        correctAnswersCount++;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resposta Correta!'),
            content: Text('Parabéns, você acertou!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentQuestionIndex++;
                    selectedOption = null;
                  });
                },
                child: Text('Próxima Pergunta'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String correctAnswer =
              questions[currentQuestionIndex]['correctAnswer'];
          String correctAnswerText =
              questions[currentQuestionIndex]['options'][correctAnswer];

          return AlertDialog(
            title: Text('Resposta Incorreta!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Infelizmente, você errou.'),
                SizedBox(height: 16),
                Text('Resposta correta: $correctAnswerText'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentQuestionIndex++;
                    selectedOption = null;
                  });
                },
                child: Text('Próxima Pergunta'),
              ),
            ],
          );
        },
      );
    }
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      correctAnswersCount = 0;
      selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Show da Carol'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Parabéns! Você concluiu o questionário.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Text(
                'Respostas corretas: $correctAnswersCount/${questions.length}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: restartQuiz,
                child: Text('Reiniciar Questionário'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Show da Carol'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pergunta ${currentQuestionIndex + 1}:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                questions[currentQuestionIndex]['question'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...questions[currentQuestionIndex]['options'].entries.map(
                (entry) {
                  String option = entry.key;
                  String answerText = entry.value;
                  return RadioListTile<String>(
                    title: Text(answerText),
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  );
                },
              ).toList(),
              ElevatedButton(
                onPressed: checkAnswer,
                child: Text('Verificar Resposta'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
