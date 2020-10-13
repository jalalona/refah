import 'package:refah/models/AnswerVM.dart';

class QuestionVM {
  int id;
  String question;
  List<AnswerVM> answers;

  QuestionVM({
    this.answers,
    this.id,
    this.question,
  });

  void clearAnswerSelection() {
    answers?.forEach((element) {
      element.selected = false;
    });
  }
}
