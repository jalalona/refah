import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/models/OptionVM.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_SmallUploadIcon.dart';
import './WDG_SmallEditIcon.dart';
import './WDG_SmallDeleteIcon.dart';

class WDG_BusinessOptionItem extends StatelessWidget {
  OptionVM obj;
  Widget route;
  Function(dynamic result) onTapCallback;
  String property = "value";
  dynamic param;
  Widget deleteRoute;
  Widget editRoute;
  Function(dynamic result) deleteOnTapCallback;
  Function(dynamic result) editOnTapCallback;
  dynamic deleteParam;
  dynamic editParam;

  WDG_BusinessOptionItem({
    this.property = "value",
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
    if (obj != null && obj.value != null) {
      //obj.value =
      //    obj.value.length > 80 ? obj.value.substring(0, 79) : obj.value;
      obj.value = obj.value.replaceAll(RegExp(r"/"), " ");
    }

    return Container(
      height: 70.0,
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
                    obj.type == "banner"
                        ? WDG_SmallUploadIcon(
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
                                  var res = await OptionService()
                                      .getImageFromGallery(
                                          obj.id ?? 0, property ?? "");
                                  if (onTapCallback != null) {
                                    onTapCallback(param);
                                  }
                                },
                                btnOkOnPress: () async {
                                  var res = await OptionService()
                                      .getImageFromCamera(
                                          obj.id ?? 0, property ?? "");

                                  if (onTapCallback != null) {
                                    onTapCallback(param);
                                  }
                                },
                              )..show();
                            },
                          )
                        : Text(""),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      obj?.title ?? 'عنوان خدمت',
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 14,
                        color: const Color(0xff404040),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        obj?.value?.length > 80
                            ? obj.value.substring(0, 79)
                            : obj.value,
                        style: TextStyle(
                          fontFamily: 'IRANSans',
                          fontSize: 10,
                          color: const Color(0xff898a8f),
                        ),
                        textAlign: TextAlign.right,
                        softWrap: true,
                      ),
                    ),
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
