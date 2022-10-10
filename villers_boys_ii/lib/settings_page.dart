import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_switch/sliding_switch.dart';

import 'package:villers_boys_ii/user.dart';

import 'constants.dart';

///This is the settings/smartseatbelt page
///This page allows the user to search for a seatbelt to connect to
///and connect or disconnect from a seatbelt

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences prefs;
  String message2 = "";
  bool connected = false;
  bool flag = false;
  final _ebHeight = 0.07;
  final _ebSidePad = 0.02;
  final _ebTopPad = 0.02;

  void _showRecommendations(BuildContext context) {
    /// Opens a dialog box to choose between pausing or resetting the timer
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "Smart Seatbelt",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height *
                    SUBHEADING_TEXT_SIZE /
                    1.2),
          ),
          backgroundColor: neutral,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * _ebSidePad,
                  right: MediaQuery.of(context).size.width * _ebSidePad,
                  top: MediaQuery.of(context).size.height * _ebTopPad),
              child: Text(
                //Information about the smart seatbelt
                "The Smart Seatbelt® device can connect to the TYRED app.\n"
                "\nVibration notifications are provided to you if dangerous levels of driver fatigue is detected by it's heart rate measuring technology.",
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * _ebSidePad,
                  right: MediaQuery.of(context).size.width * _ebSidePad,
                  top: MediaQuery.of(context).size.height * _ebTopPad),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * _ebHeight)),
                child: Text(
                  "Close",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height *
                          MENU_BUTTON_TEXT_SIZE),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Smart Seatbelt',
          softWrap: true,
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showRecommendations(context);
              },
              icon: ImageIcon(
                AssetImage(infoIconColour),
                size: 50,
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  //If the user has searched for a seatbelt show their options and their connected status
                  padding: const EdgeInsets.all(10),
                  child: Visibility(
                    visible: flag,
                    replacement: Row(
                      children: const [Text("No Devices Found")],
                    ),
                    child: Row(children: [
                      Text(message2),
                      SlidingSwitch(
                        value: connected,
                        onChanged: (bool value) {
                          setState(() {
                            //connected = true;
                            if (connected) {
                              connected = false;
                            } else {
                              connected = true;
                            }
                            save(flag, message2, connected);
                          });
                        },
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        textOff: "Disconnected",
                        textOn: "Connected",
                        colorOn: const Color(0xFF00FF00),
                        colorOff: const Color(0xFFFF0000),
                      ),
                    ]),
                  )),
            ],
          ),
          //Implement the functionality for when the user searches for a seatbelt (this functionality is a mockup as no bluetooth functionality is implemented only hardcoded)
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 200, right: 5, bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  flag = true;
                  message2 = "SMRTBLT1304";
                  save(flag, message2, connected);
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
        ],
      ),
    );
  }

  /// Load the saved values of the messages on the device into the respective
  /// instance variables.
  loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      message2 = prefs.getString('message2') ?? "";
      connected = prefs.getBool('connected') ?? false;
      flag = prefs.getBool("flag") ?? false;
      if (message2.isEmpty) {
        prefs.setString('message2', "");
      }
    });
  }

  /// Save the current values of the messages to the device.
  save(flag, thing, connected) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("flag", flag);
    prefs.setString("message2", thing);
    prefs.setBool("connected", connected);
  }
}
