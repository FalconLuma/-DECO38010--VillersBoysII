// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:villers_boys_ii/reaction_time1.dart';
import 'package:villers_boys_ii/user.dart';

import 'constants.dart';

class StartCalibratePage extends StatefulWidget {
  const StartCalibratePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<StartCalibratePage> createState() => _StartCalibrateState();
}

class _StartCalibrateState extends State<StartCalibratePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fatigue Management App'),
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Text(
                'Welcome to Tyred, to complete the calibration sequence'
                ' you will need to complete a reaction test and a memory test.'
                'Instructions on how these tests work will be present before you begin each test.'
                'Please ensure that you only run these tests if you are currently not fatigued.',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    letterSpacing: 2.0)),
            ElevatedButton(
              onPressed: () {
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
              child: const Text('Begin'),
            )
          ])),
    );
  }
}
