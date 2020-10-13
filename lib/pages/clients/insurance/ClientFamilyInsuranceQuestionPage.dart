import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/Provider/QuestionProvider.dart';
import 'package:refah/models/AnswerVM.dart';
import 'package:refah/models/QuestionVM.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/pages/clients/insurance/InsuranceFamilyPage.dart';
import 'package:refah/pages/clients/insurance/InsuranceRegisterPage.dart';
import 'package:refah/widgets/WDG_BigGreenButton.dart';
import 'package:refah/widgets/WDG_CloseCircleButton.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';

class ClientFamilyInsuranceQuestionPage extends StatefulWidget {
  String title;
  String description;
  List<WDG_QuestionItem> qs = List<WDG_QuestionItem>();
  List<QuestionAnswer> ans = List<QuestionAnswer>();
  Function(dynamic result) onCallback;

  void refreshQuestions(QuestionProvider provider) {
    qs = provider.getWidgets();
    ans = provider.getAnswers();
  }

  ClientFamilyInsuranceQuestionPage({
    this.description,
    this.title,
  });

  @override
  _ClientFamilyInsuranceQuestionPageState createState() =>
      _ClientFamilyInsuranceQuestionPageState();
}

class _ClientFamilyInsuranceQuestionPageState
    extends State<ClientFamilyInsuranceQuestionPage> {
  List<WDG_QuestionItem> questionItems = List<WDG_QuestionItem>();

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => InsuranceFamilyPage(),
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
          question: "آیا شما بیماری یا جراحی خاصی دارید ؟",
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
          question: "آیا در یک سال آینده نیاز به جراحی دارید ؟",
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
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: questionItems,
                  ),
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  WDG_BigGreenButton(
                    pop: true,
                    text: "تائید",
                    route: InsuranceRegisterPage(),
                  ),
                  WDG_CloseCircleButton(
                    route: ClientHomePage(),
                  ),
                ],
              )),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
