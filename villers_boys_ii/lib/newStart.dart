// ignore_for_file: file_names, camel_case_types, unnecessary_new

import 'package:flutter/material.dart';
import 'package:villers_boys_ii/newStartPrompt.dart';
import 'package:villers_boys_ii/simple_appbar.dart';
import 'package:villers_boys_ii/user.dart';

//This page lets the user enter a
//user name and age which can be used
//in the calibration/resetting profile process
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
      appBar: SimpleAppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        text: "Edit Profile",
        showExitButton: ModalRoute.of(context)?.settings.name == 'preDrive' ||
            ModalRoute.of(context)?.settings.name == 'edit',
        user: widget.user
      ),
      body: SingleChildScrollView (
        child: newStartPrompt(
          user: widget.user,
          flag: widget.flag
        ),
      )
    );
  }
}
