import 'package:flutter/material.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedGreenButton.dart';
import 'package:refah/widgets/WDG_Vector1.dart';

import 'Splash2.dart';

class Splash1 extends StatefulWidget {
  String title;
  String description;
  Widget vector;

  Splash1({
    this.description,
    this.title,
    this.vector,
  });

  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  bool vis = false;
  Map<String, dynamic> values;

  @override
  void initState() {
    super.initState();
    OptionService().getByName("people_wellcome").then((value) {
      setState(() {
        vis = true;
        widget.description = value?.value;
        vis = false;
      });
    });

    EnrollService().clearMyEnrolls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: vis,
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                child: widget.vector ?? WDG_Vector1(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  widget.title ?? "مرکز خدمات درمانی",
                  style: TextStyle(
                    fontFamily: "IRANSans",
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  widget.description ??
                      "به مرکز درمانی رفاه اندیشان خوش امدید . امیوام که سالم و سسلامت باشید",
                  style: TextStyle(
                    fontFamily: "IRANSans",
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(""),
                ),
              ),
              Container(
                child: WDG_BorderedGreenButton(
                  title: "بعدی",
                  width: 200.0,
                  pop: true,
                  route: Splash2(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
