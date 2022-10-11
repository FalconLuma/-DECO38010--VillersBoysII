// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:villers_boys_ii/reaction_time1.dart';
import 'package:villers_boys_ii/simple_appbar.dart';
import 'package:villers_boys_ii/simple_button.dart';
import 'package:villers_boys_ii/simple_textbox.dart';
import 'package:villers_boys_ii/user.dart';

///This is the page the user sees if they first open the app
///or if they choose to re-calibrate their account

class StartCalibratePage extends StatefulWidget {
  const StartCalibratePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<StartCalibratePage> createState() => _StartCalibrateState();
}

class _StartCalibrateState extends State<StartCalibratePage> {
  String message = 'Welcome to Tyred, your driver fatigue assistance app.\n'
      '\nYou are about to complete our baseline TYRED calibration tests, consisting of both a reaction and memory test.\n'
      '\nYou must only perform the baseline calibration tests if you are not currently fatigued.\n'
      '\nIf you believe you are in a fit state to complete these tests, please click the button below.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        text: 'Fatigue Management App',
        showExitButton: ModalRoute.of(context)?.settings.name == 'preDrive' ||
            ModalRoute.of(context)?.settings.name == 'edit',
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            //Welcome message and information for the user
            SimpleTextBox(
                text: message
            ),
            SimpleButton(
              text: "Begin",
              onPressed: () {
                //Movement to next appropriate page
                String routeName = 'calibrate';
                if (ModalRoute.of(context)?.settings.name != null) {
                  routeName = ModalRoute.of(context)!.settings.name!;
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReactionTimePage(
                          user: widget.user,
                          calibrate: false,
                        ),
                    settings: RouteSettings(name: routeName)));
              },
            )
          ])),
    );
  }
}
