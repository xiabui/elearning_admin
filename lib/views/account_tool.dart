import 'package:elearningadmin/model/user.dart';
import 'package:elearningadmin/service/api_services.dart';
import 'package:elearningadmin/views/account_action.dart';
import 'package:elearningadmin/views/add_user.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:elearningadmin/views/widgets/app_drawer.dart';
import 'package:flutter/services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AccountTools extends StatefulWidget {
  @override
  _AccountToolsState createState() => _AccountToolsState();
}

class _AccountToolsState extends State<AccountTools> {
  String _scanBarCode = 'Unknown';
  String userID = "Null", fullName = "Null";
  bool hasChoosed = false;
  bool hasData = false;
  TextEditingController inputController = new TextEditingController();
  bool loading = false;

  List<User> userList = [];
  ApiProvider apiProvider = new ApiProvider();

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarCode = barcodeScanRes;
      inputController.text = _scanBarCode;
      print(_scanBarCode);
    });

    _searchUser(_scanBarCode);
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
              title: Text("Tài khoản người dùng",
                  style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black)),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AddUser()));
            },
            child: Icon(EvaIcons.personAdd),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xfff5f6fa),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: inputController,
                            decoration: InputDecoration(
                                hintText: "Type the student id",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.44,
                              child: RaisedButton(
                                onPressed: () {
                                  print("Pressed");
                                  _searchUser(inputController.text);
                                },
                                child: Text(
                                  "TÌM KIẾM",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Color(0xff3277D8),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.44,
                              child: RaisedButton(
                                onPressed: scanBarcodeNormal,
                                child: Text(
                                  "QUÉT THẺ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userList.length != 0
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: userList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  inputController.clear();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AccountAction(
                                            user: userList[index],
                                          )));
                                  //if (userList != null) userList.removeRange(0, userList.length);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff5f6fa),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            userList[index].dn.substring(
                                                4,
                                                userList[index]
                                                    .dn
                                                    .indexOf(',ou')),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              userList[index].firstname +
                                                  ' ' +
                                                  userList[index].lastname,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text("Đăng nhập lần cuối: " +
                                          iso8086ToString(
                                              userList[index].lastLogin))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: loading
                              ? Text("Đang tải...")
                              : Text(
                                  "Chưa tìm kiếm hoặc chưa có dữ liệu người dùng."),
                        )),
                ],
              ),
            ),
          ),
        ),
      );

  String gTM7(int time) {
    if (time > 24) return (time - 24).toString();
    return time.toString();
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

  _searchUser(String keyword) {
    setState(() {
      loading = true;
      if (userList != null) userList.removeRange(0, userList.length);
    });

    apiProvider.searchUser(keyword).then((value) {
      setState(() {
        loading = false;
        userList.addAll(value);
      });
    });
  }
}
