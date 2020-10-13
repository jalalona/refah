import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/Provider/QuestionProvider.dart';
import 'package:refah/models/AnswerVM.dart';
import 'package:refah/models/QuestionVM.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/widgets/WDG_BigGreenButton.dart';
import 'package:refah/widgets/WDG_CloseCircleButton.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';

import 'AdminPanelPage.dart';

class AdminInsuranceQuestionPage extends StatefulWidget {
  Widget route;
  String title;
  String description;
  List<WDG_QuestionItem> qs = List<WDG_QuestionItem>();

  Function(dynamic result) onSubmitCallback;

  void refreshQuestions(QuestionProvider provider) {
    qs = provider.getWidgets();
  }

  AdminInsuranceQuestionPage({
    this.onSubmitCallback,
    this.route,
    this.description,
    this.title,
  });

  @override
  _AdminInsuranceQuestionPageState createState() =>
      _AdminInsuranceQuestionPageState();
}

class _AdminInsuranceQuestionPageState
    extends State<AdminInsuranceQuestionPage> {
  List<WDG_QuestionItem> questionItems = List<WDG_QuestionItem>();

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminPanelPage(),
    //   ),
    // );

    return false;
  }

  @override
  void initState() {
    super.initState();

    var provider = QuestionProvider(
      refreshCallback: (prv) {
        widget.refreshQuestions(prv);
        setState(() {
          questionItems = widget.qs;
        });
      },
    ).addRange(
      [
        QuestionVM(
          id: 1,
          question: "آیا شما باردار هستید ؟",
          answers: [
            AnswerVM(
              id: 1,
              text: "بله",
            ),
            AnswerVM(
              id: 2,
              text: "خیر",
            ),
          ],
        ),
        QuestionVM(
          id: 2,
          question: "آیا شما باردار هستید ؟",
          answers: [
            AnswerVM(
              id: 1,
              text: "بله",
            ),
            AnswerVM(
              id: 2,
              text: "خیر",
            ),
          ],
        ),
        QuestionVM(
          id: 3,
          question: "آیا شما باردار هستید ؟",
          answers: [
            AnswerVM(
              id: 1,
              text: "بله",
            ),
            AnswerVM(
              id: 2,
              text: "خیر",
            ),
          ],
        ),
      ],
    );

    setState(() {
      questionItems = provider.getWidgets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff898a8f),
      body: WillPopScope(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: questionItems,
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    WDG_BigGreenButton(
                      text: "تائید",
                      //route: widget.route,
                      onTapCallback: (result) {
                        if (widget.onSubmitCallback != null) {
                          widget.onSubmitCallback(result);
                        }
                      },
                    ),
                    WDG_CloseCircleButton(
                      route: ClientHomePage(),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
