import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:villers_boys_ii/user.dart';

import 'constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences prefs;
  String message = "Device Not Found!";
  String message2 = "";

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Smart Seatbelt Status',
              style: TextStyle(
                  fontSize:
                      MediaQuery.of(context).size.height * HEADING_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              message,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height *
                      SUBHEADING_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
            child: Text(
              message2,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height *
                      SUBHEADING_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  message2 = "SMRTBLT1304";
                  message = "Potential Device Found";
                  save(message, message2);
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: Text(
                'Search For Device',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height *
                        MENU_BUTTON_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                message = "Connected to Device";
                save(message, message2);
              });
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            child: Text(
              'Connect To Device',
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

  /// Load the saved values of the messages on the device into the respective
  /// instance variables.
  loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      message = prefs.getString('message') ?? "Device Not Found";
      message2 = prefs.getString('message2') ?? "";
      if (message == "Device Not Found" && message2.isEmpty) {
        prefs.setString('message', "Device Not Found!");
        prefs.setString('message2', "");
      }
    });
  }

  /// Save the current values of the messages to the device.
  save(message, message2) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("message", message);
    prefs.setString("message2", message2);
  }
}
