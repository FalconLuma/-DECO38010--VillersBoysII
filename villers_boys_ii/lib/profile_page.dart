import 'dart:math';
import 'package:flutter/material.dart';

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
              padding: EdgeInsets.all(15),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height*HEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "User Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: widget.user.getUserName(),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height*BODY_TEXT_SIZE
                ),
              ),
              controller: userNameController,
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
                  fontSize: MediaQuery.of(context).size.height*BODY_TEXT_SIZE
                ),
              ),
              keyboardType: TextInputType.number,
              controller: ageController,
              onSubmitted: (age) {
                setState(() {
                  widget.user.setAge(int.parse(age));
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Text(
                'Calibrated Performance',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height*SUBHEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
              child: Text(
                'Reaction: ${widget.user.getReactionBaseline().toString()}',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height*BODY_TEXT_SIZE),
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
                setState(() {
                  // Temporary implementation
                  widget.user.setReactionBaseline(16.0 + Random().nextInt(256));
                  widget.user.setMemoryBaseline(16.0 + Random().nextInt(256));
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: Text(
                'Recalibrate',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Temporary implementation
                  widget.user.reset();
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: Text(
                'Reset Profile',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
