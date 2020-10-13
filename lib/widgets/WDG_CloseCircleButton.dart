import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_CloseCircleButton extends StatelessWidget {
  Widget route;
  Function(String result) onTapCallback;

  WDG_CloseCircleButton({
    this.onTapCallback,
    this.route,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 51.0,
        height: 51.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: const Color(0xe0ffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x24000000),
              offset: Offset(0, 0),
              blurRadius: 24,
            ),
          ],
        ),
        child: Container(
          child: Stack(
            children: <Widget>[
              Transform(
                transform: Matrix4(
                    0.707107,
                    0.707107,
                    0.0,
                    0.0,
                    -0.707107,
                    0.707107,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    1.0,
                    0.0,
                    25.42,
                    11.88,
                    0.0,
                    1.0),
                child: Stack(
                  children: <Widget>[
                    SvgPicture.string(
                      _svg_d13dzh,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        }

        if (onTapCallback != null) {
          onTapCallback("result");
        }
      },
    );
  }
}

const String _svg_d13dzh =
    '<svg viewBox="0.0 0.0 20.3 20.3" ><path transform="translate(10.08, 0.0)" d="M 0.1154846176505089 0 L 0 20.26845932006836" fill="none" stroke="#1fac9c" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /><path transform="matrix(0.0, 1.0, -1.0, 0.0, 20.27, 10.08)" d="M 0.1154938638210297 0 L 0 20.26846122741699" fill="none" stroke="#1fac9c" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
