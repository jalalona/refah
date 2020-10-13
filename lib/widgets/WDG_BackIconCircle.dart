import 'package:flutter/material.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_BackIconCircle extends StatefulWidget {
  Widget route;
  bool pop;

  WDG_BackIconCircle({
    this.route,
    this.pop,
    Key key,
  }) : super(key: key);

  @override
  _WDG_BackIconCircleState createState() => _WDG_BackIconCircleState();
}

class _WDG_BackIconCircleState extends State<WDG_BackIconCircle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.0),
          color: const Color(0xff1fac9c),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            "images/backarrow.svg",
            width: 15.0,
            fit: BoxFit.scaleDown,
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
      },
    );
  }
}
