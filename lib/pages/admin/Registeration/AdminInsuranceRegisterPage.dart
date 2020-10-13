import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/Provider/Encryption.dart';
import 'package:refah/Provider/QuestionProvider.dart';
import 'package:refah/models/AnswerPackageVM.dart';
import 'package:refah/models/EnrollMicroVM.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/pages/admin/Registeration/AdminInsuranceUploadPage.dart';
import 'package:refah/pages/clients/insurance/ClientInsuranceQuestionPage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_PersianDateTimeInput.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';
import 'package:refah/widgets/WDG_TwoLableBorderedTextInput.dart';

import '../AdminPanelPage.dart';

class AdminInsuranceRegisterPage extends StatefulWidget {
  EnrollVM obj = EnrollVM();
  String title;
  String description;

  Widget content;

  AdminInsuranceRegisterPage({
    this.description,
    this.title,
  });

  @override
  _AdminInsuranceRegisterPageState createState() =>
      _AdminInsuranceRegisterPageState();
}

class _AdminInsuranceRegisterPageState
    extends State<AdminInsuranceRegisterPage> {
  int isValid = 0;
  List<WDG_QuestionItem> questionItems = List<WDG_QuestionItem>();

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminPanelPage(),
    //   ),
    // );

    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: 50.0,
                  left: 10.0,
                  right: 10.0,
                  bottom: 50.0,
                ),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 9),
                      blurRadius: 38,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    WDG_BorderedTextInput(
                      isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.fullname ?? "",
                      hintText: "نام و نام خانوادگی",
                      onChangeCallback: (result) {
                        widget.obj.fullname = result;
                      },
                    ),
                    WDG_SizedBorderedTextInput(
                      isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.nationalId ?? "",
                      max: 10,
                      hintText: "کد ملی",
                      inputType: TextInputType.number,
                      onChangeCallback: (result) {
                        widget.obj.nationalId = result;
                      },
                    ),
                    WDG_BorderedTextInput(
                      isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.identityNumber ?? "",
                      hintText: "شماره شناسنامه",
                      inputType: TextInputType.number,
                      onChangeCallback: (result) {
                        widget.obj.identityNumber = result;
                      },
                    ),
                    WDG_PersianDateTimeInput(
                      hint: "",
                      birthday: true,
                      value: widget.obj.birthday ?? "",
                      onChangeCallback: (result) {
                        widget.obj.birthday = result.toString();
                      },
                    ),
                    // WDG_BorderedTextInput(
                    //   isRequired: true,
                    //   onErrorCallback: (error) {
                    //     isValid = error;
                    //   },
                    //   value: widget.obj.birthday ?? "",
                    //   hintText: "تاریخ تولد",
                    //   inputType: TextInputType.datetime,
                    //   onChangeCallback: (result) {
                    //     widget.obj.birthday = result;
                    //   },
                    // ),
                    WDG_BorderedTextInput(
                      //isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.fatherName ?? "",
                      hintText: "نام پدر",
                      onChangeCallback: (result) {
                        widget.obj.fatherName = result;
                      },
                    ),
                    WDG_SizedBorderedTextInput(
                      isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      max: 11,
                      value: widget.obj.systemTag ?? "",
                      hintText: "شماره همراه",
                      inputType: TextInputType.phone,
                      onChangeCallback: (result) {
                        widget.obj.systemTag = result;
                      },
                    ),
                    WDG_SizedBorderedTextInput(
                      //isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      max: 11,
                      value: widget.obj.homePhone ?? "",
                      hintText: "شماره تلفن",
                      inputType: TextInputType.phone,
                      onChangeCallback: (result) {
                        widget.obj.homePhone = result;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: WDG_BorderedTextInput(
                            //isRequired: true,
                            onErrorCallback: (error) {
                              isValid = error;
                            },
                            value: widget.obj?.tall?.toString() ?? "",
                            hintText: "قد",
                            inputType: TextInputType.number,
                            onChangeCallback: (result) {
                              widget.obj.tall = int.parse(result);
                            },
                          ),
                        ),
                        Expanded(
                          child: WDG_BorderedTextInput(
                            //isRequired: true,
                            onErrorCallback: (error) {
                              isValid = error;
                            },
                            value: widget.obj?.weight?.toString() ?? "",
                            hintText: "وزن",
                            inputType: TextInputType.number,
                            onChangeCallback: (result) {
                              widget.obj.weight = int.parse(result);
                            },
                          ),
                        ),
                      ],
                    ),
                    WDG_BorderedTextInput(
                      //isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.address ?? "",
                      hintText: "آدرس",
                      onChangeCallback: (result) {
                        widget.obj.address = result;
                      },
                    ),
                    WDG_TwoLableBorderedTextInput(
                      //isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.irBank ?? "",
                      hintText: "",
                      inputType: TextInputType.number,
                      leftText: "IR",
                      rightText: "شباء",
                      onChangeCallback: (result) {
                        widget.obj.irBank = result;
                      },
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              WDG_FooterConfirmCancel(
                pop: true,
                //confirmRoute: InsuranceUploadPage(),
                confirmCallback: (result) async {
                  var data = AnswerPackageVM(
                    answers: QuestionProvider().getAnswers(),
                  );
                  var jsons = data.toJson();
                  widget.obj.enrollType = "insurance";
                  widget.obj.systemTag = Encryption().encryp(jsonEncode(jsons));
                  var res = await EnrollService().add(widget.obj);

                  if (res != null) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminInsuranceUploadPage(
                          obj: res,
                        ),
                      ),
                    );
                  }
                },
                cancelRoute: ClientInsuranceQuestionPage(),
              ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
