import 'package:flutter/material.dart';
import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/reaction_time1.dart';
import 'package:villers_boys_ii/constants.dart';

class QuestionaireTestPage extends StatefulWidget {
  const QuestionaireTestPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<QuestionaireTestPage> createState() => _QuestionaireTestState();
}

class _QuestionaireTestState extends State<QuestionaireTestPage> {
  int _counter = 0;
  int _score = 0;
  int _flag = 0;

  // Answer button dimensions
  final double _ebHeight = 0.1;
  final double _ebWidth = 0.7;
  final double _ebPadding = 0.02;

  Future<void> wait() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  //Create a list of the questions
  //--------------------------------------------------------
  List<int> prevScore = [
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

  List<String> qNum = const [
    'Question 1/10',
    'Question 2/10',
    'Question 3/10',
    'Question 4/10',
    'Question 5/10',
    'Question 6/10',
    'Question 7/10',
    'Question 8/10',
    'Question 9/10',
    'Question 10/10',
  ];

  List<String> questions = const [
    'How many hours of sleep have you averaged per night this week?',
    'On average how interrupted/disturbed has your recent sleep been?',
    'How many hours of sleep did you manage last night?',
    'I have been getting tired quickly in the last week?',
    'I have had the energy for everyday life in the last week?',
    'I have had problems thinking clearly in the last week?',
    'I have been yawning frequently today?',
    'I have been waking up earlier than normal in the last week?',
    'I have been going to sleep later than normal in the last week?',
    'I have been waking up in the morning feeling well rested in the last week?',
  ];

  List<String> firstAnswer = const [
    '0-2',
    'Uninterrupted',
    '8+',
    'Never',
    'Never',
    'Never',
    'Strongly Agree',
    'Never',
    'Never',
    'Never',
  ];

  List<int> firstAnswerScore = const [
    5,
    1,
    1,
    1,
    5,
    1,
    5,
    1,
    1,
    5,
  ];

  List<String> secondAnswer = const [
    '2-4',
    'Woke once or twice',
    '6-8',
    'Sometimes',
    'Sometimes',
    'Sometimes',
    'Agree',
    'Sometimes',
    'Sometimes',
    'Sometimes',
  ];

  List<int> secondAnswerScore = const [
    4,
    2,
    2,
    2,
    4,
    2,
    4,
    2,
    2,
    4,
  ];

  List<String> thirdAnswer = const [
    '4-6',
    'Twice or more in one day',
    '4-6',
    'Regularly',
    'Regularly',
    'Regularly',
    'Neutral',
    'Regularly',
    'Regularly',
    'Regularly',
  ];

  List<int> thirdAnswerScore = const [
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
  ];

  // ignore: non_constant_identifier_names
  List<String> FourthAnswer = const [
    '6-8',
    'At least once every day for more than 20min',
    '2-4',
    'Often',
    'Often',
    'Often',
    'Disagree',
    'Often',
    'Often',
    'Often',
  ];

  List<int> fourthAnswerScore = const [
    2,
    4,
    4,
    4,
    2,
    4,
    2,
    4,
    4,
    2,
  ];

  List<String> fifthAnswer = const [
    '8+',
    'Every Day and for at least an hour',
    '0-2',
    'Always',
    'Always',
    'Always',
    'Strongly Disagree',
    'Always',
    'Always',
    'Always',
  ];

  List<int> fifthAnswerScore = const [
    1,
    5,
    5,
    5,
    1,
    5,
    1,
    5,
    5,
    1,
  ];
  //-------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (_flag == 1) {
      debugPrint("Quiz Over Score: $_score");
      if (_score < 22) {
        debugPrint("You have healthy levels of fatigue!");
      } else if (_score >= 22 && _score <= 34) {
        debugPrint("You have mild to moderate levels of fatigue");
      } else {
        debugPrint("You have severe fatigue");
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReactionTimePage(user: widget.user)));
      });
    }
    return GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! <= 0) {
            setState(() {
              if (_counter == 0) {
                _counter = 0;
                _flag = 0;
              } else {
                _counter--;
                _score = prevScore[_counter];
              }
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the HomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Fatigue Management App'),

          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   'Score: $_score',
                // ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                    qNum[_counter],
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                    questions[_counter],
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            prevScore[_counter] = _score;
                            _score = _score + firstAnswerScore[_counter];
                            _counter++;
                            if (_counter == 10) {
                              _counter = 0;
                              _flag = 1;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      QuestionaireTestPage(user: widget.user)));
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          firstAnswer[_counter],
                          style: TextStyle(fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ),
                    )),
                Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            prevScore[_counter] = _score;
                            _score = _score + secondAnswerScore[_counter];
                            _counter++;
                            if (_counter == 10) {
                              _counter = 0;
                              _flag = 1;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          secondAnswer[_counter],
                          style: TextStyle(fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
                Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            prevScore[_counter] = _score;
                            _score = _score + thirdAnswerScore[_counter];
                            _counter++;
                            if (_counter == 10) {
                              _counter = 0;
                              _flag = 1;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          thirdAnswer[_counter],
                          style: TextStyle(fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
                Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            prevScore[_counter] = _score;
                            _score = _score + fourthAnswerScore[_counter];
                            _counter++;
                            if (_counter == 10) {
                              _counter = 0;
                              _flag = 1;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          FourthAnswer[_counter],
                          style: TextStyle(fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
                Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            prevScore[_counter] = _score;
                            _score = _score + fifthAnswerScore[_counter];
                            _counter++;
                            if (_counter == 10) {
                              _counter = 0;
                              _flag = 1;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          fifthAnswer[_counter],
                          style: TextStyle(fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
