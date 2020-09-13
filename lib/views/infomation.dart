import 'dart:ui';
import 'package:elearningadmin/views/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Cài đặt",
          style: TextStyle(
            color: Colors.black
          )
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 150,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          color: Colors.red
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Bui Van Xia".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decorationStyle: TextDecorationStyle.solid,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(EvaIcons.peopleOutline), 
                            Text(
                              "  Thông tin cá nhân"
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(EvaIcons.settings2Outline), 
                            Text(
                              "  Cài đặt"
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.perm_device_information), 
                            Text(
                              "  Phân quyền hệ thống"
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(EvaIcons.sun), 
                            Text(
                              "  Nền tối"
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "OFF",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  )
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.system_update), 
                            Text(
                              "  Kiểm tra cập nhật"
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(EvaIcons.infoOutline), 
                            Text(
                              "  Thông tin ứng dụng"
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "version: v1.0 alpha",
                        style: TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic
                        ),
                      )
                    ],
                  )
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(EvaIcons.logOutOutline), 
                            Text(
                              "  Đăng xuất"
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ),

                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.copyright, size: 20),
                        Text(
                          "2019-2020   E-Learning Developer Team",
                          style: TextStyle(
                            fontSize: 12
                          ),
                        )
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
