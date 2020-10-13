import 'package:flutter/material.dart';

class WDG_ImageTitlebar extends StatelessWidget {
  WDG_ImageTitlebar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(235.49, 0.0),
          child: Container(
            width: 65.1,
            height: 62.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(32.57, 31.0)),
              image: DecorationImage(
                image: const AssetImage(''),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 13.0),
          child: SizedBox(
            width: 225.0,
            height: 19.0,
            child: Text(
              'دکتر رضا تابان',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: const Color(0xff313450),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(1.0, 33.0),
          child: SizedBox(
            width: 223.0,
            height: 16.0,
            child: Text(
              'متخصص دندانپزشکی',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: const Color(0xff898a8f),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
