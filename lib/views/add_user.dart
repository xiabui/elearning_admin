import 'package:elearningadmin/service/api_services.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sweetalert/sweetalert.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  ApiProvider apiProvider = new ApiProvider();
  TextEditingController userName = TextEditingController();
  TextEditingController userFirstName = TextEditingController();
  TextEditingController userLastName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userCohort = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userReTypePassword = TextEditingController();
  bool useUsernameAsPassword = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userName.dispose();
    userPassword.dispose();
    userReTypePassword.dispose();
    userFirstName.dispose();
    userLastName.dispose();
    userEmail.dispose();
    userCohort.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Thêm người dùng mới",
              style: TextStyle(color: Colors.black, fontSize: 14)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            GestureDetector(
              onTap: () {
                createAccount();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Center(
                  child: Text("XONG",
                      style: TextStyle(
                          color: Color(0xff1a3f77),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(5, 20, 0, 10),
                    child: Text("Tên người dùng: ")),
                Container(
                  child: TextField(
                      controller: userName,
                      onEditingComplete: () {
                        setState(() {
                          userPassword.text =
                              userReTypePassword.text = userName.text;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Nhập vào tên người dùng",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                    child: Text("Họ và tên lót: ")),
                Container(
                  child: TextField(
                      controller: userFirstName,
                      decoration: InputDecoration(
                          hintText: "Nhập họ và tên lót",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                    child: Text("Tên: ")),
                Container(
                  child: TextField(
                      controller: userLastName,
                      decoration: InputDecoration(
                          hintText: "Nhập vào tên",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                    child: Text("Email: ")),
                Container(
                  child: TextField(
                      controller: userEmail,
                      decoration: InputDecoration(
                          hintText: "Nhập vào email",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                    child: Text("Mật khẩu: ")),
                Container(
                  child: TextField(
                      controller: userPassword,
                      decoration: InputDecoration(
                          hintText: "Nhập vào mật khẩu",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                    child: Text("Nhập lại mật khẩu: ")),
                Container(
                  child: TextField(
                      controller: userReTypePassword,
                      decoration: InputDecoration(
                          hintText: "Nhập lại mật khẩu",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                SizedBox(
                  height: 20,
                ),
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

  void createAccount() {
    if (userPassword.text == userReTypePassword.text &&
        userPassword.text != '') {
      apiProvider
          .createUser(userName.text, userFirstName.text, userLastName.text,
              userEmail.text, userPassword.text)
          .then((value) {
        if (value) {
          SweetAlert.show(context,
              title: "Thành công", style: SweetAlertStyle.success);
          popBottomSheet();
        } else {
          _showDialog("Thất bại",
              "Đã có lỗi đã xảy ra, vui lòng thông báo cho Admin App khi gặp lỗi này. Code: #CREATE");
        }
      });
    } else {
      if (userPassword.text != userReTypePassword.text) {
        _showDialog("Thất bại", "Có copy rồi paste cũng ghi sai -_-!");
      } else {
        _showDialog("Thất bại", "Có copy rồi paste cũng ghi sai -_-!");
      }
    }
  }

  void popBottomSheet() {
    userName.clear();
    userFirstName.clear();
    userLastName.clear();
    userEmail.clear();
    userPassword.clear();
    userReTypePassword.clear();
  }
}
