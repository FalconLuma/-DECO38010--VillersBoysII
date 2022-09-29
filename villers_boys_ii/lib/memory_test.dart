import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/home_page.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/newStart.dart';
import 'package:villers_boys_ii/profile_page.dart';
import 'package:villers_boys_ii/results_page.dart';
import 'package:villers_boys_ii/user.dart';

class MemoryTest extends StatefulWidget {
  const MemoryTest({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<MemoryTest> createState() => _MemoryTest();
}

class _MemoryTest extends State<MemoryTest> {
  late SharedPreferences prefs;
  double reaction = 0;
  double memory = 0;
  String name = "";
  int age = 0;

  bool calibrate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Memory Test",
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        )),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              save(5.8);
              if (calibrate == false &&
                  (widget.user.getUserName() == "Jacob" ||
                      widget.user.getAge() == 32)) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => newStart(
                          user: widget.user,
                          flag: true,
                        )));
              } else if (calibrate == false) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainPage(
                          title: 'Fatigue Managment App',
                          user: User(name, age, reaction, memory),
                          index: 2,
                        )));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResultsPage(user: widget.user)));
              }
            },
            child: const Icon(
              Icons.start_sharp,
              size: 50,
            ),
          ),
        ));
  }

  save(average) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble("memory", average);
    name = prefs.getString('username') ?? "";
    age = prefs.getInt('age') ?? 0;
    calibrate = prefs.getBool('calibrate') ?? false;
    reaction = prefs.getDouble('reaction') ?? 0.0;
    memory = prefs.getDouble('memory') ?? 0.0;
  }
}
