import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/reaction_time_intro.dart';
import 'package:villers_boys_ii/user.dart';
import 'package:collection/collection.dart';
import 'dart:math';
import 'dart:async';

import 'memory_test_intro.dart';

class ReactionTimeTest extends StatefulWidget {
  const ReactionTimeTest({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ReactionTimeTest> createState() => ReactionTestState(user);
}

class ReactionTestState extends State<ReactionTimeTest> {
  late SharedPreferences prefs;
  ReactionTestState(this.user, {Key? key});
  final User user;
  bool shownIntro = false;
  int _tnum = 0; // Test number
  bool calibrate = false;

  // Create a list of reaction times
  List<int> rTimes = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  @override
  Widget build(BuildContext context) {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    if (true) {
      setState(() {
        Widget build(BuildContext context) {
          return MaterialApp(home: ReactionTimeIntro(user: user));
        }
      });
    }
    double WIDTH = (MediaQuery.of(context).size.width) / 2;
    double HEIGHT = (MediaQuery.of(context).size.height) / 6;
    double left =
        Random().nextDouble() * (MediaQuery.of(context).size.width - 100);
    double top =
        Random().nextDouble() * (MediaQuery.of(context).size.height - 100);

    //Check to make sure values aren't less than 150 i.e. button can appear off-screen
    // if (left < 150) {
    //   left = 150;
    // }
    if (top < 0) {
      top = 0;
    }
    //Check to make sure values aren't within 150 pixels of edge of screen
    // if (left > (MediaQuery.of(context).size.width - 150)) {
    //   left = MediaQuery.of(context).size.width - 150;
    // }
    if (top > (MediaQuery.of(context).size.height)) {
      top = MediaQuery.of(context).size.height;
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Test: ${_tnum + 1} ",
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        )),
        body: Center(
            child: Stack(
          children: [
            Positioned(
                left: left,
                top: top,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      int endTime = DateTime.now().millisecondsSinceEpoch;
                      rTimes[_tnum] = endTime - startTime;
                      setState(() {
                        if (_tnum < 9) {
                          _tnum++;
                        } else {
                          //Disregard two smallest reaction time measurements
                          rTimes.removeAt(getMin(rTimes));
                          rTimes.removeAt(getMin(rTimes));
                          //Disregard two largest reaction time measurements
                          rTimes.removeAt(getMax(rTimes));
                          rTimes.removeAt(getMax(rTimes));
                          //Calculate average
                          double average = rTimes.average;
                          debugPrint(rTimes.toString());
                          debugPrint("Your average reaction time is: $average");
                          //Put this in an if statment to only run if its a setup/calibration version
                          debugPrint(calibrate.toString());
                          if (calibrate == false) {
                            save(average);
                            debugPrint(calibrate.toString());
                          }
                          debugPrint("End 1");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MemoryTestIntro(user: widget.user)));
                        }
                      });
                    },
                    child: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                )),
          ],
        )));
  }

  save(average) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble("reaction", average);
    calibrate = prefs.getBool('calibrate') ?? false;
  }
}
//Navigator.of(context).push(MaterialPageRoute(
//   builder: (context) => MemoryTestIntro(user: widget.user)));

// Timer(Duration(milliseconds: 1000), () {
// setState(() {
//
// });
// })
getMin(List rTimes) {
  int minIndex = 0;
  for (int i = 0; i < rTimes.length; i++) {
    if (rTimes[i] <= rTimes[minIndex]) {
      minIndex = i;
    }
  }
  return minIndex;
}

getMax(List rTimes) {
  int maxIndex = 0;
  for (int i = 0; i < rTimes.length; i++) {
    if (rTimes[i] >= rTimes[maxIndex]) {
      maxIndex = i;
    }
  }
  return maxIndex;
}
