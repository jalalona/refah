import 'package:flutter/material.dart';
import 'package:refah/models/WorkVM.dart';
import 'package:refah/services/WorkService.dart';
import 'package:refah/widgets/WDG_BorderedGreenButton.dart';
import 'package:refah/widgets/WDG_BorderedMultilineTextInput.dart';
import 'package:refah/widgets/WDG_Input.dart';
import 'package:refah/widgets/WDG_Vector2.dart';
import 'package:http/http.dart' as http;

class JoinApp extends StatefulWidget {
  String title;
  String description;
  Widget vector;

  JoinApp({
    this.description,
    this.title,
    this.vector,
  });

  @override
  _JoinAppState createState() => _JoinAppState();
}

class _JoinAppState extends State<JoinApp> {
  String text = "";
  String phone = "";
  Map<String, dynamic> values;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 60.0,
                    right: 90.0,
                    top: 30.0,
                  ),
                  child: widget.vector ?? WDG_Vector2(),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    widget.title ?? "دعوت به همکاری",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                WDG_Input(
                  height: 40.0,
                  hint: "شماره همراه",
                  onChangeCallback: (result) {
                    phone = result;
                  },
                ),
                WDG_BorderedMultilineTextInput(
                  height: 200.0,
                  hintText: "محتوای همکاری به همراه شماره",
                  onChangeCallback: (result) {
                    text = result;
                  },
                ),
                WDG_BorderedGreenButton(
                  title: "ارسال",
                  width: 200.0,
                  pop: true,
                  onTapCallback: (result) async {
                    var result = await WorkService().add(
                      WorkVM(
                        phone: phone,
                        message: text,
                      ),
                    );

                    if (result != null) {
                      Navigator.pop(context);
                    }
                    // var res = await http.get(
                    //   "https://api.refahandishanco.ir/refah/injoinsms?text=" +
                    //       text,
                    // );
                  },
                  //route: ClientHomePage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
