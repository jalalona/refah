import 'package:flutter/material.dart';
import 'package:refah/models/QuestionVM.dart';
import './WDG_Answer.dart';
import 'WDG_SelectedRadio.dart';

class WDG_QuestionItem extends StatefulWidget {
  QuestionVM question;
  Widget answersWidget;
  Function(int qid, int aid) answerCallback;

  List<WDG_Answer> setAnswers() {
    var items = question?.answers?.map((e) {
      if (e.selected ?? false) {
        return WDG_Answer(
          answer: e,
          onTapCallback: (result) {
            answerCallback(question.id, result);
          },
          icon: WDG_SelectedRadio(
            bg: Color(0xff1fac9c),
          ),
        );
      } else {
        return WDG_Answer(
          answer: e,
          onTapCallback: (result) {
            answerCallback(question.id, result);
          },
        );
      }
    }).toList();

    return items;
  }

  WDG_QuestionItem({
    this.question,
    this.answerCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_QuestionItemState createState() => _WDG_QuestionItemState();
}

class _WDG_QuestionItemState extends State<WDG_QuestionItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffffffff),
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              widget.question?.question ?? "متن سوال",
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 12,
                color: const Color(0xff898a8f),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.setAnswers(),
            ),
          ],
        ),
      ),
    );
  }
}
