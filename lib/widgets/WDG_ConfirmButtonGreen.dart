import 'package:flutter/material.dart';

class WDG_ConfirmButtonGreen extends StatelessWidget {
  bool pop;
  String confirmTitle;
  double width;
  Widget confirmRoute;
  Function(String result) confirmCallback;

  WDG_ConfirmButtonGreen({
    this.width,
    this.pop,
    this.confirmCallback,
    this.confirmRoute,
    this.confirmTitle,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width ?? 200.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color(0xff1fac9c),
          border: Border.all(
            width: 1.0,
            color: const Color(0xffc7c7c7),
          ),
        ),
        child: Center(
          child: Text(
            confirmTitle ?? 'تائید',
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 14,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        if (confirmCallback != null) {
          confirmCallback("tap");
        }

        if (confirmRoute != null) {
          if (pop != null && pop) {
            Navigator.pop(context);
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => confirmRoute,
            ),
          );
        }
      },
    );
  }
}
