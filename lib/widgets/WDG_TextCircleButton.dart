import 'package:flutter/material.dart';
import './WDG_PlusCircleButton.dart';

class WDG_TextCircleButton extends StatelessWidget {
  WDG_TextCircleButton({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(46.88, 6.25),
          child: Text(
            'تنظیمات جدید',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: const Color(0xff404040),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        // Adobe XD layer: 'PlusCircleButton' (component)
        WDG_PlusCircleButton(),
      ],
    );
  }
}
