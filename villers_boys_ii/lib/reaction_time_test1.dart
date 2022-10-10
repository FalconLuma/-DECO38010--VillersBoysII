import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/user.dart';
import 'package:collection/collection.dart';
import 'dart:math';

import 'StartCalibrate.dart';
import 'main_page.dart';
import 'memory_test_intro.dart';

class ReactionTimeTest extends StatefulWidget {
  ReactionTimeTest(
      {Key? key,
      required this.user,
      required this.calibrate,
      this.driveAssessment})
      : super(key: key);
  final User user;
  final bool calibrate;
  DriveAssessment? driveAssessment;

  @override
  State<ReactionTimeTest> createState() => _ReactionTestState();
}

class _ReactionTestState extends State<ReactionTimeTest> {
  late SharedPreferences prefs;
  bool shownIntro = false;
  int _tNum = 0; // Test number
  bool calibrate = false;

  // Create a list of reaction times
  List<int> rTimes = List.filled(10, 0, growable: true);

  @override
  Widget build(BuildContext context) {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    double buttonWidth = 50;

    // Screen size. Account for status bar, app bar, and button width for height.
    double width = MediaQuery.of(context).size.width - buttonWidth;
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        buttonWidth;

    // Margins for button locations.
    double margin = 0.05;

    // Button locations.
    double left =
        margin * width + Random().nextDouble() * (width - 2 * margin * width);
    double top = margin * height +
        Random().nextDouble() * (height - 2 * margin * height);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Test: ${_tNum + 1}/10 ",
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name == 'preDrive') {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              title: 'Fatigue Management App',
                              user: User("kevin", 32, 32, 32),
                              index: 1,
                            )),
                    (route) => false);
              } else if (ModalRoute.of(context)?.settings.name == 'edit') {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              title: 'Fatigue Management App',
                              user: User("kevin", 32, 32, 32),
                              index: 2,
                            )),
                    (route) => false);
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => StartCalibratePage(
                            user: User("kevin", 32, 32, 32))),
                    (route) => false);
              }
            },
          ),
        ),
        body: Stack(children: <Widget>[
          Positioned(
              left: left,
              top: top,
              child: SizedBox(
                  width: buttonWidth,
                  height: buttonWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      int endTime = DateTime.now().millisecondsSinceEpoch;
                      rTimes[_tNum] = endTime - startTime;
                      if (_tNum < 9) {
                        // Set the state to new button location for each test.
                        setState(() {
                          _tNum++;
                        });
                        debugPrint(rTimes.toString());
                      } else {
                        //Disregard two smallest reaction time measurements
                        rTimes.remove(rTimes.min);
                        rTimes.remove(rTimes.min);

                        //Disregard two largest reaction time measurements
                        rTimes.remove(rTimes.max);
                        rTimes.remove(rTimes.max);

                        //Calculate average
                        double average = rTimes.average;
                        debugPrint(rTimes.toString());
                        debugPrint("Your average reaction time is: $average");

                        //Put this in an if statement to only run if its a setup/calibration version
                        if (widget.calibrate == false) {
                          save(average);
                        } else {
                          widget.driveAssessment?.setReactionTime(average);
                        }

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MemoryTestIntro(
                                  user: widget.user,
                                  calibrate: widget.calibrate,
                                  driveAssessment: widget.driveAssessment,
                                ),
                            settings: RouteSettings(
                                name: ModalRoute.of(context)!.settings.name)));
                      }
                    },
                    child: const Icon(Icons.close_rounded),
                  )))
        ]));
  }

  /// Save the user's baseline reaction test time to the device.
  save(average) async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setDouble("reaction", 0.0);
    prefs.setDouble("reactionTemp", average);
  }
}
