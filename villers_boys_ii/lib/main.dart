import 'package:flutter/material.dart';

import 'package:villers_boys_ii/user.dart';

import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/driving_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DECO3801 Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DrivingPage(title: 'Driving Page', restInterval: Duration(seconds: 5))
      //home: MainPage(title: 'Fatigue Management App', user: User("Jacob", 32, 64, 128)),
    );
  }
}
