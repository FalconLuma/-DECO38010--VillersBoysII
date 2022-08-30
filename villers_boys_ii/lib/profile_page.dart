import 'package:flutter/material.dart';

import 'package:villers_boys_ii/user.dart';

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
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
            ),

            TextField(
              decoration: InputDecoration(
                labelText: "User Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: widget.user.getUserName(),
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
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
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
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

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Text(
                'Calibrated Performance',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
              child: Text(
                'Reaction: ${widget.user.getReactionBaseline().toString()}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 30),
              child: Text(
                'Memory: ${widget.user.getMemoryBaseline().toString()}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: const Text(
                'Recalibrate',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: const Text(
                'Reset Profile',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}