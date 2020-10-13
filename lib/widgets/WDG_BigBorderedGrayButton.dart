import 'package:flutter/material.dart';
import 'package:adobe_xd/page_link.dart';

class WDG_BigBorderedGrayButton extends StatelessWidget {
  double width = 300.0;
  String text = "لینک";
  Widget route;
  Color color;
  Function(dynamic result) onTapCallback;

  WDG_BigBorderedGrayButton({
    this.onTapCallback,
    this.width = 300.0,
    this.color,
    this.route,
    this.text,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(top: 12.5),
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffececec)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0d000000),
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Container(
          child: Text(
            text ?? "لینک",
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 14,
              color: color ?? const Color(0xff313450),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        if (route != null) {
          //Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => route,
              ));
        }

        if (onTapCallback != null) {
          onTapCallback("tap");
        }
      },
    );
  }
}
