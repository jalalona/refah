import 'package:flutter/material.dart';
import 'package:refah/models/AnswerVM.dart';
import './WDG_SelectedRadio.dart';

class WDG_Answer extends StatelessWidget {
  Widget icon;
  AnswerVM answer;
  Function(int aid) onTapCallback;

  WDG_Answer({
    this.answer,
    this.onTapCallback,
    this.icon,
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    icon = icon ?? WDG_SelectedRadio();

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
        ),
        padding: EdgeInsets.all(5.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            icon,
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                answer?.text ?? 'بله',
                style: TextStyle(
                  fontFamily: 'IRANSans',
                  fontSize: 14,
                  color: const Color(0xff313450),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback(answer.id);
        }
      },
    );
  }
}
