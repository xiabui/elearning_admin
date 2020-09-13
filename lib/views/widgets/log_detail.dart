import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogDetail extends StatefulWidget {
  final String userid;
  LogDetail({this.userid});

  @override
  _LogDetailState createState() => _LogDetailState();
}

class _LogDetailState extends State<LogDetail> {
  bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('support_logs')
                .document(widget.userid)
                .snapshots(),
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(EvaIcons.arrowBack),
                              Text(
                                "Back",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: double.infinity,
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Color(0xfff5f6fa),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  color: Colors.red,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Last Supporter",
                                  style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      //color: Colors.blue
                                      ),
                                ),
                                Divider(),
                                Text(
                                  snapshot.data['supporter_id'],
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                    //color: Colors.blue
                                  ),
                                ),
                                Text(
                                  "Lastest: " + snapshot.data['lastest'].toDate().day.toString()
                                  + "/" + snapshot.data['lastest'].toDate().month.toString()
                                  + "/" + snapshot.data['lastest'].toDate().year.toString(),
                                  style: TextStyle(fontSize: 10
                                      //fontWeight: FontWeight.bold,
                                      //color: Colors.blue
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Color(0xfff5f6fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: MediaQuery.of(context).size.width * 0.45,
                                height:
                                    MediaQuery.of(context).size.width * 0.27,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Student",
                                      style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          //color: Colors.blue
                                          ),
                                    ),
                                    Divider(),
                                    Text(
                                      snapshot.data['name'],
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.blue
                                      ),
                                    ),
                                    Text(
                                      snapshot.data['userid'],
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.blue
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Color(0xfff5f6fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Times Supported",
                                      style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          //color: Colors.blue
                                          ),
                                    ),
                                    Divider(),
                                    Text(
                                      snapshot.data['supported_count'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24
                                          //color: Colors.blue
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(2),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color(0xfff5f6fa),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Last supported content",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                            Text(
                                snapshot.data['support_content'])
                          ],
                        )),
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Support History",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 3),
                                  child: isRefresh == true
                                      ? Text(
                                          "Loading...",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        )
                                      : Text(""),
                                ),
                                GestureDetector(
                                  child: Icon(EvaIcons.refresh),
                                ),
                              ],
                            )
                          ],
                        )),
                    SizedBox(height: 10),
                    snapshot.data['history'] != null ? Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data['history'].length,
                          itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(2),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Color(0xfff5f6fa),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data['history'][index]['date'].toDate().day.toString()
                                + "/" + snapshot.data['history'][index]['date'].toDate().month.toString()
                                + "/" + snapshot.data['history'][index]['date'].toDate().year.toString(),
                                textScaleFactor: 1.0
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  snapshot.data['history'][index]['content'],
                                  textScaleFactor: 1.0,
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              )
                            ],
                          ),
                        );
                        }
                    )): Container()
                  ] ,
                ),
              );
            }),
      ),
    );
  }
}
