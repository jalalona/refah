import 'package:flutter/material.dart';
import './WDG_CancelButtonWhite.dart';
import './WDG_ConfirmButtonGreen.dart';

class WDG_FooterConfirmCancel extends StatelessWidget {
  bool pop;
  String cancelTitle;
  String cancelSecondTitle;
  String confirmTitle;
  Widget cancelRoute;
  Widget confirmRoute;
  Function(String result) cancelCallback;
  Function(String result) confirmCallback;

  WDG_FooterConfirmCancel({
    this.pop,
    this.cancelCallback,
    this.cancelRoute,
    this.cancelTitle,
    this.cancelSecondTitle,
    this.confirmCallback,
    this.confirmRoute,
    this.confirmTitle,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 84.0,
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          WDG_CancelButtonWhite(
            pop: pop,
            cancelRoute: cancelRoute,
            cancelCallback: cancelCallback,
            cancelTitle: cancelTitle,
            cancelSecondTitle: cancelSecondTitle,
          ),
          SizedBox(
            width: 10.0,
          ),
          WDG_ConfirmButtonGreen(
            width: MediaQuery.of(context).size.width / 2,
            pop: pop,
            confirmCallback: confirmCallback,
            confirmRoute: confirmRoute,
            confirmTitle: confirmTitle,
          ),
        ],
      ),
    );
  }
}
