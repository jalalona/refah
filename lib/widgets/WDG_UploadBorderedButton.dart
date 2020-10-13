import 'dart:io';

import 'package:flutter/material.dart';

class WDG_UploadBorderedButton extends StatefulWidget {
  String title;
  Widget route;
  Function(dynamic result) onTapCallback;
  dynamic param;

  WDG_UploadBorderedButton({
    this.onTapCallback,
    this.param,
    this.route,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  _WDG_UploadBorderedButtonState createState() =>
      _WDG_UploadBorderedButtonState();
}

class _WDG_UploadBorderedButtonState extends State<WDG_UploadBorderedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(5.0),
        width: 75.0,
        height: 33.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(width: 1.0, color: const Color(0xff1fac9c)),
        ),
        child: Center(
          child: Container(
            child: Text(
              widget.title ?? 'بارگزاری',
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 10,
                color: const Color(0xff1fac9c),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      onTap: () async {
        if (widget.onTapCallback != null) {
          widget.onTapCallback(widget.param);
        }

        if (widget.route != null) {
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
