import 'package:elearningadmin/views/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'widgets/add_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/log_detail.dart';

class ActivityLogs extends StatefulWidget {
  @override
  _ActivityLogsState createState() => _ActivityLogsState();
}

class _ActivityLogsState extends State<ActivityLogs> {

  String number = "8";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firestore.instance.collection('support_logs').snapshots()..then((rr){
    //   setState(() {
    //     number = rr.leght.toString();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Nhật ký",
          style: TextStyle(
            color: Colors.black
          )
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddLog()));
        },
        backgroundColor: Color(0xff1a3f77),
        child: Icon(EvaIcons.plus),
      ),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xfff5f6fa),
                  //border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Suppported Today",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      number,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "List of Supported",
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection('support_logs').orderBy("lastest").snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData ?
                  Center(
                    child: Text("Loading...")
                  ) :
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index)=>_buildItems(context, snapshot.data.documents[index]),
                  );
                }
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _buildItems(BuildContext context, document) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogDetail(userid: document['userid'],)));
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color(0xfff5f6fa),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff1a3f77),
                ),
                child: Center(
                  child: Text(
                    document['userid'][0] + document['userid'][1],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  document['name'].length > 16 ? document['name'].substring(0,document['name'].length - 5) + "..." : document['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  document['userid'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff1a3f77)),
                ),
                Text("Lastest: " + document['lastest'].toDate().day.toString()+"/"+document['lastest'].toDate().month.toString() + "/" + document['lastest'].toDate().year.toString()),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
