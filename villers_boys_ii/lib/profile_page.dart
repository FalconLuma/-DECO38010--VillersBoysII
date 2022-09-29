import 'dart:math';
import 'package:flutter/material.dart';
import 'package:villers_boys_ii/StartCalibrate.dart';
import 'package:villers_boys_ii/newStart.dart';

import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Profile',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * HEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Text(widget.user.getUserName())),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Text(widget.user.getAge().toString())),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Text(
                'Calibrated Performance',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height *
                        SUBHEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
              child: Text(
                'Reaction: ${widget.user.getReactionBaseline().toString()}',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 15, right: 16, bottom: 30),
              child: Text(
                'Memory: ${widget.user.getMemoryBaseline().toString()}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        StartCalibratePage(user: widget.user)));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: Text(
                'Recalibrate Reaction/Memory',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height *
                        MENU_BUTTON_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => newStart(
                          user: widget.user,
                          flag: false,
                        )));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: Text(
                'Edit Name/Age',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height *
                        MENU_BUTTON_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
