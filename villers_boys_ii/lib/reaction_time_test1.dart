
import 'package:flutter/material.dart';
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
  ReactionTestState(this.user, {Key? key});
  final User user;
  int startTime = DateTime.now().millisecondsSinceEpoch;
  bool shownIntro = false;
  int _tnum = 0; // Test number

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
    if (true) {
      setState(() {
        Widget build(BuildContext context) {
          return MaterialApp(home: ReactionTimeIntro(user: user));
        }
      });
    }
    double WIDTH = (MediaQuery.of(context).size.width) / 2;
    double HEIGHT = (MediaQuery.of(context).size.height) / 6;
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Test: $_tnum",
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        )),
        body: Center(
              child: Stack(children: [
                Positioned(
                  left: Random().nextDouble() * (MediaQuery.of(context).size.width - 100 - (100)) + 100,
                  bottom: Random().nextDouble() * ((MediaQuery.of(context).size.height - 100) - (100)) + 100,

                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(

                      onPressed: (){
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

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MemoryTestIntro(user: widget.user)));
                          }
                        });
                      }, child: const Icon(
                      Icons.close_rounded,
                    ),
                    ),
                  )
                ),
              ],)

        ));
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