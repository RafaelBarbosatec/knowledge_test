import 'package:flutter/material.dart';
import 'package:knowledge_test/data/model/question.dart';
import 'package:knowledge_test/pages/questions/questions_page.dart';

class QuestionsRoute{
  static const name = '/questions';

  static Map<String, WidgetBuilder> get builder => {
        name: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
          return QuestionsPage(
            questions:args['questions'],
            theme: args['theme'],
          );
        },
      };

  static Future open(
    BuildContext context,
    List<Question> questions,
    String theme,) {
    return Navigator.of(context).pushNamed(
      name,
      arguments: {
        'theme': theme,
        'questions': questions,
      },
    );
  }
}