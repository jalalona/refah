import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/UserService.dart';
import './WDG_UploadBorderedButton.dart';

class WDG_UploadBorderedInput extends StatefulWidget {
  bool isRequired;
  String fileName;
  Widget route;
  Function(dynamic result) onTapCallback;
  Function(int error) onErrorCallback;
  String tableName;

  dynamic param;

  EnrollVM obj;
  String baseName;
  String parameter;
  String property;
  List<QueryModel> queries;
  Function(dynamic result) onUploadComplatedCallback;

  WDG_UploadBorderedInput({
    this.onTapCallback,
    this.property,
    this.param,
    this.route,
    this.fileName,
    this.baseName,
    this.obj,
    this.onUploadComplatedCallback,
    this.parameter,
    this.queries,
    this.isRequired,
    this.onErrorCallback,
    this.tableName,
    Key key,
  }) : super(key: key);

  @override
  _WDG_UploadBorderedInputState createState() =>
      _WDG_UploadBorderedInputState();
}

class _WDG_UploadBorderedInputState extends State<WDG_UploadBorderedInput> {
  bool isValid;
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

    if (widget.isRequired != null && widget.isRequired == true) {
      if (widget.onErrorCallback != null) {
        widget.onErrorCallback(1);
      }
    }

    if (widget.fileName != null && widget.fileName.isNotEmpty) {
      setState(() {
        title = Text(
          widget.fileName,
          style: TextStyle(
            fontFamily: 'IRANSans',
            fontSize: 13,
            color: const Color(0xff898a8f),
          ),
          textAlign: TextAlign.right,
        );
      });
    }
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
        border: Border.all(
          width: 1.0,
          color: isValid != null && isValid == false
              ? Colors.red
              : Color(0xffd6d6d6),
        ),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            WDG_UploadBorderedButton(
              route: widget.route,
              onTapCallback: (result) async {
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
                      setState(() {
                        vis = true;
                      });
                      try {
                        File res;

                        if (widget.tableName != null &&
                            widget.tableName == "user") {
                          res = await UserService().getImageFromGallery(
                              widget.obj.id ?? 0, widget.property ?? "");
                        } else {
                          res = await EnrollService().getImageFromGallery(
                              widget.obj.id ?? 0, widget.property ?? "");
                        }

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

                        if (widget.isRequired != null &&
                            widget.isRequired == true &&
                            res == null) {
                          if (widget.onErrorCallback != null) {
                            widget.onErrorCallback(1);
                            setState(() {
                              isValid = false;
                            });
                          }
                        } else {
                          widget.onErrorCallback(0);
                          setState(() {
                            isValid = true;
                          });
                        }
                      } catch (e) {}

                      setState(() {
                        vis = false;
                      });
                    },
                    btnOkOnPress: () async {
                      setState(() {
                        vis = true;
                      });

                      File res;

                      if (widget.tableName != null &&
                          widget.tableName == "user") {
                        res = await UserService().getImageFromGallery(
                            widget.obj.id ?? 0, widget.property ?? "");
                      } else {
                        res = await EnrollService().getImageFromGallery(
                            widget.obj.id ?? 0, widget.property ?? "");
                      }

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

                      if (widget.isRequired != null &&
                          widget.isRequired == true &&
                          res == null) {
                        if (widget.onErrorCallback != null) {
                          widget.onErrorCallback(1);
                          setState(() {
                            isValid = false;
                          });
                        }
                      } else {
                        widget.onErrorCallback(0);
                        setState(() {
                          isValid = true;
                        });
                      }
                      setState(() {
                        vis = false;
                      });
                    },
                  )..show();

                  if (widget.onUploadComplatedCallback != null) {
                    widget.onUploadComplatedCallback(result);
                  }
                }
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
