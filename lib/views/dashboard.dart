import 'dart:math';
import 'package:elearningadmin/service/api_services.dart';
import 'package:elearningadmin/views/widgets/app_drawer.dart';
import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChartsData {
  final int counter;
  ChartsData({this.counter});
  factory ChartsData.fromJson(Map<int, dynamic> jsonData) {
    return ChartsData(counter: jsonData['counter']);
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static List<double> chartData = [0, 0, 0, 0, 0, 0];
  final spinkit = SpinKitChasingDots(
    color: Color(0xff1a3f77),
    size: 50,
  );

  bool isLoaded = false;
  static DateTime _date = new DateTime.now();
  String _dateFrom = '${_date.month}/${_date.day}/${_date.year}',
      dateShowed = '${_date.day}/${_date.month}/${_date.year}',
      datepicked;
  var min, sec;
  Color _themeColor = Color(0xff1a3f77);

  @override
  void initState() {
    //_getChartData();
    setState(() {
      isLoaded = true;
      min = _date.minute;
      sec = _date.second;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var countUser = [
    //   new SupportPerWeek('06:00 - 09:00', chartData[0]),
    //   new SupportPerWeek('09:00 - 12:00', chartData[1]),
    //   new SupportPerWeek('12:00 - 15:00', chartData[2]),
    //   new SupportPerWeek('15:00 - 18:00', chartData[3]),
    //   new SupportPerWeek('18:00 - 21:00', chartData[4]),
    //   new SupportPerWeek('21:00 - 00:00', chartData[5]),
    // ];

    var countUser = [
      new SupportPerWeek('06:00 - 09:00', 184),
      new SupportPerWeek('09:00 - 12:00', 121),
      new SupportPerWeek('12:00 - 15:00', 80),
      new SupportPerWeek('15:00 - 18:00', 136),
      new SupportPerWeek('18:00 - 21:00', 57),
      new SupportPerWeek('21:00 - 00:00', 17),
    ];

    var data = countUser;

    var series = [
      new charts.Series(
        domainFn: (SupportPerWeek sp, _) => sp.day,
        measureFn: (SupportPerWeek sp, _) => sp.supported,
        id: 'Support',
        data: data,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(_themeColor),
        labelAccessorFn: (SupportPerWeek sp, _) => '${sp.supported.toString()}',
      )
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
      vertical: false,

      //  domainAxis: new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );

    var chartWidget = new Container(
      margin: EdgeInsets.only(top: 5, bottom: 20),
      padding: EdgeInsets.all(5),
      child: SizedBox(
        height: 270,
        child: chart,
      ),
    );

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Trang chủ", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: SafeArea(
          //padding: EdgeInsets.all(15),
          //width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 110,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          //border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 3,
                              spreadRadius: -1,
                              offset: Offset(1, 1),
                            )
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Trực tuyến",
                                  ),
                                  Text(
                                    '${min + sec}',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: _themeColor),
                                  )
                                ]),
                            VerticalDivider(),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Giảng viên",
                                  ),
                                  Text(
                                    '${min}',
                                    style: TextStyle(
                                      fontSize: 32,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  )
                                ]),
                            VerticalDivider(),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sinh viên",
                                  ),
                                  Text(
                                    '${sec}',
                                    style: TextStyle(
                                      fontSize: 32,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  )
                                ]),
                          ]),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15.0),
                      child: Container(
                        //margin: EdgeInsets.all(15),
                        width: double.infinity,
                        //height: 90,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            //border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3,
                                spreadRadius: -1,
                                offset: Offset(1, 1),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.only(left: 10),
                              width: double.infinity,
                              child: Text(
                                "Lượng Truy Cập Ngày " + dateShowed,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(),
                            Container(
                                child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                  Text('Tổng lượng truy cập:   '),
                                  Text(
                                    '${chartData[0].toInt() + chartData[1].toInt() + chartData[2].toInt() + chartData[3].toInt() + chartData[4].toInt() + chartData[5].toInt()}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                            isLoaded == false ? spinkit : chartWidget,
                            Divider(),
                            Column(children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: Text("Chọn ngày để lọc:"),
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 4.0,
                                onPressed: () {
                                  showDialog(
                                      useSafeArea: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Cancel")),
                                              FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _dateFrom = datepicked;
                                                      dateShowed = datepicked;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Okay",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ],
                                            content: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              //height: 500,
                                              child: CalendarDatePicker(
                                                  initialDate: _date,
                                                  firstDate:
                                                      DateTime(2016, 01, 01),
                                                  lastDate: _date,
                                                  onDateChanged: (date) {
                                                    setState(() {
                                                      print(date);
                                                      datepicked =
                                                          '${date.month}/${date.day}/${date.year}';
                                                    });
                                                  }),
                                            ));
                                      });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  alignment: Alignment.center,
                                  //height: 50.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.date_range,
                                                  size: 18.0,
                                                  color: _themeColor,
                                                ),
                                                Text(
                                                  dateShowed,
                                                  style: TextStyle(
                                                      color: _themeColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.white,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    CountSomthing(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    setState(() {
      min = now.minute;
      sec = now.second;
    });
  }

  // void _getChartData() {
  //   var data = requestCountUsageAPI(context, _dateFrom);
  //   data.then((value) {
  //     setState(() {
  //       chartData[0] = value.sixToNineAM;
  //       chartData[1] = value.nineToTwelveAM;
  //       chartData[2] = value.twelveToThreePM;
  //       chartData[3] = value.threeToSixPM;
  //       chartData[4] = value.sixToNinePM;
  //       chartData[5] = value.nineToTwelvePM;
  //       print(chartData[3]);
  //     });
  //   }).catchError((er) {
  //     print(er);
  //   });
  // }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, 0);

    ovalPath.quadraticBezierTo(
        width * 0.6, height * -0.5, width * 0.65, height * 0.25);

    ovalPath.quadraticBezierTo(width * 0.65, height * 0.5, 0, height * 0.5);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Color(0xff1a3f77);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class CountSomthing extends StatefulWidget {
  @override
  _CountSomthingState createState() => _CountSomthingState();
}

class _CountSomthingState extends State<CountSomthing> {
  static List<double> chartData = [0, 0, 0, 0, 0, 0];
  final spinkit = SpinKitChasingDots(
    color: Color(0xff1a3f77),
    size: 50,
  );

  bool isLoaded = false;
  static DateTime _date = new DateTime.now();
  String _dateFrom = '${_date.month}/${_date.day}/${_date.year}',
      dateShowed = '${_date.day}/${_date.month}/${_date.year}';
  Color _themeColor = Color(0xff1a3f77);

  @override
  void initState() {
    super.initState();
    //_getChartData();
  }

  @override
  Widget build(BuildContext context) {
    // var countUser = [
    //   new SupportPerWeek('06:00 - 09:00', chartData[0]),
    //   new SupportPerWeek('09:00 - 12:00', chartData[1]),
    //   new SupportPerWeek('12:00 - 15:00', chartData[2]),
    //   new SupportPerWeek('15:00 - 18:00', chartData[3]),
    //   new SupportPerWeek('18:00 - 21:00', chartData[4]),
    //   new SupportPerWeek('21:00 - 00:00', chartData[5]),
    // ];

    var countUser = [
      new SupportPerWeek('06:00 - 09:00', 10),
      new SupportPerWeek('09:00 - 12:00', 5),
      new SupportPerWeek('12:00 - 15:00', 15),
      new SupportPerWeek('15:00 - 18:00', 8),
      new SupportPerWeek('18:00 - 21:00', 6),
      new SupportPerWeek('21:00 - 00:00', 2),
    ];

    var data = countUser;

    var series = [
      new charts.Series(
        domainFn: (SupportPerWeek sp, _) => sp.day,
        measureFn: (SupportPerWeek sp, _) => sp.supported,
        id: 'Support',
        data: data,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff1a3f77)),
        labelAccessorFn: (SupportPerWeek sp, _) => '${sp.supported.toString()}',
      )
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
      vertical: false,

      //  domainAxis: new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );

    var chartWidget = new Container(
      margin: EdgeInsets.only(top: 5, bottom: 20),
      padding: EdgeInsets.all(5),
      child: SizedBox(
        height: 270,
        child: chart,
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15.0),
      child: Container(
        //margin: EdgeInsets.all(15),
        width: double.infinity,
        //height: 90,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3,
                spreadRadius: -1,
                offset: Offset(1, 1),
              )
            ]),
        child: Column(
          children: <Widget>[
            Container(
              //padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              child: Text(
                "Lượng Hỗ Trợ Ngày " + dateShowed,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            // isLoaded == false ? spinkit :
            chartWidget,
            Divider(),
            Column(children: <Widget>[
              Container(
                width: double.infinity,
                child: Text("Chọn ngày để lọc:"),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  CalendarDatePicker(
                      initialDate: _date,
                      firstDate: DateTime(2016, 01, 01),
                      lastDate: _date,
                      onDateChanged: (date) {
                        setState(() {
                          _dateFrom = '${date.month}/${date.day}/${date.year}';
                          dateShowed = '${date.day}/${date.month}/${date.year}';
                          print(dateShowed);
                        });
                      });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  alignment: Alignment.center,
                  //height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: _themeColor,
                                ),
                                Text(
                                  dateShowed,
                                  style: TextStyle(
                                      color: _themeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // void _getChartData() {
  //   var data = requestCountUsageAPI(context, '5/2/2020');
  //   data.then((value) {
  //     setState(() {
  //       chartData[0] = value.sixToNineAM;
  //       chartData[1] = value.nineToTwelveAM;
  //       chartData[2] = value.twelveToThreePM;
  //       chartData[3] = value.threeToSixPM;
  //       chartData[4] = value.sixToNinePM;
  //       chartData[5] = value.nineToTwelvePM;
  //       print(chartData[3]);
  //       isLoaded = true;
  //     });
  //   }).catchError((er) {
  //     print("error while loading");
  //   });
  // }
}

class RatingView extends StatefulWidget {
  @override
  _RatingViewState createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(textColor: Colors.blue),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child:
          new FlutterLogo(style: FlutterLogoStyle.stacked, textColor: Colors.red),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(
          style: FlutterLogoStyle.horizontal, textColor: Colors.green),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child: new DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color = Color(0xff1a3f77);

  // The base size of the dots
  static const double _kDotSize = 5.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 20.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class SupportPerWeek {
  String day;
  double supported;

  SupportPerWeek(this.day, this.supported);
}
