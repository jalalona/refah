import 'package:flutter/material.dart';

class WDG_CancelButtonWhite extends StatelessWidget {
  bool pop;
  String cancelTitle;
  String cancelSecondTitle;
  Widget cancelRoute;
  Widget cancelSecondWidget;
  Function(String result) cancelCallback;

  WDG_CancelButtonWhite({
    this.pop,
    this.cancelCallback,
    this.cancelRoute,
    this.cancelTitle,
    this.cancelSecondTitle,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    cancelSecondWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          cancelSecondTitle ?? '',
          style: TextStyle(
            fontFamily: 'IRANSans',
            fontSize: 11,
            color: const Color(0xff313450),
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          cancelTitle ?? 'انصراف',
          style: TextStyle(
            fontFamily: 'IRANSans',
            fontSize: 13,
            color: const Color(0xff313450),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );

    return InkWell(
      child: Container(
        padding: EdgeInsets.all(3.0),
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffc7c7c7)),
        ),
        child: Center(
          child: cancelSecondTitle != null
              ? cancelSecondWidget
              : Text(
                  cancelTitle ?? 'انصراف',
                  style: TextStyle(
                    fontFamily: 'IRANSans',
                    fontSize: 14,
                    color: const Color(0xff313450),
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
      onTap: () {
        if (cancelRoute != null) {
          Navigator.pop(context);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => cancelRoute,
          //   ),
          // );
        }

        if (cancelCallback != null) {
          cancelCallback("tap");
        }
      },
    );
  }
}
