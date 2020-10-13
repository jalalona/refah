import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/Provider/SignalR.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/pages/ProccessSuccessPage.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BigGreenButton.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_DateTimeInput.dart';
import 'package:refah/widgets/WDG_FamilyItem.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_PersianDateTimeInput.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';
import 'package:refah/widgets/WDG_UploadImageInput.dart';
import 'package:url_launcher/url_launcher.dart';

class DentistryFamilyRegisteryPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  DentistryFamilyRegisteryPage({
    this.description,
    this.title,
  });

  @override
  _DentistryFamilyRegisteryPageState createState() =>
      _DentistryFamilyRegisteryPageState();
}

class _DentistryFamilyRegisteryPageState
    extends State<DentistryFamilyRegisteryPage> with WidgetsBindingObserver {
  int isValid = 0;
  OrderVM activeOrder;
  Widget formdata;

  bool vis = false;
  EnrollVM enroll = EnrollVM();
  File file;
  String cost = "";
  String costo = "";
  double opt = 0.0;
  double opto = 0.0;
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

  List<Widget> items = List<Widget>();

  Future initCost() async {
    // setState(() {
    //   vis = true;
    // });
    var res = await OptionService().getByName("dentist_family_cost");
    var reso = await OptionService().getByName("dentist_one_cost");
    cost = res?.value ?? "0 ریال";
    cost += " ریال";
    opt = double.parse(res?.value ?? "0") ?? 0.0;

    costo = reso?.value ?? "0 ریال";
    costo += " ریال";
    opto = double.parse(reso?.value ?? "0") ?? 0.0;
    // setState(() {
    //   vis = false;
    // });
  }

  Future refreshItems() {
    setState(() {
      vis = true;
    });
    setState(() {
      items = EnrollService()
              .getMyEnrolls()
              ?.map(
                (e) => WDG_FamilyItem(
                  user: e,
                  cost:
                      EnrollService().getMyEnrolls().length > 1 ? cost : costo,
                  deleteCallback: (result) async {
                    setState(() {});
                  },
                ),
              )
              ?.toList() ??
          [Text("")];
    });
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
          message: "ثبت نام دندانپزشکی با موفقیت ثبت نام و پرداخت شد",
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
  void initState() {
    super.initState();
    signalr = SignalR(context);

    initCost();

    formdata = Column(
      children: <Widget>[
        WDG_BorderedTextInput(
          isRequired: true,
          onErrorCallback: (error) {
            isValid = error;
          },
          value: enroll?.fullname ?? "",
          hintText: "نام و نام خانوادگی",
          onChangeCallback: (result) {
            enroll.fullname = result;
          },
        ),
        WDG_BorderedTextInput(
          isRequired: true,
          onErrorCallback: (error) {
            isValid = error;
          },
          value: enroll?.identityNumber ?? "",
          hintText: "شماره شناسنامه",
          inputType: TextInputType.number,
          onChangeCallback: (result) {
            enroll.identityNumber = result;
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
                value: enroll.nationalId ?? "",
                max: 10,
                hintText: "کد ملی",
                inputType: TextInputType.number,
                onChangeCallback: (result) {
                  enroll.nationalId = result;
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
                value: enroll?.systemTag ?? "",
                hintText: "شماره موبایل",
                inputType: TextInputType.phone,
                onChangeCallback: (result) {
                  enroll.systemTag = result;
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
                value: enroll.birthday ?? "",
                onChangeCallback: (result) {
                  enroll.birthday = result.toString();
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
                value: enroll.fatherName ?? "",
                hintText: "نام پدر",
                inputType: TextInputType.text,
                onChangeCallback: (result) {
                  enroll.fatherName = result;
                },
              ),
            ),
          ],
        ),
        WDG_SizedBorderedTextInput(
          //isRequired: true,
          onErrorCallback: (error) {
            isValid = error;
          },
          max: 11,
          value: enroll.homePhone ?? "",
          hintText: "شماره تلفن منزل",
          inputType: TextInputType.phone,
          onChangeCallback: (result) {
            enroll.homePhone = result;
          },
        ),
        WDG_BorderedTextInput(
          //isRequired: true,
          onErrorCallback: (error) {
            isValid = error;
          },
          value: enroll.address ?? "",
          hintText: "آدرس",
          onChangeCallback: (result) {
            enroll.address = result;
          },
        ),
        WDG_UploadImageInput(
          //isRequired: true,
          onErrorCallback: (error) {
            isValid = error;
          },
          fileName: "عکس پرسنلی",
          onTapCallback: (result) {
            file = result;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            WDG_BigGreenButton(
              text: "افزودن",
              onTapCallback: (result) async {
                if (isValid > 0) return;
                setState(() {
                  vis = true;
                });
                enroll.enrollType = "dentist";
                enroll.startTime = DateTime.now();
                enroll.expireTime = enroll.startTime.add(
                  Duration(days: 365),
                );
                var res =
                    await EnrollService().uploadEnrollAndFile(file, enroll);

                if (res != null) {
                  formdata = Text("");
                  enroll = EnrollVM();
                  file = null;
                  formdata = Column(
                    children: <Widget>[
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: enroll?.fullname ?? "",
                        hintText: "نام و نام خانوادگی",
                        onChangeCallback: (result) {
                          enroll.fullname = result;
                        },
                      ),
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: enroll?.identityNumber ?? "",
                        hintText: "شماره شناسنامه",
                        inputType: TextInputType.number,
                        onChangeCallback: (result) {
                          enroll.identityNumber = result;
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
                              value: enroll.nationalId ?? "",
                              max: 10,
                              hintText: "کد ملی",
                              inputType: TextInputType.number,
                              onChangeCallback: (result) {
                                enroll.nationalId = result;
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
                              value: enroll?.systemTag ?? "",
                              hintText: "شماره موبایل",
                              inputType: TextInputType.phone,
                              onChangeCallback: (result) {
                                enroll.systemTag = result;
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
                              value: enroll.birthday ?? "",
                              onChangeCallback: (result) {
                                enroll.birthday = result.toString();
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
                              value: enroll.fatherName ?? "",
                              hintText: "نام پدر",
                              inputType: TextInputType.text,
                              onChangeCallback: (result) {
                                enroll.fatherName = result;
                              },
                            ),
                          ),
                        ],
                      ),
                      WDG_SizedBorderedTextInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        max: 11,
                        value: enroll.homePhone ?? "",
                        hintText: "شماره تلفن منزل",
                        inputType: TextInputType.phone,
                        onChangeCallback: (result) {
                          enroll.homePhone = result;
                        },
                      ),
                      WDG_BorderedTextInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: enroll.address ?? "",
                        hintText: "آدرس",
                        onChangeCallback: (result) {
                          enroll.address = result;
                        },
                      ),
                      WDG_UploadImageInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        fileName: "عکس پرسنلی",
                        onTapCallback: (result) {
                          file = result;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          WDG_BigGreenButton(
                            text: "افزودن",
                            onTapCallback: (result) async {
                              if (isValid > 0) return;
                              setState(() {
                                vis = true;
                              });
                              enroll.enrollType = "dentist";
                              enroll.startTime = DateTime.now();
                              enroll.expireTime = enroll.startTime.add(
                                Duration(days: 365),
                              );
                              var res = await EnrollService()
                                  .uploadEnrollAndFile(file, enroll);

                              if (res != null) {
                                //refreshItems();
                              }

                              setState(() {
                                vis = false;
                              });
                            },
                          ),
                          Visibility(
                            child: CircularProgressIndicator(),
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: vis,
                          ),
                        ],
                      ),
                      Container(
                        height: 150.0,
                        child: ListView(
                          children: EnrollService()
                                  .getMyEnrolls()
                                  ?.map(
                                    (e) => WDG_FamilyItem(
                                      user: e,
                                      cost: EnrollService()
                                                  .getMyEnrolls()
                                                  .length >
                                              1
                                          ? cost
                                          : costo,
                                      deleteCallback: (result) async {
                                        setState(() {});
                                      },
                                    ),
                                  )
                                  ?.toList() ??
                              [Text("")],
                        ),
                      ),
                    ],
                  );
                  //setState(() {});
                }

                setState(() {
                  vis = false;
                });
              },
            ),
            Visibility(
              child: CircularProgressIndicator(),
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: vis,
            ),
          ],
        ),
        Container(
          height: 150.0,
          child: ListView(
            children: EnrollService()
                    .getMyEnrolls()
                    ?.map(
                      (e) => WDG_FamilyItem(
                        user: e,
                        cost: EnrollService().getMyEnrolls().length > 1
                            ? cost
                            : costo,
                        deleteCallback: (result) async {
                          setState(() {});
                        },
                      ),
                    )
                    ?.toList() ??
                [Text("")],
          ),
        ),
      ],
    );
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
                    top: 10.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
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
                        value: enroll?.fullname ?? "",
                        hintText: "نام و نام خانوادگی",
                        onChangeCallback: (result) {
                          enroll.fullname = result;
                        },
                      ),
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: enroll?.identityNumber ?? "",
                        hintText: "شماره شناسنامه",
                        inputType: TextInputType.number,
                        onChangeCallback: (result) {
                          enroll.identityNumber = result;
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
                              value: enroll.nationalId ?? "",
                              max: 10,
                              hintText: "کد ملی",
                              inputType: TextInputType.number,
                              onChangeCallback: (result) {
                                enroll.nationalId = result;
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
                              value: enroll?.systemTag ?? "",
                              hintText: "شماره موبایل",
                              inputType: TextInputType.phone,
                              onChangeCallback: (result) {
                                enroll.systemTag = result;
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
                              value: enroll.birthday ?? "",
                              onChangeCallback: (result) {
                                enroll.birthday = result.toString();
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
                              value: enroll.fatherName ?? "",
                              hintText: "نام پدر",
                              inputType: TextInputType.text,
                              onChangeCallback: (result) {
                                enroll.fatherName = result;
                              },
                            ),
                          ),
                        ],
                      ),
                      WDG_SizedBorderedTextInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        max: 11,
                        value: enroll.homePhone ?? "",
                        hintText: "شماره تلفن منزل",
                        inputType: TextInputType.phone,
                        onChangeCallback: (result) {
                          enroll.homePhone = result;
                        },
                      ),
                      WDG_BorderedTextInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: enroll.address ?? "",
                        hintText: "آدرس",
                        onChangeCallback: (result) {
                          enroll.address = result;
                        },
                      ),
                      WDG_UploadImageInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        fileName: "عکس پرسنلی",
                        onTapCallback: (result) {
                          file = result;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          WDG_BigGreenButton(
                            text: "افزودن",
                            onTapCallback: (result) async {
                              if (isValid > 0) return;
                              setState(() {
                                vis = true;
                              });
                              enroll.enrollType = "dentist";
                              enroll.startTime = DateTime.now();
                              enroll.expireTime = enroll.startTime.add(
                                Duration(days: 365),
                              );
                              var res = await EnrollService()
                                  .uploadEnrollAndFile(file, enroll);

                              if (res != null) {
                                setState(() {
                                  enroll = EnrollVM();
                                  file = null;
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DentistryFamilyRegisteryPage(),
                                    ),
                                  );
                                });
                              }

                              setState(() {
                                vis = false;
                              });
                            },
                          ),
                          Visibility(
                            child: CircularProgressIndicator(),
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: vis,
                          ),
                        ],
                      ),
                      Container(
                        height: 150.0,
                        child: ListView(
                          children: EnrollService()
                                  .getMyEnrolls()
                                  ?.map(
                                    (e) => WDG_FamilyItem(
                                      user: e,
                                      cost: EnrollService()
                                                  .getMyEnrolls()
                                                  .length >
                                              1
                                          ? cost
                                          : costo,
                                      deleteCallback: (result) async {
                                        setState(() {});
                                      },
                                    ),
                                  )
                                  ?.toList() ??
                              [Text("")],
                        ),
                      ),
                    ],
                  ),
                ),
                WDG_FooterConfirmCancel(
                  confirmTitle: "پرداخت",
                  cancelTitle: EnrollService().getMyEnrolls().length > 1
                      ? (opt * EnrollService().getMyEnrolls()?.length ?? 0)
                              .toString() +
                          " ریال"
                      : (opto * EnrollService().getMyEnrolls()?.length ?? 0)
                              .toString() +
                          " ریال",
                  cancelSecondTitle:
                      EnrollService().getMyEnrolls().length.toString() +
                          " مورد",
                  //confirmRoute: ProccessSuccessPage(),
                  confirmCallback: (result) async {
                    setState(() {
                      vis = true;
                    });
                    var result = await EnrollService().Payment(false);

                    if (result != null &&
                        result.authority != null &&
                        result.authority.isNotEmpty) {}
                    try {
                      activeOrder = result;
                      var url = "https://next.zarinpal.com/pg/StartPay/" +
                          result.authority;
                      await _launchURL(url);
                    } catch (e) {}
                    setState(() {
                      vis = false;
                    });
                  },
                  //cancelRoute: ClientHomePage(),
                )
              ],
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
