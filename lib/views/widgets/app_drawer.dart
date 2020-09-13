import 'package:elearningadmin/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elearningadmin/views/account_tool.dart';
import 'package:elearningadmin/views/activity_log.dart';
import 'package:elearningadmin/views/calendar.dart';
import 'package:elearningadmin/views/infomation.dart';
import 'package:flutter/material.dart';
import '../dashboard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:random_color/random_color.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  static RandomColor _randomColor = RandomColor();
  Color _color = _randomColor.randomColor();
  String fullname = "Not load";
  String lastname = "yet";

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration:
                        BoxDecoration(color: _color, shape: BoxShape.circle),
                    child: Text(
                      lastname[0],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          fullname,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Phiên làm việc còn 10 phút",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => DashboardPage()));
          //   },
          //   title: Container(
          //     height: 50,
          //     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //     margin: EdgeInsets.only(right: 10),
          //     decoration: BoxDecoration(
          //         //color: (currentChoosed == 1) ? Color(0xffe4effc) : null,
          //         borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(25),
          //       bottomRight: Radius.circular(25),
          //     )),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Container(
          //             child: Icon(
          //           EvaIcons.barChartOutline,
          //           color: Colors.blueAccent,
          //         )),
          //         SizedBox(width: 20),
          //         Container(
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //               "Trang chủ",
          //               style: TextStyle(
          //                 fontSize: 14,
          //               ),
          //             ))
          //       ],
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => ActivityLogs()));
          //   },
          //   title: Container(
          //     height: 50,
          //     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //     margin: EdgeInsets.only(right: 10),
          //     decoration: BoxDecoration(
          //         //color: (currentChoosed == 2) ? Color(0xffe4effc) : null,
          //         borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(25),
          //       bottomRight: Radius.circular(25),
          //     )),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Container(
          //           child: Icon(
          //             EvaIcons.activityOutline,
          //             color: Colors.redAccent,
          //           ),
          //         ),
          //         SizedBox(width: 20),
          //         Container(
          //             alignment: Alignment.centerLeft,
          //             child: Text("Nhật ký",
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                 )))
          //       ],
          //     ),
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (BuildContext context) => AccountTools()));
            },
            title: Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  //color: (currentChoosed == 2) ? Color(0xffe4effc) : null,
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(EvaIcons.person,
                        size: 24, color: Colors.orangeAccent),
                  ),
                  SizedBox(width: 20),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Tài khoản người dùng",
                          style: TextStyle(
                            fontSize: 14,
                          )))
                ],
              ),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.push(
          //         (context),
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => CalendarPage()));
          //   },
          //   title: Container(
          //     height: 50,
          //     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //     margin: EdgeInsets.only(right: 10),
          //     decoration: BoxDecoration(
          //         //color: (currentChoosed == 2) ? Color(0xffe4effc) : null,
          //         borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(25),
          //       bottomRight: Radius.circular(25),
          //     )),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Container(
          //           child: Icon(
          //             EvaIcons.calendarOutline,
          //             size: 24,
          //             color: Colors.greenAccent,
          //           ),
          //         ),
          //         SizedBox(width: 20),
          //         Container(
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //               "Lịch và Sự kiện",
          //               style: TextStyle(
          //                 fontSize: 14,
          //               ),
          //             ))
          //       ],
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.push(
          //         (context),
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => InformationPage()));
          //   },
          //   title: Container(
          //     height: 50,
          //     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //     margin: EdgeInsets.only(right: 10),
          //     decoration: BoxDecoration(
          //         //color: (currentChoosed == 2) ? Color(0xffe4effc) : null,
          //         borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(25),
          //       bottomRight: Radius.circular(25),
          //     )),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Container(
          //           child: Icon(
          //             EvaIcons.settings,
          //             size: 24,
          //             color: Colors.amberAccent,
          //           ),
          //         ),
          //         SizedBox(width: 20),
          //         Container(
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //               "Cài đặt",
          //               style: TextStyle(
          //                 fontSize: 14,
          //               ),
          //             ))
          //       ],
          //     ),
          //   ),
          // ),
          ListTile(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
               Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginForm()));
            },
            title: Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  //color: (currentChoosed == 2) ? Color(0xffe4effc) : null,
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(
                      EvaIcons.logOutOutline,
                      size: 24,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Đăng xuất",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      fullname = preferences.getString('fullname');
      lastname = preferences.getString('lastname');
      print(fullname);
    });
  }
}
