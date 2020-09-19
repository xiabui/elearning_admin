import 'package:elearningadmin/resource/constant.dart';
import 'package:elearningadmin/service/api_services.dart';
import 'package:elearningadmin/views/account_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';

//import 'bloc/blocs.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // For CircularProgressIndicator.
  bool visible = false;
  bool hasErrorP = false, hasErrorU = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  ApiProvider apiProvider = new ApiProvider();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    hasLogin().then((value) {
      if (value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => AccountTools()));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: visible
            ? Center(child: CircularProgressIndicator())
            : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.all(40),
                        child: Image.asset('logo_elearning.png'),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Image.asset('login_bg_bot.jpg'),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 28, right: 28, top: 60),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(290),
                          ),
                          Container(
                            width: double.infinity,
                            height: ScreenUtil.getInstance().setHeight(500),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(1, 2),
                                    blurRadius: 3,
                                  )
                                ]),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(45),
                                      //fontFamily: 'Poppins-Bold',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .6,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Text(
                                    "Username",
                                    style: TextStyle(
                                      //fontFamily: 'Poppins-Regular',
                                      fontSize: ScreenUtil.getInstance()
                                          .setHeight(26),
                                    ),
                                  ),
                                  TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                        hintText: "username",
                                        errorText: hasErrorU
                                            ? Constant.username_input_error
                                            : null,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        )),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      //fontFamily: 'Poppins-Regular',
                                      fontSize: ScreenUtil.getInstance()
                                          .setHeight(26),
                                    ),
                                  ),
                                  TextField(
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        hintText: "password",
                                        errorText: hasErrorP
                                            ? Constant.password_input_error
                                            : null,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        )),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(35),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          //fontFamily: "Poppins-Medium",
                                          fontSize: ScreenUtil.getInstance()
                                              .setSp(28),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(40),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                  child: GestureDetector(
                                onTap: () {
                                  userLogin(context);
                                },
                                child: Container(
                                  width: ScreenUtil.getInstance().setWidth(640),
                                  height:
                                      ScreenUtil.getInstance().setHeight(100),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      color: Colors.blue),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: Center(
                                        child: Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              //fontFamily: "Poppins-Bold",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
  }

  void userLogin(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'Đang đăng nhập...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    pr.show();
    apiProvider
        .requestLoginAPI(
            context, usernameController.text, passwordController.text)
        .then((value) {
      if (value == true) {
        apiProvider.getMyInfo();
        pr.update(
            message: "Đang lấy thông tin...",
            progressWidget: CircularProgressIndicator(),
            progress: 0.0,
            maxProgress: 100.0,
            progressTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
            messageTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.w600));

        pr.hide();
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => AccountTools()));
      } else {
        pr.hide();
        _showDialog();
      }
    });
  }

  Future<bool> hasLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('token') != null) return true;
    return false;
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login failed"),
            content: Text("Wrong username or password, please try again!"),
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
}
