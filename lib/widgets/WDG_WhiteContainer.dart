import 'package:flutter/material.dart';

class WDG_WhiteContainer extends StatelessWidget {
  String title;
  Widget content;

  WDG_WhiteContainer({
    this.title,
    this.content,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 9),
            blurRadius: 38,
          ),
        ],
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: content ?? Text(""),
      ),
    );
  }
}
