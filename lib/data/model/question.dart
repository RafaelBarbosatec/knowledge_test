// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Question {
  final String pergunta;
  final List<Answer> respostas;

  Question({required this.pergunta, required this.respostas});

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      pergunta: map['texto'] ?? '',
      respostas: List<Answer>.from(
        (map['respostas'] as List).map<Answer>(
          (x) => Answer.fromMap((x as Map).cast()),
        ),
      ),
    );
  }

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Answer {
  final String resposta;
  final bool correto;

  Answer({required this.resposta, required this.correto});

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      resposta: map['texto'] ?? '',
      correto: map['correto'] ?? false,
    );
  }

  factory Answer.fromJson(String source) => Answer.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
