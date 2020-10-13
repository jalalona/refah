import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/pages/admin/AdminChatPage.dart';
import 'package:refah/pages/admin/AdminCommentPage.dart';
import 'package:refah/pages/admin/AdminDoctorsPage.dart';
import 'package:refah/pages/admin/AdminEnrollsPage.dart';
import 'package:refah/pages/admin/AdminLogin.dart';
import 'package:refah/pages/admin/AdminPresentsPage.dart';
import 'package:refah/pages/admin/AdminReportChoosePage.dart';
import 'package:refah/pages/admin/AdminSMSPage.dart';
import 'package:refah/pages/admin/AdminSettingPage.dart';
import 'package:refah/pages/admin/AdminUsersPage.dart';
import 'package:refah/pages/admin/Registeration/AdminSampleUploadPage.dart';
import 'package:refah/pages/admin/WorkUsersPage.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BigIconButton.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';

import 'Registeration/AdminDentistryRegisterPage.dart';

class AdminPanelPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminPanelPage({
    this.description,
    this.title,
  });

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  List<WDG_QuestionItem> questionItems = List<WDG_QuestionItem>();

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminLogin(),
    //   ),
    // );

    return false;
  }

  @override
  void initState() {
    super.initState();

    OptionService().init();
    UserService().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(
                    "پنل مدیریت",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
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
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: <Widget>[
                          WDG_BigIconButton(
                            title: "کامنت ها",
                            description: "مدیریت کامنت های کاربران",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminCommentPage(
                              title: "کامنت ها",
                            ),
                          ),
                          WDG_BigIconButton(
                            title: "مراکز",
                            description: "مدیریت اطلاعات مراکز",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminDoctorsPage(
                              title: "مراکز",
                            ),
                          ),
                          WDG_BigIconButton(
                            title: "دندانپزشکی",
                            description: "ثبت نام های دندانپزشکی",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminDentistryRegisteryPage(),
                          ),
                          WDG_BigIconButton(
                            title: "تخفیف ها",
                            description: "ثبت تخفیف های موجود",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminSampleUploadPage(
                                // onSubmitCallback: (result) {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           AdminInsuranceRegisterPage(),
                                //     ),
                                //   );
                                // },
                                ),
                          ),
                          WDG_BigIconButton(
                            title: "تنظیمات",
                            description: "تنظیمات سیستم",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminSettingPage(),
                          ),
                          WDG_BigIconButton(
                            title: "پیام ها",
                            description: "مدیریت پیام ها",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminSMSPage(),
                          ),
                          WDG_BigIconButton(
                            title: "گزارش ها",
                            description: "گزارش های سیستم",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminReportChoosePage(),
                          ),
                          WDG_BigIconButton(
                            title: "مکاتبات",
                            description: "مدیریت پیام های کاربران",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminChatPage(
                              title: "پیام های کاربران",
                            ),
                          ),
                          WDG_BigIconButton(
                            title: "همکاری با ما",
                            description: "پیام های کاربران",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: WorkUsersPage(),
                          ),
                          // WDG_BigIconButton(
                          //   title: "خدمات",
                          //   description: "مدیریت خدمات قابل ارائه",
                          //   icon: Image.asset(
                          //     "images/familyinsurance.png",
                          //   ),
                          //   route: AdminPresentsPage(),
                          // ),
                          WDG_BigIconButton(
                            title: "اعضاء",
                            description: "مدیریت اعضاء",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminUsersPage(),
                          ),
                          WDG_BigIconButton(
                            title: "ثبت نام ها",
                            description: "مدیریت ثبت نام ها",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            route: AdminEnrollsPage(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onWillPop: () => backPress()),
    );
  }
}
