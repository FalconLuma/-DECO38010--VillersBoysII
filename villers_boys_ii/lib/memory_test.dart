import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/newStart.dart';
import 'package:villers_boys_ii/results_page.dart';
import 'package:villers_boys_ii/user.dart';
import 'dart:math';
import 'dart:async';

import 'StartCalibrate.dart';
import 'constants.dart';

class MemoryTest extends StatefulWidget {
  MemoryTest(
      {Key? key,
      required this.user,
      required this.calibrate,
      this.driveAssessment})
      : super(key: key);
  final User user;
  final bool calibrate;
  DriveAssessment? driveAssessment;

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
  int duration = 1500;
  int sequenceItems = 7;
  int numSquares = 16;
  int numQuestions = 5; // NOTE: if updated, also update list generation

  late List<int> sequence = List<int>.generate(sequenceItems, (i) => 0);
  late List<String> textValues = List<String>.generate(numSquares, (i) => '');
  late List<bool> pressed = List<bool>.generate(numSquares, (i) => false);
  late List<int> questionSquare = List<int>.generate(numQuestions, (i) => 0);
  late List<int> questionPosition = List<int>.generate(numQuestions, (i) => 0);
  late List<bool> answers = List<bool>.generate(numQuestions, (i) => false);

  bool setup = false;
  bool showQuestion = false;
  int questionNum = 0;

  void _setResult() {
    double result = 0;
    for (int i = 0; i < numQuestions; i++) {
      if (answers[i] && sequence[questionPosition[i]] == questionSquare[i]) {
        // Answered yes and was in correct position
        result += 1;
      } else if (!answers[i] &&
          sequence[questionPosition[i]] != questionSquare[i]) {
        // Answered no and not in correct position
        result += 1;
      }
    }
    debugPrint(answers.toString());
    debugPrint("Your memory score is: $result");

    //Pass in memory test score here
    if (widget.calibrate == false &&
        (widget.user.getUserName() == "Jacob" || widget.user.getAge() == 32)) {
      save(result);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => newStart(
                user: widget.user,
                flag: true,
              ),
      settings: RouteSettings(name: ModalRoute.of(context)!.settings.name)));
    } else if (widget.calibrate == false) {
      save(result);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainPage(
                title: 'Fatigue Managment App',
                user: User(name, age, reaction, memory),
                index: 2,
              )));
    } else {
      widget.driveAssessment?.setMemoryScore(result);
      DriveAssessment da;
      if (widget.driveAssessment != null) {
        da = widget.driveAssessment!;
      } else {
        da = DriveAssessment(0, 0, 0, User("a", 0, 0, 0));
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultsPage(
                user: widget.user,
                driveAssessment: da,
              )));
    }
  }

  /*
  Generate a question
   */
  void _generateQuestion(int index) {
    var rng = Random();
    if (rng.nextBool()) {
      // Question that is forced to be true
      int val = rng.nextInt(sequenceItems);
      questionSquare[index] = sequence[val];
      questionPosition[index] = val;
    } else {
      // Question that could be true or false
      questionSquare[index] = rng.nextInt(numSquares);
      questionPosition[index] = rng.nextInt(sequenceItems);
    }
  }

  void _genRandSequence() {
    // Create random sequence
    var rng = Random();
    int val;
    for (var i = 0; i < sequenceItems; i++) {
      val = rng.nextInt(numSquares);
      if (i != 0) {
        // Don't set the sequence to the same square twice in a row
        while (val == sequence[i - 1]) {
          val = rng.nextInt(numSquares);
        }
      }
      sequence[i] = val;
    }

    // Create questions
    _generateQuestion(0);
    for (var i = 1; i < numQuestions; i++) {
      do {
        _generateQuestion(i);
        // Check question is not the same as the question before
      } while (questionSquare[i] == questionSquare[i - 1] &&
          questionPosition[i] == questionPosition[i - 1]);
    }
    debugPrint("Generated sequence: $sequence");
    debugPrint("Question tiles: $questionSquare");
    debugPrint("Question positions: $questionPosition");
  }

  void _updateBoard() {
    _genRandSequence();
    questionNum = 0;
    for (int i = 0; i < sequenceItems + 1; i++) {
      Timer(Duration(milliseconds: duration * i), () {
        setState(() {
          if (i != sequenceItems) {
            textValues[sequence[i]] = "${i + 1}";
            pressed[sequence[i]] = !pressed[sequence[i]]; // turn square on
          }
          if (i != 0) {
            textValues[sequence[i - 1]] = '';
            pressed[sequence[i - 1]] =
                !pressed[sequence[i - 1]]; // turn previous square off
          }
        });
      });
    }
    Timer(Duration(milliseconds: duration * sequenceItems + 500), () {
      setState(() {
        showQuestion = true;
        int position = questionPosition[questionNum];
        textValues[questionSquare[questionNum]] = "${position + 1}";
        pressed[questionSquare[questionNum]] =
            !pressed[questionSquare[questionNum]];
      });
    });
  }

  void _nextQuestion() {
    questionNum++;
    // Hide previous tile
    if (questionNum < numQuestions) {
      if (questionNum != 0) {
        textValues[questionSquare[questionNum - 1]] = '';
        pressed[questionSquare[questionNum - 1]] =
            !pressed[questionSquare[questionNum - 1]];
      }
      // Show new tile
      int position = questionPosition[questionNum];
      textValues[questionSquare[questionNum]] = "${position + 1}";
      pressed[questionSquare[questionNum]] =
          !pressed[questionSquare[questionNum]];
    } else {
      // Questions are finished. Show nothing
      textValues[questionSquare[questionNum - 1]] = '';
      pressed[questionSquare[questionNum - 1]] =
          !pressed[questionSquare[questionNum - 1]];
      questionNum = 0;
      showQuestion = false;
      _setResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
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
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if(ModalRoute.of(context)?.settings.name == 'preDrive'){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                          title: 'Fatigue Management App',
                          user: User("kevin", 32, 32, 32),
                          index: 1,
                        )
                    ),
                        (route) => false
                );
              } else if(ModalRoute.of(context)?.settings.name == 'edit'){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                          title: 'Fatigue Management App',
                          user: User("kevin", 32, 32, 32),
                          index: 2,
                        )
                    ),
                        (route) => false
                );
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => StartCalibratePage(
                            user: User("kevin", 32, 32, 32)
                        )
                    ),
                        (route) => false
                );
              }
            },
          ),
        ),
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
                  for (int i = 0; i < 16; i++)
                    InkWell(
                        onTap: () {},
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color:
                                    pressed[i] ? pressedColor : defaultColor),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  style: const TextStyle(fontSize: 25),
                                  textValues[i]),
                            ))),
                ],
              ),
              Visibility(
                visible: showQuestion,
                child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                    "Was the highlighted tile labeled ${questionPosition[questionNum] + 1}",
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
                            MediaQuery.of(context).size.height * 0.05),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                answers[questionNum] = true;
                                _nextQuestion();
                              });
                            },
                            child: const Text("Yes")),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.05),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                answers[questionNum] = false;
                                _nextQuestion();
                              });
                            },
                            child: const Text("No")),
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }

  save(average) async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setDouble("memory", 0.0);
    prefs.setDouble("memoryTemp", average);
    name = prefs.getString('username') ?? "";
    age = prefs.getInt('age') ?? 0;
    calibrate = prefs.getBool('calibrate') ?? false;
    reaction = prefs.getDouble('reactionTemp') ?? 0.0;
    memory = prefs.getDouble('memoryTemp') ?? 0.0;
  }
}
