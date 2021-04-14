import 'package:flutter/material.dart';
import 'package:inertia/strings.dart';
import 'package:inertia/states_manager.dart';
import 'package:inertia/meeting.dart';
import 'package:inertia/task_editor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "InerTia",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.black,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.black,
        unselectedWidgetColor: Colors.blue.shade900,
      ),
      home: MyHomePage(title: "InerTia"),
    );
  }
}

class TimeBlockDataSource extends CalendarDataSource {
  TimeBlockDataSource(List<Meeting> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  String getNotes(int index) => appointments![index].description;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Meeting> appointments;
  // CalendarDataSource _dataSource = new TimeBlockDataSource();

  List<Meeting> getMeetingDetails() {
    final List<Meeting> meetingCollection = <Meeting>[];

    final DateTime today = DateTime.now();
    for (int month = -1; month < 2; month++) {
      for (int day = -5; day < 5; day++) {
        for (int hour = 9; hour < 18; hour += 5) {
          meetingCollection.add(Meeting(
            from: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour)),
            to: today
              .add(Duration(days: (month * 30) + day))
              .add(Duration(hours: hour + 2)),
            background: Colors.greenAccent,
            description: "Example Event",
            eventName: "SuperCool Festival",
          ));
        }
      }
    }

    return meetingCollection;
  }

  @override
  void initState() {
    super.initState();
    appointments = getMeetingDetails();
  }

  void autopilotTapped() {
    setState(() {
      Navigator.push<Widget>(
        context,
        MaterialPageRoute(builder: (BuildContext context) => TaskEditor()),
      );
    });
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }
    setState(() {
      Navigator.push<Widget>(
        context,
        MaterialPageRoute(builder: (BuildContext context) => TaskEditor()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(""),
          flexibleSpace: Image.asset("assets/images/logo1.png"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "CAPTURE"),
              Tab(text: "AUTOPILOT"),
              Tab(text: "GOALS"),
              Tab(text: "MOSQUITO"),
              Tab(text: "ABOUT"),
              Tab(text: "ACCOUNT"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text("\nFULL CAPTURE\n", style: TextStyle(color: Color.fromRGBO(175, 238, 238, 1), fontSize: 50)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 0.5),
                        top: BorderSide(color: Colors.blue, width: 0.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text("Use InerTia app", style: TextStyle(color: Colors.white70, fontSize: 20)),
                          value: States.firstCheckboxSelected,
                          onChanged: (bool? changed) {
                            setState(() {
                              States.firstCheckboxSelected = changed!;
                            });
                          },
                          checkColor: Colors.black,
                          activeColor: Colors.blue.shade900,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text("\nSCHEDULE", style: TextStyle(color: Color.fromRGBO(175, 238, 238, 1), fontSize: 50)),
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 500.0,
                          child: SfCalendarTheme(
                            data: SfCalendarThemeData(
                              brightness: Brightness.dark,
                              backgroundColor: Colors.black,
                            ),
                            child: SafeArea(child:
                            SfCalendar(
                                view: States.currentView,
                                showNavigationArrow: true,
                                firstDayOfWeek: 1,
                                showDatePickerButton: true,
                                allowViewNavigation: true,
                                allowedViews: <CalendarView>
                                [
                                  CalendarView.day,
                                  CalendarView.week,
                                  CalendarView.month,
                                  CalendarView.schedule,
                                ],
                                onTap: calendarTapped,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white, size: 35),
                    label: Text("New Autopilot ", style: TextStyle(color: Colors.white, fontSize: 35)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(250, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: autopilotTapped,
                  ),
                ],
              ),
            ),
            Center(
              child: Text("Goals", style: TextStyle(color: Colors.white60)),
            ),
            Center(
              child: Text("Mosquito", style: TextStyle(color: Colors.white60)),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Column(
                children: [
                  Text(Strings.aboutUsTitle, style: TextStyle(color: Color.fromRGBO(175, 238, 238, 1), fontSize: 30, fontWeight: FontWeight.bold)),
                  Text(Strings.aboutUs, style: TextStyle(color: Color.fromRGBO(144, 252, 249, 1), fontSize: 20)),
                  Image.asset("assets/images/shatter19.gif"),
                ],
              ),
            ),
            Center(
              child: Text("Account", style: TextStyle(color: Colors.white60)),
            ),
          ],
        ),
      ),
    );
  }
}
