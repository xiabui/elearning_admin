import 'package:elearningadmin/views/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;
  List<BasicEvent> _sampleData = [
    BasicEvent(
        id: 0,
        color: Colors.red,
        title: "A",
        start: LocalDateTime.now(),
        end: LocalDateTime.now() + Period(hours: 5),
        ),
    BasicEvent(
        id: 1,
        color: Colors.blue,
        title: "B",
        start: LocalDateTime.now() + Period(hours: 5),
        end: LocalDateTime.now() + Period(hours: 10),
        ),
    BasicEvent(
        id: 2,
        color: Colors.green,
        title: "C",
        start: LocalDateTime.now() + Period(hours: 10),
        end: LocalDateTime.now() + Period(hours: 15),
        )
  ];

  @override
  void initState() {
    super.initState();
    _controller = TimetableController(
      eventProvider: EventProvider.list(_sampleData),
      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(3),
      firstDayOfWeek: DayOfWeek.monday,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Lịch và sự kiện", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () => _controller.animateToToday(),
            tooltip: 'Jump to today',
          ),
        ],
      ),
      body: Timetable<BasicEvent>(
        controller: _controller,
        theme: TimetableThemeData(totalDateIndicatorHeight: 90),
        onEventBackgroundTap: (start, isAllDay) {
          _showSnackBar('Background tapped $start is all day event $isAllDay');
        },
        eventBuilder: (event) {
          return BasicEventWidget(
            event,
            onTap: () => displayBottomSheet(context, event),
          );
        },
        allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
          event,
          info: info,
          onTap: () => _showSnackBar('All-day event $event tapped'),
        ),
      ),
    );
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("content"),
    ));
  }

  void displayBottomSheet(BuildContext context, BasicEvent event) {
    String timeStart = "${event.start.hourOfDay}:${event.start.minuteOfHour}";
    String timeEnd = "${event.end.hourOfDay}:${event.end.minuteOfHour}";
    String dateEvent =
        "${event.start.dayOfWeek}, ${event.start.dayOfMonth}/${event.start.monthOfYear}/${event.start.yearOfEra}";
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Text("From $timeStart to $timeEnd",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber)),
                            Spacer(),
                            Text(dateEvent,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ],
                        ),
                        Divider(),
                        Text(
                          "hello",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("MARK AS DONE",
                        style: TextStyle(color: Colors.white)),
                    color: Color(0xff1a3f77),
                  ),
                )
              ],
            ),
          );
        });
  }
}
