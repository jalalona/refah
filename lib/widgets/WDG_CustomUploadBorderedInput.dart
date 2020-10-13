import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/UserSampleService.dart';
import 'WDG_UploadBorderedButton.dart';

class WDG_CustomUploadBorderedInput extends StatefulWidget {
  String fileName;
  Widget route;
  Function(dynamic result) onTapCallback;
  dynamic param;

  EnrollVM obj;
  String baseName;
  String parameter;
  String property;
  int id;
  List<QueryModel> queries;
  Function(dynamic result) onUploadComplatedCallback;

  WDG_CustomUploadBorderedInput({
    this.onTapCallback,
    this.property,
    this.param,
    this.route,
    this.id,
    this.fileName,
    this.baseName,
    this.obj,
    this.onUploadComplatedCallback,
    this.parameter,
    this.queries,
    Key key,
  }) : super(key: key);

  @override
  _WDG_CustomUploadBorderedInputState createState() =>
      _WDG_CustomUploadBorderedInputState();
}

class _WDG_CustomUploadBorderedInputState
    extends State<WDG_CustomUploadBorderedInput> {
  bool vis = false;
  Widget title = Text(
    'فایل',
    style: TextStyle(
      fontFamily: 'IRANSans',
      fontSize: 13,
      color: const Color(0xff898a8f),
    ),
    textAlign: TextAlign.right,
  );

  @override
  void initState() {
    super.initState();

    title = Text(
      widget.fileName ?? 'فایل',
      style: TextStyle(
        fontFamily: 'IRANSans',
        fontSize: 13,
        color: const Color(0xff898a8f),
      ),
      textAlign: TextAlign.right,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: const Color(0xfff6f6f6),
        border: Border.all(width: 1.0, color: const Color(0xffd6d6d6)),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            WDG_UploadBorderedButton(
              route: widget.route,
              onTapCallback: (result) async {
                setState(() {
                  vis = true;
                });
                if (widget.onTapCallback != null) {
                  widget.onTapCallback(result);

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'انتخاب',
                    desc: 'منبع تصویر مورد نظر شما',
                    btnOkText: "دوربین",
                    btnCancelText: "گالری",
                    btnCancelOnPress: () async {
                      var res = await UserSampleService().getImageFromGallery(
                          widget.id ?? 0, widget.property ?? "");

                      if (res != null) {
                        setState(() {
                          title = Text(
                            'با موفقیت اپلود شد',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 13,
                              color: const Color(0xff1fac9c),
                            ),
                            textAlign: TextAlign.right,
                          );
                        });
                      } else {
                        setState(() {
                          title = Text(
                            'خطایی رخ داده ',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 13,
                              color: Colors.redAccent,
                            ),
                            textAlign: TextAlign.right,
                          );
                        });
                      }
                    },
                    btnOkOnPress: () async {
                      var res = await UserSampleService().getImageFromCamera(
                          widget.id ?? 0, widget.property ?? "");

                      if (res != null) {
                        setState(() {
                          title = Text(
                            'با موفقیت اپلود شد',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 13,
                              color: const Color(0xff1fac9c),
                            ),
                            textAlign: TextAlign.right,
                          );
                        });
                      } else {
                        setState(() {
                          title = Text(
                            'خطایی رخ داده ',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 13,
                              color: Colors.redAccent,
                            ),
                            textAlign: TextAlign.right,
                          );
                        });
                      }
                    },
                  )..show();

                  if (widget.onUploadComplatedCallback != null) {
                    widget.onUploadComplatedCallback(result);
                  }
                }
                setState(() {
                  vis = false;
                });
              },
              param: widget.param,
            ),
            Visibility(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              ),
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: vis,
            ),
            Expanded(
              child: title,
            ),
          ],
        ),
      ),
    );
  }
}
