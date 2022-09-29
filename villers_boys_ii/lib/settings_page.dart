import 'package:flutter/material.dart';

import 'package:villers_boys_ii/user.dart';

import 'constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Settings',
              style: TextStyle(
                  fontSize:
                  MediaQuery.of(context).size.height * HEADING_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              'Smart Seatbelt Status:',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height *
                      SUBHEADING_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
            child: Text(
              'DEVICE NOT CONNECTED',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height *
                      SUBHEADING_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
          ),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            child: Text(
              'Connect Device',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height *
                      MENU_BUTTON_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
