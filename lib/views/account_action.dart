import 'dart:math';
import 'package:elearningadmin/model/user.dart';
import 'package:elearningadmin/service/api_services.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AccountAction extends StatefulWidget {
  AccountAction({this.user});
  final User user;
  @override
  _AccountActionState createState() => _AccountActionState();
}

class _AccountActionState extends State<AccountAction> {
  ApiProvider apiProvider = new ApiProvider();

  TextEditingController userFirstName, userLastName, userEmail, userCohort;
  TextEditingController userPassword = TextEditingController();
  TextEditingController userReTypePassword = TextEditingController();

  bool hasError = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userPassword.dispose();
    userReTypePassword.dispose();
    userFirstName.dispose();
    userLastName.dispose();
    userEmail.dispose();
    userCohort.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      userFirstName = TextEditingController(text: widget.user.firstname);
      userLastName = TextEditingController(text: widget.user.lastname);
      userEmail = TextEditingController(text: widget.user.email);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
          child: Scaffold(
        appBar: AppBar(
          title: Text("Tài khoản người dùng",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      color: Color(0xfff5f6fa),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            widget.user.lastname[0],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user.firstname +
                                  " " +
                                  widget.user.lastname,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            Text(
                              widget.user.dn
                                  .substring(4, widget.user.dn.indexOf(',ou')),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(child: Text(widget.user.email)),
                            Container(
                                child: Text("Đăng nhập gần đây: " +
                                    iso8086ToString(widget.user.lastLogin))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        confirmDialog(() {
                          hotResetPassword(
                              widget.user.dn,
                              widget.user.dn
                                  .substring(4, widget.user.dn.indexOf(',ou')));
                        });
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Color(0xffff0033),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              EvaIcons.flash,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "KHÔI PHỤC\nTÀI KHOẢN NHANH",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        confirmDialog(() {
                          resetPassword(widget.user.dn, getRandomString(10));
                        });
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Color(0xff666666),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              EvaIcons.keypad,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ĐỔI MẬT KHẨU\nNGẪU NHIÊN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        confirmDialog(() {
                          _showChangeCustomPasswordDialog();
                        });
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Color(0xffFFCc66),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              EvaIcons.person,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ĐỔI MẬT KHẨU\nCÁ NHÂN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        confirmDialog(() {
                          resetPassword(widget.user.dn, "abcd@1234");
                        });
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Color(0xffCC6633),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              EvaIcons.archive,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ĐỔI MẬT KHẨU\nMẶC ĐỊNH",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        confirmDialog(() {
                          deleteUser(widget.user.dn);
                        });
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Color(0xff990066),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              EvaIcons.personDelete,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "XÓA TÀI KHOẢN\nNGƯỜI DÙNG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        confirmDialog(() {
                          changeSchoolEmail(
                              widget.user.dn,
                              widget.user.dn.substring(
                                      4, widget.user.dn.indexOf(',ou')) +
                                  "@student.tdmu.edu.vn");
                        });
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Color(0xff6600FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              EvaIcons.email,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "CẬP NHẬT EMAIL\nTRƯỜNG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showBottomSheet(context);
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              EvaIcons.personDone,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "CHỈNH SỬA THÔNG TIN NGƯỜI DÙNG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                      "This just is a temp UI/UX! It's maybe changes soon!"),
                )
              ],
            ),
          ),
        ),
      ));

  _showDialog(title, content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Okay"))
            ],
          );
        });
  }

  void _showChangeCustomPasswordDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Nhập vào mật khẩu cần đổi"),
            content: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: userPassword,
                    decoration: InputDecoration(
                        hintText: "Nhập mật khẩu mới",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: userReTypePassword,
                    decoration: InputDecoration(
                        hintText: "Nhập mật lại khẩu mới",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),
            ),
            actions: [
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Thôi bỏ")),
              new FlatButton(
                  onPressed: () {
                    if (userPassword.text == userReTypePassword.text) {
                      if (userPassword.text != '') {
                        Navigator.pop(context);
                        resetPassword(widget.user.dn, userPassword.text);
                      } else {
                        _showDialog(
                          "Thất bại", "Không có gì sao mà đổi mật khẩu -_-!");
                      }
                    } else {
                      _showDialog(
                          "Thất bại", "Có copy cái mật khẩu cũng sai -_-!");
                      userPassword.clear();
                      userReTypePassword.clear();
                    }
                  },
                  child: Text("Dứt luôn"))
            ],
          );
        });
  }

  void hotResetPassword(dn, password) {
    print("auto run");
    apiProvider.changePassword(dn, 'abcd@1234').then((value) {
      if (value == true) {
        apiProvider.changePassword(dn, password).then((value2) {
          if (value2 == true) {
            _showDialog("Thành công",
                "Đã thay đổi mật khẩu người dùng thành công! Mật khẩu là username.");
          } else {
            _showDialog("Thất bại",
                "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #HOTPASS02");
          }
        });
      } else {
        _showDialog("Thất bại",
            "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #HOTPASS01");
      }
    });
  }

  void resetPassword(dn, password) {
    apiProvider.changePassword(dn, password).then((value) {
      print(value);
      if (value == true) {
        _showDialog("Thành công",
            "Đã thay đổi mật khẩu người dùng thành công! Mật khẩu là $password.");
      } else {
        _showDialog("Thất bại",
            "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #PASS03");
      }
    });
  }

  void deleteUser(dn) {
    apiProvider.deleteUser(dn).then((value) {
      print(value);
      if (value) {
        //_showDialog("Thành công", "Đã xóa người dùng thành công!");
        Navigator.of(context).pop();
      } else {
        _showDialog("Thất bại",
            "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #DELUSER");
      }
    });
  }

  void changeSchoolEmail(dn, mail) {
    apiProvider.changeSchoolMail(dn, mail).then((value) {
      print(value);
      if (value == true) {
        _showDialog("Thành công",
            "Đã thay đổi email người dùng thành công! Email mới là $mail.");
      } else {
        _showDialog("Thất bại",
            "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #MAILSCHOOL");
      }
    });
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Họ và tên lót: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: TextField(
                            controller: userFirstName,
                            decoration: InputDecoration(
                              hintText: "Nhập họ và tên lót",
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tên: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: TextField(
                            controller: userLastName,
                            decoration: InputDecoration(
                              hintText: "Nhập vào tên",
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Email: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: TextField(
                            controller: userEmail,
                            decoration: InputDecoration(
                              hintText: "Nhập vào email",
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mật khẩu mới: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: TextField(
                            controller: userPassword,
                            decoration: InputDecoration(
                              errorText:
                                  hasError ? "Mật khẩu không khớp" : null,
                              hintText: "Nhập mật khẩu mới",
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nhập lại mật khẩu: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: TextField(
                            controller: userReTypePassword,
                            decoration: InputDecoration(
                              errorText:
                                  hasError ? "Mật khẩu không khớp" : null,
                              hintText: "Nhập lại mật khẩu mới",
                            )),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Lớp: "),
                //       Container(
                //         width: MediaQuery.of(context).size.width * 0.65,
                //         child: TextField(
                //             controller: userCohort,
                //             decoration: InputDecoration(
                //               hintText: "Nhập vào lớp",
                //             )),
                //       ),
                //     ],
                //   ),
                // ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () {},
                        child:
                            Text("HỦY", style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () {
                          updateUserInfo(
                              userPassword.text, userReTypePassword.text);
                        },
                        child: Text("XONG",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        color: Color(0xff1a3f77),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  void updateUserInfo(userPass, userRePass) {
    print(userFirstName.text);
    if (userPassword.text != '' &&
        userPassword.text == userReTypePassword.text) {
      apiProvider
          .updateUserInfo(userFirstName.text, userLastName.text, userEmail.text,
              widget.user.dn)
          .then((value) {
        if (value) {
          apiProvider
              .changePassword(widget.user.dn, userPassword.text)
              .then((value) {
            if (value) {
              _showDialog(
                  "Thành công", "Thông tin người dùng đã cập nhật thành công");
            } else {
              _showDialog("Thất bại",
                  "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #PASS03");
            }
          });
        } else {
          _showDialog("Thất bại",
              "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #UPDATE01");
        }
      });
    } else if (userPassword.text == '') {
      apiProvider
          .updateUserInfo(userFirstName.text, userLastName.text, userEmail.text,
              widget.user.dn)
          .then((value) {
        if (value) {
          _showDialog(
              "Thành công", "Thông tin người dùng đã cập nhật thành công");
        } else {
          _showDialog("Thất bại",
              "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #UPDATE01");
        }
      });
    } else {
      _showDialog("Thất bại", "Có copy cái mật khẩu cũng sai -_-!");
      userPassword.clear();
      userReTypePassword.clear();
    }
  }

  void confirmDialog(void action()) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Xác nhận"),
            content: Text(
                "Bạn có chắc thực hiện hành động này chứ? Mọi thao tác sẽ không thể hoàn tác!"),
            actions: [
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Thôi bỏ")),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    action();
                  },
                  child: Text("Dứt luôn")),
            ],
          );
        });
  }

  String iso8086ToString(String date) {
    return date != ""
        ? date.substring(0, 4) +
            '-' +
            date.substring(4, 6) +
            "-" +
            date.substring(6, 8) +
            " " +
            gTM7(int.parse(date.substring(8, 10)) + 7) +
            ":" +
            date.substring(10, 12)
        : "Chưa bao giờ";
  }

  String gTM7(int time) {
    if (time > 24) return (time - 24).toString();
    return time.toString();
  }
}

const _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890[]!@#%^&*(){}|;":<>?,./';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
