import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/Provider/SignalR.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/pages/ProccessSuccessPage.dart';
import 'package:refah/pages/clients/insurance/ClientFamilyInsuranceQuestionPage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedGrayButton.dart';
import 'package:refah/widgets/WDG_FactorItem.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'InsuranceRegisterPage.dart';

class InsuranceFamilyPage extends StatefulWidget {
  String title;
  String description;
  String totalPrice;

  Widget content;

  InsuranceFamilyPage({
    this.description,
    this.title,
    this.totalPrice,
  });

  @override
  _InsuranceFamilyPageState createState() => _InsuranceFamilyPageState();
}

class _InsuranceFamilyPageState extends State<InsuranceFamilyPage>
    with WidgetsBindingObserver {
  int isValid = 0;
  bool vis = false;
  OrderVM activeOrder;
  List<Widget> enrolls = List<Widget>();
  String total = "0";
  SignalR signalr;

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);

    return false;
  }

  initEnrolls() async {
    setState(() {
      vis = true;
    });
    var items = EnrollService().getMyEnrolls();

    var optIO = await OptionService().getByName("insurance_one_cost");
    var priceIO = int.parse(optIO.value);
    var optIF = await OptionService().getByName("insurance_family_cost");
    var priceIF = int.parse(optIF.value);
    // var optIR = await OptionService().getByName("insurance_retry_cost");
    // var priceIR = int.parse(optIR.value);

    if (items != null && items.length > 0) {
      setState(() {
        total = (items.length * priceIF).toString() + " ریال";
      });
    } else {
      setState(() {
        total = (items.length * priceIO).toString() + " ریال";
      });
    }

    if (items != null && items.length > 0) {
      setState(() {
        enrolls = items
            .map((e) => WDG_FactorItem(
                  title: e.fullname,
                  deleteTapCallback: (result) {
                    var del = EnrollService().delete(e);
                    setState(() {
                      //
                    });
                  },
                ))
            .toList();
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
      //EnrollService().clearMyEnrolls();
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

    initEnrolls();
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
        //verifyPayment(activeOrder);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: 75.0,
                      left: 30.0,
                      right: 30.0,
                      bottom: 50.0,
                    ),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 10),
                          blurRadius: 38,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
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
                          margin: EdgeInsets.all(5.0),
                          child: Text(
                            "اعضای خانواده",
                            style: TextStyle(
                              fontFamily: "IRANSans",
                            ),
                          ),
                        ),
                        Container(
                          height: 200.0,
                          child: ListView(
                            children: enrolls,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20.0),
                          child: WDG_BorderedGrayButton(
                            text: "+ افزودن عضو",
                            route: ClientFamilyInsuranceQuestionPage(),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                  WDG_FooterConfirmCancel(
                    pop: true,
                    cancelTitle: "انصراف",
                    confirmTitle: "ادامه",
                    confirmCallback: (result) async {
                      setState(() {
                        vis = true;
                      });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ProccessSuccessPage(response: null),
                      //   ),
                      // );

                      var admin = await OptionService().getByName("aid");
                      signalr.sendMessage(
                        admin.value,
                        EnrollService().getMyEnrolls()[0].id,
                        ChatMessage(
                          senderName: ProfileService().getUserData().fullname,
                          senderAvatar: ProfileService().getUserData().avatar,
                          message: "ثبت نام بیمه تکمیلی با موفقیت انجام شد",
                          id: EnrollService().getMyEnrolls()[0].id,
                        ),
                      );

                      var alert = AlertDialog(
                        title: Text("ثبت نام موفقیت آمیز"),
                        content: Text(
                          "بعد از پرداخت مبلغ حق بیمه ثبت نام شما تکمیل خواهد شد",
                          style: TextStyle(
                            fontFamily: "IRANSans",
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "ممنون",
                              style: TextStyle(
                                fontFamily: "IRANSans",
                              ),
                            ),
                          ),
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );

                      setState(() {
                        vis = false;
                      });
                    },
                    cancelRoute: InsuranceRegisterPage(),
                  )
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
