import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_DoctorCardItem.dart';

class ClientDoctorsPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  ClientDoctorsPage({
    this.description,
    this.title,
  });

  @override
  _ClientDoctorsPageState createState() => _ClientDoctorsPageState();
}

class _ClientDoctorsPageState extends State<ClientDoctorsPage> {
  List<UserVM> parts = List<UserVM>();
  var f = NumberFormat("###.#", "fa_IR");

  Future<List<UserVM>> setupPartners() async {
    return await UserService().filter("partner");
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

    //setupPartners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: 60.0,
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
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
            child: FutureBuilder(
              future: setupPartners(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WDG_DoctorCardItem(
                          obj: snapshot.data[index],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
