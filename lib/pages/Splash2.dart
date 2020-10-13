import 'package:flutter/material.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedGreenButton.dart';
import 'package:refah/widgets/WDG_Vector2.dart';

class Splash2 extends StatefulWidget {
  String title;
  String description;
  Widget vector;

  Splash2({
    this.description,
    this.title,
    this.vector,
  });

  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  Map<String, dynamic> values;

  @override
  void initState() {
    super.initState();

    OptionService().getByName("people_intro").then((value) {
      setState(() {
        widget.description = value?.value;
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
              Container(
                margin: EdgeInsets.all(30.0),
                child: widget.vector ?? WDG_Vector2(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  widget.title ?? "خدمات بیمه تکمیلی",
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
                  title: "پایان",
                  width: 200.0,
                  pop: true,
                  route: ClientHomePage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
