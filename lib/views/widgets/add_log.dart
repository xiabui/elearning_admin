import 'package:elearningadmin/model/history.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLog extends StatefulWidget {
  @override
  _AddLogState createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {
  String value = '';
  TextEditingController userid = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  DateTime date = new DateTime.now();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(EvaIcons.arrowBack),
                              Text(
                                "Back",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _onPressFinish,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "Finish",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1a3f77)),
                            ),
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 10),
                Text("Add User Supported"),
                Divider(),
                Text("User ID"),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: userid,
                        decoration: InputDecoration(
                          hintText: "Ex: 1824801030000",
                          contentPadding: EdgeInsets.all(8),
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                          ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {},
                        child: Text("SCAN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1a3f77)))),
                    Spacer(),
                  ],
                ),
                Text("Name"),
                SizedBox(height: 5),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: "Ex: Helena Andes",
                    contentPadding: EdgeInsets.all(8),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                ),
                SizedBox(height: 10),
                Text("User Role"),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Radio(
                        value: 'teacher',
                        groupValue: value,
                        onChanged: _onRadioChange,
                        activeColor: Colors.blue),
                    Text("Teacher"),
                    Radio(
                        value: 'student',
                        groupValue: value,
                        onChanged: _onRadioChange),
                    Text("Student")
                  ],
                ),
                SizedBox(height: 10),
                Text("Support Description"),
                SizedBox(height: 5),
                TextField(
                  controller: desc,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  maxLength: 400,
                  decoration: InputDecoration(
                    hintText: "Ex: Reset MST Password",
                    contentPadding: EdgeInsets.all(8),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onRadioChange(val) {
    if (val == "teacher") {
      print("teacher");
    } else {
      print("student");
    }
  }
  void _onPressFinish() async {
    FocusScope.of(context).unfocus();
    print(userid.text);
    if (userid.text != null && name.text != null && desc.text != null) {
      final snapShot =
          await Firestore.instance.collection('support_logs').document(userid.text).get();

      History history = new History(date: date, content: desc.text);

      final databaseReference = Firestore.instance;
      print(snapShot);
      if (snapShot == null || !snapShot.exists) {
        print("Add");
        await databaseReference
            .collection('support_logs')
            .document(userid.text)
            .setData({
          'userid': userid.text,
          'name': name.text,
          'support_content': desc.text,
          'supported_count': 1,
          'history': FieldValue.arrayUnion([history.toJson()]),
          'supporter_id': 'bvxia',
          'lastest': date
        }).catchError((error) {
          print(error);
          setState(() {
            isError = true;
          });
          Toast.show(error.toString(), context, backgroundColor: Colors.red,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        });
        if(isError == false) Toast.show("Added successfully", context, backgroundColor: Color(0xff1a3f77),duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      } else {
        print("update");
        await databaseReference
            .collection('support_logs')
            .document(userid.text)
            .updateData({
          'supported_count': FieldValue.increment(1),
          'history': FieldValue.arrayUnion([history.toJson()]),
          'lastest': date
        }).catchError((error) {
          print(error);
          setState(() {
            isError = true;
          });
          Toast.show(error.toString(), context, backgroundColor: Colors.red,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        });
        if(isError == false) Toast.show("Updated successfully", context, backgroundColor: Color(0xff1a3f77),duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      //Navigator.pop(context);
    }
  }
}
