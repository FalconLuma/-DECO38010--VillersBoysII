// ignore_for_file: file_names, camel_case_types, unnecessary_new

import 'package:flutter/material.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/newStartPrompt.dart';

import 'package:villers_boys_ii/user.dart';

import 'StartCalibrate.dart';

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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name == 'preDrive') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                        title: 'Fatigue Management App',
                        user: User("kevin", 32, 32, 32),
                        index: 1,
                      )),
                      (route) => false);
            } else if (ModalRoute.of(context)?.settings.name == 'edit') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                        title: 'Fatigue Management App',
                        user: User("kevin", 32, 32, 32),
                        index: 2,
                      )),
                      (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          StartCalibratePage(user: User("kevin", 32, 32, 32))),
                      (route) => false);
            }
          },
        ),
      ),
      body: newStartPrompt(user: widget.user, flag: widget.flag),

    );
  }
}
