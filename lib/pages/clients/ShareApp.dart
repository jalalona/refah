import 'package:flutter/material.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedGreenButton.dart';
import 'package:refah/widgets/WDG_Vector2.dart';

class ShareApp extends StatefulWidget {
  String title;
  String description;
  Widget vector;

  ShareApp({
    this.description,
    this.title,
    this.vector,
  });

  @override
  _ShareAppState createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  Map<String, dynamic> values;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(30.0),
                child: widget.vector ?? WDG_Vector2(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  widget.title ?? "معرفی به دوست",
                  style: TextStyle(
                    fontFamily: "IRANSans",
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  width: MediaQuery.of(context).size.width - 100.0,
                  child: Text(
                    "بزودی",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  child: Text(""),
                ),
              ),
              Container(
                child: WDG_BorderedGreenButton(
                  title: "ممنون",
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
