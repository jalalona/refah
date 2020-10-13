import 'package:flutter/material.dart';

class WDG_BorderedGreenButton extends StatelessWidget {
  String title;
  double width;
  Widget route;
  bool pop;
  double fontSize;
  Function(String result) onTapCallback;

  WDG_BorderedGreenButton({
    this.title = "دکمه",
    this.width = 160.0,
    this.onTapCallback,
    this.route,
    this.pop,
    this.fontSize,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color(0xffffffff),
          border: Border.all(
            width: 2.0,
            color: const Color(0xff1fac9c),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: fontSize ?? 14,
              color: const Color(0xff1fac9c),
              letterSpacing: 1.596,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback("taped");
        }

        if (route != null) {
          if (pop != null && pop == true) {
            Navigator.pop(context);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        }
      },
    );
  }
}
