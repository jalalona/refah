import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/services/UserService.dart';
import './WDG_SmallEditIcon.dart';
import './WDG_SmallDeleteIcon.dart';
import 'WDG_SmallUploadIcon.dart';

class WDG_BusinessOfficeItem extends StatelessWidget {
  UserVM obj;
  Widget route;
  Function(dynamic result) onTapCallback;
  dynamic param;
  Widget deleteRoute;
  Widget editRoute;
  Function(dynamic result) deleteOnTapCallback;
  Function(dynamic result) editOnTapCallback;
  dynamic deleteParam;
  dynamic editParam;

  WDG_BusinessOfficeItem({
    this.obj,
    this.onTapCallback,
    this.param,
    this.route,
    this.deleteOnTapCallback,
    this.deleteParam,
    this.deleteRoute,
    this.editOnTapCallback,
    this.editParam,
    this.editRoute,
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
                    WDG_SmallEditIcon(
                      onTapCallback: (result) {
                        if (editOnTapCallback != null) {
                          editOnTapCallback(editParam);
                        }
                      },
                      route: editRoute,
                      param: editParam,
                    ),
                    WDG_SmallDeleteIcon(
                      onTapCallback: (result) {
                        if (deleteOnTapCallback != null) {
                          deleteOnTapCallback(deleteParam);
                        }
                      },
                      route: deleteRoute,
                      param: deleteParam,
                    ),
                    WDG_SmallUploadIcon(
                      onTapCallback: (result) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'انتخاب',
                          desc: 'منبع تصویر مورد نظر شما',
                          btnOkText: "دوربین",
                          btnCancelText: "گالری",
                          btnCancelOnPress: () async {
                            var res = await UserService()
                                .getImageFromGallery(obj.id ?? 0, "");
                            if (onTapCallback != null) {
                              onTapCallback(param);
                            }
                          },
                          btnOkOnPress: () async {
                            var res = await UserService()
                                .getImageFromCamera(obj.id ?? 0, "");

                            if (onTapCallback != null) {
                              onTapCallback(param);
                            }
                          },
                        )..show();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    obj?.officeName ?? 'عنوان خدمت',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 14,
                      color: const Color(0xff404040),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    obj?.bio ?? 'متن مقدار',
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
