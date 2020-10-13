import 'package:flutter/material.dart';

class WDG_CountryCodeInput extends StatelessWidget {
  bool disable;
  double width;
  Function(String result) callback;
  String text;

  WDG_CountryCodeInput({
    this.disable,
    this.callback,
    this.text = "+98",
    this.width = 55.0,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: width,
      height: 46.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: const Color(0xffececec)),
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'IRANSans',
            fontSize: 14,
            color: const Color(0xff313450),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
