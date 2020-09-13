import 'package:elearningadmin/service/api_services.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

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
        appBar: AppBar(
            title: Text("Thêm người dùng mới",
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black)),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tên người dùng: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.58,
                        child: TextField(
                            controller: userName,
                            decoration: InputDecoration(
                              hintText: "Nhập vào tên người dùng",
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Họ và tên lót: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.58,
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
                        width: MediaQuery.of(context).size.width * 0.58,
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
                        width: MediaQuery.of(context).size.width * 0.58,
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
                      Text("Mật khẩu: "),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.58,
                        child: TextField(
                            controller: userPassword,
                            decoration: InputDecoration(
                              hintText: "Nhập vào mật khẩu",
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
                        width: MediaQuery.of(context).size.width * 0.58,
                        child: TextField(
                            controller: userReTypePassword,
                            decoration: InputDecoration(
                              hintText: "Nhập lại mật khẩu",
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      createAccount();
                    },
                    child: Text("XONG",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    color: Color(0xff1a3f77),
                  ),
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

  void createAccount() {
    if (userPassword.text == userReTypePassword.text &&
        userPassword.text != '') {
      apiProvider
          .createUser(userName.text, userFirstName.text, userLastName.text,
              userEmail.text, userPassword.text)
          .then((value) {
        if (value) {
          _showDialog("Thành công", "Tạo tài khoản thành công!");
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
