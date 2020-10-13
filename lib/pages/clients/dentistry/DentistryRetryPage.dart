import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refah/Provider/SignalR.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/pages/ProccessSuccessPage.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_CustomBanner.dart';
import 'package:refah/widgets/WDG_DateTimeInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_PersianDateTimeInput.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';
import 'package:refah/widgets/WDG_UploadImageInput.dart';
import 'package:url_launcher/url_launcher.dart';

class DentistryRetryPage extends StatefulWidget {
  String title;
  String description;
  EnrollVM enroll;

  Widget content;

  DentistryRetryPage({
    this.description,
    this.title,
    this.enroll,
  });

  @override
  _DentistryRetryPageState createState() => _DentistryRetryPageState();
}

class _DentistryRetryPageState extends State<DentistryRetryPage>
    with WidgetsBindingObserver {
  int isValid = 0;
  OrderVM activeOrder;
  bool vis = false;
  //EnrollVM enroll = EnrollVM();
  File file;
  String cost = "0 ریال";
  SignalR signalr;

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

  Future initCost() async {
    setState(() {
      vis = true;
    });
    var res = await OptionService().getByName("dentist_retry_cost");

    if (res != null) {
      setState(() {
        cost = res.value + " ریال";
      });
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

  Future verifyPayment(OrderVM order) async {
    setState(() {
      vis = true;
    });
    var verify = await EnrollService().Verify(order.authority);

    if (verify != null &&
        verify.data != null &&
        (verify.data.code == 100 || verify.data.code == 101)) {
      activeOrder = null;

      var admin = await OptionService().getByName("aid");
      signalr.sendMessage(
        admin.value,
        order.id,
        ChatMessage(
          senderName: ProfileService().getUserData().fullname,
          senderAvatar: ProfileService().getUserData().avatar,
          message: "تمدید بیمه دندانپزشکی با موفقیت انجام و پرداخت شد",
          id: order.id,
        ),
      );

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    signalr = SignalR(context);

    initCost();
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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: 75.0,
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
                            value: widget.enroll.fullname ?? "",
                            enabled: false,
                            hintText: "نام و نام خانوادگی",
                            onChangeCallback: (result) {
                              //enroll.fullname = result;
                            },
                          ),
                          WDG_BorderedTextInput(
                            isRequired: true,
                            onErrorCallback: (error) {
                              isValid = error;
                            },
                            enabled: false,
                            value: widget.enroll.identityNumber ?? "",
                            hintText: "شماره شناسنامه",
                            inputType: TextInputType.number,
                            onChangeCallback: (result) {
                              //enroll.identityNumber = result;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: WDG_SizedBorderedTextInput(
                                  isRequired: true,
                                  onErrorCallback: (error) {
                                    isValid = error;
                                  },
                                  enabled: false,
                                  value: widget.enroll.nationalId ?? "",
                                  max: 10,
                                  hintText: "کد ملی",
                                  inputType: TextInputType.number,
                                  onChangeCallback: (result) {
                                    //enroll.nationalId = result;
                                  },
                                ),
                              ),
                              Expanded(
                                child: WDG_SizedBorderedTextInput(
                                  isRequired: true,
                                  onErrorCallback: (error) {
                                    isValid = error;
                                  },
                                  max: 11,
                                  enabled: false,
                                  value: widget.enroll.systemTag ?? "",
                                  hintText: "شماره موبایل",
                                  inputType: TextInputType.phone,
                                  onChangeCallback: (result) {
                                    //enroll.systemTag = result;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: WDG_PersianDateTimeInput(
                                  hint: "",
                                  birthday: true,
                                  value: widget.enroll.birthday ?? "",
                                  enabled: false,
                                  onChangeCallback: (result) {
                                    //enroll.birthday = result.toString();
                                  },
                                ),
                              ),
                              // Expanded(
                              //   child: WDG_BorderedTextInput(
                              //     isRequired: true,
                              //     onErrorCallback: (error) {
                              //       isValid = error;
                              //     },
                              //     value: enroll.birthday ?? "",
                              //     hintText: "تاریخ تولد",
                              //     inputType: TextInputType.datetime,
                              //     onChangeCallback: (result) {
                              //       enroll.birthday = result;
                              //     },
                              //   ),
                              // ),
                              Expanded(
                                child: WDG_BorderedTextInput(
                                  //isRequired: true,
                                  onErrorCallback: (error) {
                                    isValid = error;
                                  },
                                  value: widget.enroll.fatherName ?? "",
                                  enabled: false,
                                  hintText: "نام پدر",
                                  inputType: TextInputType.text,
                                  onChangeCallback: (result) {
                                    //enroll.fatherName = result;
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
                            enabled: false,
                            value: widget.enroll.homePhone ?? "",
                            hintText: "شماره تلفن منزل",
                            inputType: TextInputType.phone,
                            onChangeCallback: (result) {
                              //enroll.homePhone = result;
                            },
                          ),
                          WDG_BorderedTextInput(
                            //isRequired: true,
                            onErrorCallback: (error) {
                              isValid = error;
                            },
                            enabled: false,
                            value: widget.enroll.address ?? "",
                            hintText: "آدرس",
                            onChangeCallback: (result) {
                              //enroll.address = result;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          WDG_CustomBanner(
                            url: widget.enroll?.avatar,
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    cost,
                                    style: TextStyle(
                                      fontFamily: "IRANSans",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "هزینه تمدید",
                                    style: TextStyle(
                                      fontFamily: "IRANSans",
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: SvgPicture.asset("images/doshed.svg"),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    cost,
                                    style: TextStyle(
                                      fontFamily: "IRANSans",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "جمع کل",
                                    style: TextStyle(
                                      fontFamily: "IRANSans",
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(""),
                    ),
                    WDG_FooterConfirmCancel(
                      confirmTitle: "پرداخت",
                      //confirmRoute: ProccessSuccessPage(),
                      confirmCallback: (result) async {
                        setState(() {
                          vis = true;
                        });
                        widget.enroll.id = 0;
                        widget.enroll.enrollType = "dentist";
                        widget.enroll.startTime = DateTime(
                          widget.enroll.expireTime.year,
                          widget.enroll.expireTime.month,
                          widget.enroll.expireTime.day,
                        );
                        widget.enroll.expireTime = widget.enroll.startTime.add(
                          Duration(days: 365),
                        );

                        widget.enroll.enrollOrders = null;
                        var res = await EnrollService().add(widget.enroll);

                        if (res != null) {
                          EnrollService().setMyEnroll(res);
                          var result = await EnrollService().Payment(true);

                          if (result != null &&
                              result.authority != null &&
                              result.authority.isNotEmpty) {}
                          try {
                            activeOrder = result;
                            var url = "https://next.zarinpal.com/pg/StartPay/" +
                                result.authority;
                            await _launchURL(url);
                          } catch (e) {}
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProccessSuccessPage(),
                          //   ),
                          // );
                        }
                        setState(() {
                          vis = false;
                        });
                      },
                      cancelRoute: ClientHomePage(),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
