import 'package:flutter/material.dart';
import 'package:knowledge_test/data/model/question.dart';
import 'package:knowledge_test/data/questions_repository.dart';

class HomeController extends ChangeNotifier {
  final QuestionRepository _repository;
  List<Question> questions = [];
  bool loading = false;

  HomeController(this._repository);

  void loadQuestions(
    String theme,
    ValueChanged<List<Question>> questions,
  ) async {
    loading = true;
    notifyListeners();
    _repository.getQuestions(theme).then((value) {
      questions(value);
    }).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}
