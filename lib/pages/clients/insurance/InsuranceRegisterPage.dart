import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/Provider/Encryption.dart';
import 'package:refah/Provider/QuestionProvider.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/AnswerPackageVM.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/pages/clients/insurance/ClientInsuranceQuestionPage.dart';
import 'package:refah/pages/clients/insurance/InsuranceUploadPage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_DateTimeInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_PersianDateTimeInput.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';
import 'package:refah/widgets/WDG_TwoLableBorderedTextInput.dart';

class InsuranceRegisterPage extends StatefulWidget {
  EnrollVM enroll = EnrollVM();
  String title;
  String description;

  Widget content;

  InsuranceRegisterPage({
    this.description,
    this.title,
  });

  @override
  _InsuranceRegisterPageState createState() => _InsuranceRegisterPageState();
}

class _InsuranceRegisterPageState extends State<InsuranceRegisterPage> {
  int isValid = 0;
  bool vis = false;
  List<WDG_QuestionItem> questionItems = List<WDG_QuestionItem>();
  String insuranceWarningText = "";
  Future initWarning() async {
    var optw = await OptionService().getByName("insurance_warning");

    if (optw != null) {
      setState(() {
        insuranceWarningText = optw.value;
      });
    }
  }

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => ClientHomePage(),
    //   ),
    // );

    return false;
  }

  @override
  void initState() {
    super.initState();

    initWarning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    top: 50.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 25.0,
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
                      Container(
                        child: Text(
                          insuranceWarningText,
                          style: TextStyle(
                            fontFamily: "IRANSans",
                            color: Colors.deepOrange,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.enroll?.fullname ?? "",
                        hintText: "نام و نام خانوادگی",
                        onChangeCallback: (result) {
                          widget.enroll.fullname = result;
                        },
                      ),
                      WDG_SizedBorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.enroll?.nationalId ?? "",
                        max: 10,
                        hintText: "کد ملی",
                        inputType: TextInputType.number,
                        onChangeCallback: (result) {
                          widget.enroll.nationalId = result;
                        },
                      ),
                      WDG_SizedBorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.enroll?.systemTag ?? "",
                        max: 11,
                        hintText: "شماره موبایل",
                        inputType: TextInputType.number,
                        onChangeCallback: (result) {
                          widget.enroll.systemTag = result;
                        },
                      ),
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.enroll?.identityNumber ?? "",
                        hintText: "شماره شناسنامه",
                        inputType: TextInputType.number,
                        onChangeCallback: (result) {
                          widget.enroll.identityNumber = result;
                        },
                      ),
                      WDG_PersianDateTimeInput(
                        hint: "",
                        birthday: true,
                        value: widget.enroll.birthday ?? "",
                        onChangeCallback: (result) {
                          widget.enroll.birthday = result.toString();
                        },
                      ),
                      // WDG_BorderedTextInput(
                      //   isRequired: true,
                      //   onErrorCallback: (error) {
                      //     isValid = error;
                      //   },
                      //   value: widget.enroll?.birthday ?? "",
                      //   hintText: "تاریخ تولد",
                      //   inputType: TextInputType.datetime,
                      //   onChangeCallback: (result) {
                      //     widget.enroll.birthday = result;
                      //   },
                      // ),
                      WDG_BorderedTextInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.enroll?.fatherName ?? "",
                        hintText: "نام پدر",
                        onChangeCallback: (result) {
                          widget.enroll.fatherName = result;
                        },
                      ),
                      WDG_SizedBorderedTextInput(
                        max: 11,
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.enroll?.homePhone ?? "",
                        hintText: "شماره تلفن",
                        inputType: TextInputType.phone,
                        onChangeCallback: (result) {
                          widget.enroll.homePhone = result;
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
                              value: widget.enroll?.tall?.toString() ?? "",
                              hintText: "قد",
                              inputType: TextInputType.number,
                              onChangeCallback: (result) {
                                widget.enroll.tall = int.parse(result);
                              },
                            ),
                          ),
                          Expanded(
                            child: WDG_BorderedTextInput(
                              //isRequired: true,
                              onErrorCallback: (error) {
                                isValid = error;
                              },
                              value: widget.enroll?.weight?.toString() ?? "",
                              hintText: "وزن",
                              inputType: TextInputType.number,
                              onChangeCallback: (result) {
                                widget.enroll.weight = int.parse(result);
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
                        value: widget.enroll?.address ?? "",
                        hintText: "آدرس",
                        onChangeCallback: (result) {
                          widget.enroll.address = result;
                        },
                      ),
                      EnrollService().getMyEnrolls().length < 1
                          ? WDG_TwoLableBorderedTextInput(
                              isRequired: true,
                              onErrorCallback: (error) {
                                isValid = error;
                              },
                              value: widget.enroll?.irBank ?? "",
                              hintText: "",
                              leftText: "IR",
                              rightText: "شباء",
                              onChangeCallback: (result) {
                                widget.enroll.irBank = result;
                              },
                            )
                          : Text(""),
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
                    ],
                  ),
                ),
                WDG_FooterConfirmCancel(
                  pop: true,
                  //confirmRoute: InsuranceUploadPage(),
                  confirmCallback: (result) async {
                    if (isValid > 0) return;
                    setState(() {
                      vis = true;
                    });
                    var data = AnswerPackageVM(
                      answers: QuestionProvider().getAnswers(),
                    );

                    var ids = data.answers.map((e) => e.answerId).toList();
                    String sids = "";
                    ids.forEach((element) {
                      sids += element.toString();
                    });
                    widget.enroll.enrollType = "insurance";
                    widget.enroll.startTime = DateTime.now();
                    widget.enroll.expireTime = widget.enroll.startTime.add(
                      Duration(days: 365),
                    );
                    widget.enroll.systemCategory = jsonEncode(sids);
                    var res = await EnrollService().add(widget.enroll);

                    if (res != null) {
                      EnrollService().setMyEnroll(res);
                      var prf = ProfileService().getUserData();
                      if (prf != null && res.nationalId == prf.nationalId) {
                        prf.address = res.address;
                        prf.birthday = res.birthday;
                        prf.fatherName = res.fatherName;
                        prf.fullname = res.fullname;
                        prf.homePhone = res.homePhone;
                        prf.identityNumber = res.identityNumber;
                        prf.irBank = res.irBank;
                        prf.tall = res.tall;
                        prf.weight = res.weight;

                        var rs = await ProfileService().updateUserData(prf);
                      }

                      //Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InsuranceUploadPage(
                            obj: res,
                          ),
                        ),
                      );
                    }
                    setState(() {
                      vis = false;
                    });
                  },
                  cancelRoute: ClientInsuranceQuestionPage(),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
