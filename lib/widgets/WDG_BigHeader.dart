import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_BigHeader extends StatelessWidget {
  String text = "عنوان";
  WDG_BigHeader({
    this.text,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/BigHeader.png",
          width: MediaQuery.of(context).size.width,
          height: 400.0,
          fit: BoxFit.fill,
        ),
        Container(
          height: 400.0,
          alignment: Alignment.center,
          child: Center(
            child: Text(
              text ?? "عنوان",
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 50,
                color: const Color(0xffffffff),
                letterSpacing: 5.7,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
