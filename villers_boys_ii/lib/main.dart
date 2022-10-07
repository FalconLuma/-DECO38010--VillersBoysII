import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/StartCalibrate.dart';
import 'package:villers_boys_ii/constants.dart';

import 'package:villers_boys_ii/user.dart';

import 'package:villers_boys_ii/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  String name = "";
  int age = 0;
  double memoryBase = 0;
  double reactionBase = 0;
  bool calibrated = false;
  bool loaded = false;

  /// Load the data of the user saved on the device into the respective
  /// instance variables.
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username') ?? "";
      age = prefs.getInt('age') ?? 0;
      memoryBase = prefs.getDouble('memory') ?? 0;
      reactionBase = prefs.getDouble('reaction') ?? 0.0;
      calibrated = prefs.getBool('calibrate') ?? false;
      loaded = true;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (loaded == false) {
      loadData();
      // Loading Screen
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder Icon, replace with TYRED logo when avaliable
                Icon(
                  Icons.circle,
                  color: darkBlue,
                  size: 300,
                ),
                Text(
                  "TYRED",
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Inter',
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return MaterialApp(
        title: 'DECO3801 Project',
        theme: ThemeData(
          primarySwatch: primary,
          scaffoldBackgroundColor: neutral,
          fontFamily: 'Inter',
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
              iconTheme: IconThemeData(
                color: darkBlue,
              )
          ),
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor:Colors.white,
          )
        ),
        home: check());
  }

  /// If it's the user's first time opening the app, take them through
  /// calibration and setting up a new user. Otherwise, just return the main
  /// page.
  Widget check() {
    if (calibrated == false) {
      return StartCalibratePage(user: User("Jacob", 32, 64, 128));
    } else {
      return MainPage(
        title: 'Fatigue Management App',
        user: User("Jacob", 32, 64, 128),
        index: 1,
      );
    }
  }
}
