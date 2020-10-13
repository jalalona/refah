import 'package:flutter/material.dart';

class WDG_BorderedGrayButton extends StatelessWidget {
  double width = 300.0;
  String text = "لینک";
  Widget route;

  WDG_BorderedGrayButton({
    this.route,
    this.text = "لینک",
    this.width = 300,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(top: 10.0),
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.0),
          border: Border.all(width: 1.0, color: const Color(0xffd6d6d6)),
        ),
        child: Container(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        if (route != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => route,
              ));
        }
      },
    );
  }
}
