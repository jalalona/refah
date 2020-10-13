import 'package:refah/Provider/QuestionProvider.dart';

class AnswerPackageVM {
  List<QuestionAnswer> answers;

  AnswerPackageVM({
    this.answers,
  });

  AnswerPackageVM.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = List<QuestionAnswer>();
      json['answers'].forEach((v) {
        answers.add(QuestionAnswer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<AnswerPackageVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<AnswerPackageVM>((ct) {
        return AnswerPackageVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
