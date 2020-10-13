import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/services/EnrollService.dart';
import 'WDG_UploadBorderedButton.dart';

class WDG_UploadImageInput extends StatefulWidget {
  bool isRequired;
  String fileName;
  Function(File result) onTapCallback;
  Function(int error) onErrorCallback;

  WDG_UploadImageInput({
    this.onTapCallback,
    this.fileName,
    this.isRequired,
    this.onErrorCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_UploadImageInputState createState() => _WDG_UploadImageInputState();
}

class _WDG_UploadImageInputState extends State<WDG_UploadImageInput> {
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
              //route: widget.route,
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
                      var res = await EnrollService().returnImageFromGallery();

                      String pth = res?.path;
                      pth = pth.substring(pth.length - 20, pth.length);
                      setState(() {
                        try {
                          title = Text(
                            pth ?? 'فایل انتخاب شد',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 13,
                              color: const Color(0xff898a8f),
                            ),
                            textAlign: TextAlign.right,
                          );
                        } catch (e) {
                          setState(() {
                            vis = false;
                          });
                        }
                      });
                      if (widget.onTapCallback != null) {
                        widget.onTapCallback(res);
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
                    btnOkOnPress: () async {
                      setState(() {
                        vis = true;
                      });
                      var res = await EnrollService().returnImageFromCamera();

                      String pth = res?.path;
                      pth = pth.substring(pth.length - 20, pth.length);
                      setState(() {
                        try {
                          title = Text(
                            pth ?? 'فایل انتخاب شد',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 13,
                              color: const Color(0xff898a8f),
                            ),
                            textAlign: TextAlign.right,
                          );
                        } catch (e) {
                          setState(() {
                            vis = false;
                          });
                        }
                      });

                      if (widget.onTapCallback != null) {
                        widget.onTapCallback(res);
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
                }
              },
              //param: widget.param,
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
