import 'package:flutter/material.dart';
import 'package:refah/models/UserMessageVM.dart';

import 'WDG_ConfirmIcon.dart';
import 'WDG_EditIcon.dart';
import 'WDG_RejectIcon.dart';

class WDG_AdminUserMessageWidget extends StatelessWidget {
  String originName;
  String targetName;
  String originAvatar;
  String targetAvatar;
  UserMessageVM obj;
  Widget editRoute;
  Widget confirmRoute;
  Widget rejectRoute;
  Function(dynamic result) editOnTapCallback;
  Function(dynamic result) confirmOnTapCallback;
  Function(dynamic result) rejectOnTapCallback;
  dynamic editParam;
  dynamic confirmParam;
  dynamic rejectParam;

  WDG_AdminUserMessageWidget({
    this.confirmOnTapCallback,
    this.confirmParam,
    this.confirmRoute,
    this.editOnTapCallback,
    this.editParam,
    this.editRoute,
    this.obj,
    this.originAvatar,
    this.originName,
    this.rejectOnTapCallback,
    this.rejectParam,
    this.rejectRoute,
    this.targetAvatar,
    this.targetName,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 61.0,
                height: 61.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(30.5, 30.5)),
                  image: DecorationImage(
                    image: targetAvatar != null && targetAvatar.isNotEmpty
                        ? NetworkImage(
                            "https://api.refahandishanco.ir" + targetAvatar)
                        : AssetImage('images/female_avatar.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    targetName ?? 'نام دکتر',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 14,
                      color: const Color(0xff313450),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: 50.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                          width: 0.5, color: const Color(0xffececec)),
                    ),
                    alignment: Alignment.topRight,
                    child: Text(
                      obj.message ?? 'متن پیام',
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 10,
                        color: const Color(0xff898a8f),
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              WDG_EditIcon(
                onTapCallback: editOnTapCallback,
                route: editRoute,
                param: editParam,
              ),
              obj.isActive != null && obj.isActive == false
                  ? Text("")
                  : WDG_RejectIcon(
                      onTapCallback: rejectOnTapCallback,
                      route: rejectRoute,
                      param: rejectParam,
                    ),
              obj.isActive != null && obj.isActive == true
                  ? Text("")
                  : WDG_ConfirmIcon(
                      onTapCallback: confirmOnTapCallback,
                      route: confirmRoute,
                      param: confirmParam,
                    ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(""),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
