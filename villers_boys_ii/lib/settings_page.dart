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

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(BORDER_RADIUS_CONTAINER)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    )]
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  //If the user has searched for a seatbelt show their options and their connected status
                    padding: const EdgeInsets.all(10),
                    child: Visibility(
                      visible: flag,
                      replacement: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text("No Devices Found",
                            style:TextStyle(fontSize: 27))],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            message2,
                            style: const TextStyle(fontSize: 27)),
                          SlidingSwitch(
                            value: connected,
                            height: 30,
                            width: 60,
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
                            background:connected? darkBlue : const Color(0xffe4e5eb),
                            textOff: '',
                            textOn: '',
                          ),
                        ]
                      ),
                    )),
              )

            ],
          ),
          //Implement the functionality for when the user searches for a seatbelt (this functionality is a mockup as no bluetooth functionality is implemented only hardcoded)
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  flag = true;
                  message2 = "SMRTBLT1304";
                  save(flag, message2, connected);
                });
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(
                    MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.07)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                ))
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE,
                  fontWeight: FontWeight.bold
                ),
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
