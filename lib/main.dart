import 'package:elearningadmin/views/dashboard.dart';
import 'package:elearningadmin/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/activity_log.dart';
import 'views/account_tool.dart';
import 'views/infomation.dart';
import 'views/calendar.dart';
import 'package:time_machine/time_machine.dart';

void main() async {
  // Call these two functions before `runApp()`.
  WidgetsFlutterBinding.ensureInitialized();
  await TimeMachine.initialize({'rootBundle': rootBundle});

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark
    ));
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'E-Learning Dashboard',
      home: LoginForm(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          //fontFamily: 'Quicksand'
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  var bodyWidget = [DashboardPage(), ActivityLogs(), CalendarPage(), AccountTools(), InformationPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardPage(),
    );
  }
}
