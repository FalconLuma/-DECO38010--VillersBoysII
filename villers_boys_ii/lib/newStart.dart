// ignore_for_file: file_names, camel_case_types, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/main_page.dart';

import 'package:villers_boys_ii/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This page lets the user enter a
//user name and age which can be used
//in the calibration/reseting profile process
//Takes in a user and a flag (flag = true means return to home page,
// flag = false means return to profile page)
class newStart extends StatefulWidget {
  const newStart({Key? key, required this.user, required this.flag})
      : super(key: key);

  final User user;
  final bool flag;

  @override
  State<newStart> createState() => _newStartPageState();
}

class _newStartPageState extends State<newStart> {
  //Declare needed variables
  late SharedPreferences prefs;
  final name2 = new TextEditingController();
  final age2 = new TextEditingController();
  String name = "";
  int age = 0;
  double memoryBase = 0.0;
  double reactionBase = 0.0;
  String message = "Please enter your name and age to finish your profile";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Edit Profile"),
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "User Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.user.getUserName(),
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
                  labelText: "Age",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.user.getAge().toString(),
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
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    letterSpacing: 2.0),
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => MainPage(
                                    title: 'Fatigue Management App',
                                    user: User(
                                        name, age, reactionBase, memoryBase),
                                    index: 1,
                                  )),
                          (route) => false);
                      // Go to home page, and reset route stack
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => MainPage(
                                    title: 'Fatigue Management App',
                                    user: User(
                                        name, age, reactionBase, memoryBase),
                                    index: 2,
                                  )),
                          (route) => false
                          // Return to home page, and reset route stack
                          );
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
