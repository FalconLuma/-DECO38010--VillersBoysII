import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/newStart.dart';
import 'package:villers_boys_ii/results_page.dart';
import 'package:villers_boys_ii/user.dart';
import 'dart:math';
import 'dart:async';

import 'constants.dart';

class MemoryTest extends StatefulWidget {
  const MemoryTest({Key? key, required this.user, required this.calibrate})
      : super(key: key);
  final User user;
  final bool calibrate;

  @override
  State<MemoryTest> createState() => _MemoryTest();
}

class _MemoryTest extends State<MemoryTest> {
  late SharedPreferences prefs;
  double reaction = 0;
  double memory = 0;
  String name = "";
  int age = 0;

  bool calibrate = false;

  Color defaultColor = primary;
  Color pressedColor = secondary;
  int duration = 500;
  int sequenceItems = 7;
  int numSquares = 16;
  List<int> sequence = List<int>.generate(16, (i) => i);
  List<bool> pressed = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool setup = false;
  int numQuestions = 3;
  List<int> questionSquare = List<int>.generate(3, (i) => 0);
  List<int> questionPosition = List<int>.generate(3, (i) => 0);
  List<bool> answers = List<bool>.generate(3, (i) => false);
  bool showQuestion = false;
  int questionNum = 0;

  void _genRandSequence() {
    // Create random sequence
    var rng = Random();
    for (var i = 0; i < sequenceItems; i++) {
      sequence[i] = rng.nextInt(numSquares);
    }
    for (var i = 0; i < numQuestions; i++) {
      questionSquare[i] = rng.nextInt(numSquares);
      questionPosition[i] = rng.nextInt(sequenceItems);
      // TODO: Ensure some of the actual questions have yes answers. Probably around 50%
    }
  }

  void _updateBoard() {
    _genRandSequence();
    questionNum = 0;
    for (int i = 0; i < sequenceItems + 1; i++) {
      Timer(Duration(milliseconds: duration * i), () {
        setState(() {
          if (i != sequenceItems) {
            pressed[sequence[i]] = !pressed[sequence[i]]; // turn square on
          }
          if (i != 0) {
            pressed[sequence[i - 1]] =
                !pressed[sequence[i - 1]]; // turn previous square off
          }
        });
      });
    }
    Timer(Duration(milliseconds: duration * sequenceItems + 500), () {
      setState(() {
        showQuestion = true;
        pressed[questionSquare[questionNum]] =
            !pressed[questionSquare[questionNum]];
      });
    });
  }

  void _nextQuestion() {
    questionNum++;
    // Hide previous tile
    print(questionNum);
    if (questionNum < numQuestions) {
      pressed[questionSquare[questionNum - 1]] =
          !pressed[questionSquare[questionNum - 1]];
      // Show new tile
      pressed[questionSquare[questionNum]] =
          !pressed[questionSquare[questionNum]];
    } else {
      pressed[questionSquare[questionNum - 1]] =
          !pressed[questionSquare[questionNum - 1]];
      questionNum = 0;
      showQuestion = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        if (!setup) {
          _updateBoard();
          setup = true;
        }
      });
    });
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Memory Test",
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 4,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[0] = !pressed[0];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[0] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[1] = !pressed[1];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[1] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[2] = !pressed[2];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[2] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[3] = !pressed[3];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[3] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[4] = !pressed[4];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[4] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[5] = !pressed[5];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[5] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[6] = !pressed[6];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[6] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[7] = !pressed[7];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[7] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[8] = !pressed[8];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[8] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[9] = !pressed[9];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[9] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[10] = !pressed[10];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[10] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[11] = !pressed[11];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[11] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[12] = !pressed[12];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[12] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[13] = !pressed[13];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[13] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[14] = !pressed[14];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[14] ? pressedColor : defaultColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pressed[15] = !pressed[15];
                      });
                    },
                    child: Ink(
                        height: 100,
                        width: 100,
                        color: pressed[15] ? pressedColor : defaultColor),
                  )
                ],
              ),
              Visibility(
                visible: showQuestion,
                child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                      "Was the highlighted tile in position ${questionPosition[questionNum]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                          letterSpacing: 2.0),
                  ),
                ),
              ),
              Visibility(
                visible: showQuestion,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.02),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                answers[questionNum] = true;
                                _nextQuestion();
                              });
                            },
                            child: Text("Yes")),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.02),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                answers[questionNum] = false;
                                _nextQuestion();
                              });
                            },
                            child: Text("No")),
                      ),
                    ]),
              ),
              ElevatedButton(
                onPressed: () {
                  //Pass in memory test score here
                  save(5.8);
                  if (widget.calibrate == false &&
                      (widget.user.getUserName() == "Jacob" ||
                          widget.user.getAge() == 32)) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => newStart(
                              user: widget.user,
                              flag: true,
                            )));
                  } else if (widget.calibrate == false) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainPage(
                              title: 'Fatigue Managment App',
                              user: User(name, age, reaction, memory),
                              index: 2,
                            )));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ResultsPage(user: widget.user)));
                  }
                },
                child: const Icon(
                  Icons.start_sharp,
                  size: 50,
                ),
              ),
            ],
          ),
        ));
  }

  save(average) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble("memory", average);
    name = prefs.getString('username') ?? "";
    age = prefs.getInt('age') ?? 0;
    calibrate = prefs.getBool('calibrate') ?? false;
    reaction = prefs.getDouble('reaction') ?? 0.0;
    memory = prefs.getDouble('memory') ?? 0.0;
  }
}
