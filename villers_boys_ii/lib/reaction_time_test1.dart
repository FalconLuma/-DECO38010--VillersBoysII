import 'package:flutter/material.dart';
import 'package:villers_boys_ii/reaction_time_intro.dart';
import 'package:villers_boys_ii/user.dart';
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
          "Test: $_tnum, rtime: $rTimes",
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        )),
        body: Center(
              child: Stack(children: [
                Positioned(
                  left: Random().nextDouble() * (MediaQuery.of(context).size.width - 100 - (100)) + 100,
                  //top: Random().nextDouble() * (MediaQuery.of(context).size.height / 2),
                  //right: Random().nextDouble() * (MediaQuery.of(context).size.width / 2),
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