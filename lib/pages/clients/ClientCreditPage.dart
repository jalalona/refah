import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/OptionVM.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/pages/clients/ClientMessagedUsersPage.dart';
import 'package:refah/pages/clients/dentistry/DentistryRetryPage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BigIconButton.dart';
import 'package:refah/widgets/WDG_BigImageButton.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';
import 'package:refah/widgets/WDG_UploadImageInput.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ProccessSuccessPage.dart';

class ClientCreditPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  ClientCreditPage({
    this.description,
    this.title,
  });

  @override
  _ClientCreditPageState createState() => _ClientCreditPageState();
}

class _ClientCreditPageState extends State<ClientCreditPage>
    with WidgetsBindingObserver {
  bool vis = false;
  int isValid = 0;
  UserVM obj = ProfileService().getUserData();
  OptionVM retry = null;
  EnrollVM activeEnroll;
  OrderVM activeOrder;
  String retryCost = "---";
  File file;

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

  Future verifyPayment(OrderVM order) async {
    setState(() {
      vis = true;
    });
    var verify = await EnrollService().Verify(order.authority);

    if (verify != null &&
        verify.data != null &&
        (verify.data.code == 100 || verify.data.code == 101)) {
      activeOrder = null;
      EnrollService().clearMyEnrolls();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProccessSuccessPage(response: verify),
        ),
      );
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        title: "پرداخت نا موفق",
        desc: "پرداخت شما موفقیت انجام نشد.",
        btnOkText: "ممنون",
        btnOkOnPress: () async {},
      )..show();
    }
    setState(() {
      vis = false;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //throw 'Could not launch $url';
    }
  }

  Future initRetry() async {
    var enroll = await EnrollService().getMyActiveEnroll();
    if (enroll != null) {
      activeEnroll = enroll;
      retry = await OptionService().getByName("dentist_retry_cost");

      setState(() {
        retryCost = retry?.value ?? "0";
        retryCost += " ریال";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    initRetry();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (activeOrder != null) {
        verifyPayment(activeOrder);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
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
                  Container(
                    height: 120.0,
                    margin: EdgeInsets.only(top: 20.0),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        WDG_BigIconButton(
                          title: "چت",
                          description: "چت کنید",
                          descriptionColor: Colors.white,
                          icon: Image.asset(
                            "images/familyinsurance.png",
                          ),
                          route: ClientMessagedUsersPage(),
                        ),
                        EnrollService().calculateCredit() != null
                            ? WDG_BigIconButton(
                                title: "تمدید اعتبار",
                                description: retryCost ?? "---",
                                descriptionColor: Colors.white,
                                icon: Image.asset(
                                  "images/familyinsurance.png",
                                ),
                                onTapCallback: (result) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DentistryRetryPage(
                                        enroll: activeEnroll,
                                      ),
                                    ),
                                  );
                                  // setState(() {
                                  //   vis = true;
                                  // });
                                  // var newEnroll = activeEnroll;

                                  // newEnroll.id = 0;
                                  // newEnroll.enrollType = "dentist";
                                  // newEnroll.startTime = activeEnroll.expireTime;
                                  // newEnroll.expireTime =
                                  //     activeEnroll.expireTime.add(
                                  //   Duration(days: 365),
                                  // );
                                  // newEnroll.enrollOrders = null;
                                  // var res = await EnrollService().add(newEnroll);

                                  // if (res != null) {
                                  //   EnrollService().setMyEnroll(res);
                                  //   var result =
                                  //       await EnrollService().Payment(true);

                                  //   if (result != null &&
                                  //       result.authority != null &&
                                  //       result.authority.isNotEmpty) {}
                                  //   try {
                                  //     activeOrder = result;
                                  //     var url =
                                  //         "https://next.zarinpal.com/pg/StartPay/" +
                                  //             result.authority;
                                  //     await _launchURL(url);
                                  //   } catch (e) {}
                                  // }
                                  // setState(() {
                                  //   vis = false;
                                  // });
                                },
                              )
                            : Text(""),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(""),
                        ),
                        WDG_BigImageButton(
                          title: obj?.fullname ?? "نام",
                          description: "پروفایل کاربری",
                          descriptionColor: Colors.white,
                          icon: obj?.avatar != null && obj?.avatar.isNotEmpty
                              ? NetworkImage("https://api.refahandishanco.ir" +
                                  obj?.avatar)
                              : null,
                          //route: DentistryContract(),
                        ),
                        // WDG_BigIconButton(
                        //   //title: expirationDay ?? "بدون اعتبار",
                        //   description: "اعتبار به روز",
                        //   icon: Image.asset("images/cards.png"),
                        //   route: ClientCreditPage(),
                        // ),
                        // WDG_BigIconButton(
                        //   description: "مراکز تحت قرارداد",
                        //   title: "تخفیف",
                        //   icon: Image.asset("images/priceoffer.png"),
                        //   //route: ClientOfferPage(),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: 25.0,
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
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          WDG_UploadImageInput(
                            //isRequired: true,
                            onErrorCallback: (error) {
                              isValid = error;
                            },
                            fileName: "عکس پرسنلی",
                            onTapCallback: (result) async {
                              setState(() {
                                vis = true;
                              });
                              file = result;

                              var ava = await UserService()
                                  .uploadFile(file, obj.id, "avatar");
                              if (ava != null) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.SCALE,
                                  title: "بارگزاری",
                                  desc:
                                      "تصویر پروفایل شما با موفقیت بارگزاری شد",
                                  btnOkText: "ممنون",
                                  btnOkOnPress: () async {},
                                )..show();
                              }
                              var usr = await ProfileService()
                                  .CheckUser(obj.nationalId, obj.phoneNumber);

                              setState(() {
                                obj = ProfileService().getUserData();
                              });

                              setState(() {
                                vis = false;
                              });
                            },
                          ),
                          WDG_BorderedTextInput(
                            enabled: false,
                            value: obj?.fullname ?? "",
                            hintText: "نام و نام خانوادگی",
                            onChangeCallback: (result) {
                              obj.fullname = result;
                            },
                          ),
                          WDG_BorderedTextInput(
                            enabled: false,
                            value: obj.address ?? "",
                            hintText: "آدرس پستی",
                            inputType: TextInputType.text,
                            onChangeCallback: (result) {
                              obj.address = result;
                            },
                          ),
                          WDG_SizedBorderedTextInput(
                            value: obj.nationalId ?? "",
                            hintText: "کد ملی",
                            max: 10,
                            enabled: false,
                            inputType: TextInputType.text,
                            onChangeCallback: (result) {
                              obj.nationalId = result;
                            },
                          ),
                          WDG_BorderedTextInput(
                            enabled: false,
                            value: obj.homePhone ?? "",
                            hintText: "شماره تلفن",
                            inputType: TextInputType.text,
                            onChangeCallback: (result) {
                              obj.homePhone = result;
                            },
                          ),
                          WDG_BorderedTextInput(
                            enabled: false,
                            value: obj.irBank ?? "",
                            hintText: "شماره شباء",
                            inputType: TextInputType.text,
                            onChangeCallback: (result) {
                              obj.irBank = result;
                            },
                          ),
                          WDG_BorderedTextInput(
                            enabled: false,
                            value: obj.phoneNumber ?? "",
                            hintText: "شماره همراه",
                            inputType: TextInputType.text,
                            onChangeCallback: (result) {
                              obj.phoneNumber = result;
                            },
                          ),
                          // WDG_BorderedTextInput(
                          //   enabled: false,
                          //   value: obj.userName ?? "",
                          //   hintText: "نام کاربری",
                          //   inputType: TextInputType.text,
                          //   onChangeCallback: (result) {
                          //     obj.userName = result;
                          //   },
                          // ),
                          // WDG_BorderedTextInput(
                          //   enabled: false,
                          //   value: obj.homePhone ?? "",
                          //   hintText: "تلفن منزل",
                          //   inputType: TextInputType.phone,
                          //   onChangeCallback: (result) {
                          //     obj.homePhone = result;
                          //   },
                          // ),
                          // WDG_BorderedTextInput(
                          //   value: obj.birthday ?? "",
                          //   enabled: false,
                          //   hintText: "تاریخ تولد",
                          //   inputType: TextInputType.datetime,
                          //   onChangeCallback: (result) {
                          //     obj.birthday = result;
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // WDG_FooterConfirmCancel(
                  //   confirmTitle: "بروزرسانی",
                  //   cancelTitle: "انصراف",
                  //   //confirmRoute: AdminDoctorsPage(),
                  //   confirmCallback: (result) async {
                  //     setState(() {
                  //       vis = true;
                  //     });
                  //     if (isValid > 0) return;
                  //     //obj.status = "partner";
                  //     var res = await UserService().update(obj);
                  //     // if (res) {
                  //     //   Navigator.pop(context);
                  //     // }
                  //     setState(() {
                  //       vis = false;
                  //     });
                  //   },
                  //   cancelRoute: ClientMessagedUsersPage(),
                  // ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
