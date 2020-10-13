import 'package:flutter/material.dart';
import 'package:refah/models/EnrollOrderVM.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/OrderVM.dart';

class WDG_ReportUserItem extends StatelessWidget {
  EnrollVM obj;
  OrderVM order;
  EnrollOrderVM pay;

  WDG_ReportUserItem({
    this.obj,
    this.order,
    this.pay,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    // WDG_SmallEditIcon(
                    //   onTapCallback: (result) {
                    //     if (editOnTapCallback != null) {
                    //       editOnTapCallback(editParam);
                    //     }
                    //   },
                    //   route: editRoute,
                    //   param: editParam,
                    // ),
                    // WDG_SmallDeleteIcon(
                    //   onTapCallback: (result) {
                    //     if (deleteOnTapCallback != null) {
                    //       deleteOnTapCallback(deleteParam);
                    //     }
                    //   },
                    //   route: deleteRoute,
                    //   param: deleteParam,
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    obj?.fullname ?? 'نام و نام خانوادگی',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 14,
                      color: const Color(0xff404040),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    obj?.systemTag ?? 'شماره همراه',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 10,
                      color: const Color(0xff898a8f),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_pevntf =
    '<svg viewBox="0.0 52.0 319.0 1.0" ><path transform="translate(-154.0, -4.0)" d="M 154.0000305175781 56 L 472.9989929199219 56" fill="none" stroke="#ececec" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
