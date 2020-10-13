import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_EditIcon extends StatelessWidget {
  Widget route;
  Function(dynamic result) onTapCallback;
  dynamic param;

  WDG_EditIcon({
    this.onTapCallback,
    this.param,
    this.route,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(18.0, 18.0)),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffe6e6e6)),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: SvgPicture.asset("images/edit.svg"),
        ),
      ),
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        }

        if (onTapCallback != null) {
          onTapCallback(param);
        }
      },
    );
  }
}
