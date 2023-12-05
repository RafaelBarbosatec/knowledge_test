import 'dart:convert';

import 'package:knowledge_test/data/model/question.dart';
import 'package:knowledge_test/provides/llm_provider/llm_provider.dart';

class QuestionRepository {
  // ignore: constant_identifier_names
  static const PROMPT_BASE = """
Retorne no formato json 5 perguntas cada uma com 3 respostas distintas 1 deve ser marcada como correta. 
Campo da pergunta deve se chamar texto.
Campo da resposta deve se chamar texto.
Campo que diz se é a correta deve se chamar correto
O tema das perguntas deve ser {tema}""";

  final LLMProvider llm;

  QuestionRepository({required this.llm});

  Future<List<Question>> getQuestions(String theme) {
    final prompt = PROMPT_BASE.replaceAll('{tema}', theme);
    return llm.prompt(prompt).then(_mapQuestionList);
  }

  List<Question> _mapQuestionList(String value) {
    final map = jsonDecode(value.replaceAll('\n', ''));
    return (map['perguntas'] as List).map((e) {
      return Question.fromMap((e as Map).cast());
    }).toList();
  }
}
