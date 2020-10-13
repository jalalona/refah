import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:refah/models/QuestionVM.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';

class QuestionAnswer {
  int questionId;
  int answerId;

  QuestionAnswer({
    this.answerId,
    this.questionId,
  });

  QuestionAnswer.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerId'] = this.answerId;
    data['questionId'] = this.questionId;
    return data;
  }
}

class QuestionProvider with ChangeNotifier {
  Function(QuestionProvider provider) refreshCallback;
  static List<QuestionVM> questions = List<QuestionVM>();
  static List<QuestionAnswer> selected = List<QuestionAnswer>();

  QuestionProvider({
    this.refreshCallback,
  });

  List<QuestionAnswer> getAnswers() {
    return selected;
  }

  QuestionProvider add(QuestionVM q) {
    questions.add(q);
    return this;
  }

  QuestionProvider addRange(List<QuestionVM> items) {
    clear();
    questions.addAll(items);

    return this;
  }

  QuestionProvider remove(int _id) {
    var index = questions.indexWhere((element) => element.id == _id);

    if (index >= 0) {
      questions.removeAt(index);
    }

    return this;
  }

  QuestionProvider clear() {
    questions.clear();
    selected.clear();

    return this;
  }

  List<QuestionVM> getQuestions() {
    return questions;
  }

  List<QuestionVM> getSelectedQuestions() {
    return questions
        .where((element) =>
            selected.where((whr) => whr.questionId == element.id).length > 0)
        .toList();
  }

  QuestionProvider addOrUpdateSelected(int qid, int aid) {
    var index = selected.indexWhere((element) => element.questionId == qid);

    if (index >= 0) {
      selected[index].answerId = aid;

      var qindex = questions.indexWhere((element) => element.id == qid);

      if (qindex >= 0) {
        var aindex = questions[qindex]
            .answers
            .indexWhere((element) => element.id == aid);

        questions[qindex].clearAnswerSelection();
        questions[qindex].answers[aindex].selected = true;
      }
    } else {
      selected.add(
        QuestionAnswer(
          answerId: aid,
          questionId: qid,
        ),
      );
      var qindex = questions.indexWhere((element) => element.id == qid);

      var aindex =
          questions[qindex].answers.indexWhere((element) => element.id == aid);

      questions[qindex].clearAnswerSelection();
      questions[qindex].answers[aindex].selected = true;
    }

    return this;
  }

  List<WDG_QuestionItem> getWidgets() {
    return questions.map((e) {
      return WDG_QuestionItem(
        question: e,
        answerCallback: (qid, aid) {
          addOrUpdateSelected(qid, aid);
          refreshCallback(this);
        },
      );
    }).toList();
  }
}
