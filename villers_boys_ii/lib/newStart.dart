// ignore_for_file: file_names, camel_case_types, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/profile_page.dart';

import 'package:villers_boys_ii/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This page lets the user enter a
//user name and age which can be used
//in the calibration/reseting profile process

class newStart extends StatefulWidget {
  const newStart({Key? key, required this.user, required this.flag})
      : super(key: key);

  final User user;
  final bool flag;

  @override
  State<newStart> createState() => _newStartPageState();
}

class _newStartPageState extends State<newStart> {
  late SharedPreferences prefs;
  final name2 = new TextEditingController();
  final age2 = TextEditingController();
  String name = "";
  int age = 0;
  double memoryBase = 0.0;
  double reactionBase = 0.0;
  String message = "Please enter your name and age to finish your profile";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "User Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "UserName",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                ),
                controller: name2,
                onSubmitted: (userName) {
                  setState(() {
                    widget.user.setUserName(userName);
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "age",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "CurrentAge",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: age2,
                onSubmitted: (userName) {
                  setState(() {
                    widget.user.setUserName(userName);
                  });
                },
              ),
              Text(
                message,
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  if (name2.text.toString().isEmpty ||
                      age2.text.toString().isEmpty) {
                    message =
                        "Please ensure both boxes have been filled out to continue";
                    setState(() {});
                  } else {
                    save();
                    if (widget.flag == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MainPage(
                                title: 'Fatigue Managment App',
                                user: User(name, age, reactionBase, memoryBase),
                                index: 1,
                              )));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MainPage(
                                title: 'Fatigue Managment App',
                                user: User(name, age, reactionBase, memoryBase),
                                index: 2,
                              )));
                    }
                  }
                },
              ),
            ],
          )),
    );
  }

  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("username", name2.text.toString());
    prefs.setInt("age", int.parse(age2.text));
    retrieve();
  }

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString("username")!;
    age = prefs.getInt("age")!;
    reactionBase = prefs.getDouble('reaction') ?? 0.0;
    memoryBase = prefs.getDouble('memory') ?? 0.0;
    setState(() {});
  }

  delete() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("username");

    name = "";
    setState(() {});
  }
}
