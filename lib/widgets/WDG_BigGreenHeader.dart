import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_BigGreenHeader extends StatelessWidget {
  WDG_BigGreenHeader({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SvgPicture.string(
          _svg_2kvdq8,
          allowDrawingOutsideViewBox: true,
        ),
      ],
    );
  }
}

const String _svg_2kvdq8 =
    '<svg viewBox="0.0 0.0 375.0 226.0" ><path transform="translate(0.02, -28.0)" d="M 375 28.03125 L 375 230 C 375 243.2548370361328 364.2548217773438 254 351 254 L 24 254 C 10.74516487121582 254 0 243.2548370361328 0 230 L -0.015625 28 L 375 28.03125 Z" fill="#1fac9c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
