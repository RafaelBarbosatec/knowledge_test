import 'package:flutter/material.dart';
import 'package:knowledge_test/data/model/question.dart';
import 'package:knowledge_test/pages/questions/widgets/question_widget.dart';

class QuestionsPage extends StatefulWidget {
  final List<Question> questions;
  final String theme;
  const QuestionsPage(
      {super.key, required this.questions, required this.theme});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final Map<int, int?> _answers = {};
  bool showCorrect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.theme),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.questions.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return QuestionWidget(
                  item: widget.questions[index],
                  selectedIndex: _answers[index],
                  showCorrect: showCorrect,
                  onTapAnswer: (res) {
                    setState(() {
                      _answers[index] = res;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: _answers.length >= widget.questions.length
                    ? _subimit
                    : null,
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(StadiumBorder()),
                ),
                child: const Text('Validar'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _subimit() {
    setState(() {
      showCorrect = true;
    });
  }
}
