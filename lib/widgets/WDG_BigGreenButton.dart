import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_BigGreenButton extends StatefulWidget {
  Color backColor;
  Color textColor;
  String text;
  Function(dynamic result) onTapCallback;
  Widget route;
  double width;
  bool pop;

  WDG_BigGreenButton({
    this.backColor,
    this.onTapCallback,
    this.route,
    this.text,
    this.textColor,
    this.width,
    this.pop,
    Key key,
  }) : super(key: key);

  @override
  _WDG_BigGreenButtonState createState() => _WDG_BigGreenButtonState();
}

class _WDG_BigGreenButtonState extends State<WDG_BigGreenButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.width ?? 250.0,
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: widget.backColor ?? const Color(0xff1fac9c),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            widget.text ?? "دکمه",
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 14,
              color: widget.textColor ?? const Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        if (widget.route != null) {
          if (widget.pop != null && widget.pop == true) {
            Navigator.pop(context);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.route,
            ),
          );
        }

        if (widget.onTapCallback != null) {
          widget.onTapCallback("taped");
        }
      },
    );
  }
}

const String _svg_d1r0t9 =
    '<svg viewBox="0.0 0.0 292.6 46.0" ><path  d="M 23 0 L 269.60009765625 0 C 282.3026428222656 0 292.60009765625 10.29745101928711 292.60009765625 23 C 292.60009765625 35.70254898071289 282.3026428222656 46 269.60009765625 46 L 23 46 C 10.29745101928711 46 0 35.70254898071289 0 23 C 0 10.29745101928711 10.29745101928711 0 23 0 Z" fill="#1fac9c" stroke="#ececec" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
