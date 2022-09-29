import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/StartCalibrate.dart';

import 'package:villers_boys_ii/user.dart';

import 'package:villers_boys_ii/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  String name = "";
  int age = 0;
  double memoryBase = 0;
  double reactionBase = 0;
  bool calibrated = false;

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('username') ?? "";
    age = prefs.getInt('age') ?? 0;
    memoryBase = prefs.getDouble('memory') ?? 0;
    reactionBase = prefs.getDouble('reaction') ?? 0.0;
    calibrated = prefs.getBool('calibrate') ?? false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint("Hello world");
    return MaterialApp(
        title: 'DECO3801 Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: check());
  }

  Widget check() {
    debugPrint("Called");
    loadData();
    if (calibrated == false) {
      debugPrint("This runs first");
      return StartCalibratePage(user: User("Jacob", 32, 64, 128));
    } else {
      debugPrint(calibrated.toString());
      debugPrint("This runs if calibrated");
      return MainPage(
        title: 'Fatigue Management App',
        user: User("Jacob", 32, 64, 128),
        index: 1,
      );
    }
  }
}
