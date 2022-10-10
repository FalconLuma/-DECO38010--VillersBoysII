import 'package:flutter/material.dart';
import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/reaction_time1.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/drive_assessment.dart';

import 'main_page.dart';

///This page is for the actual questionnaire test
///It contains the questions asked
///the answers available
///Determins a fatigue score based on the questionnaire
///And finally navigates to the next test in the list

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

  //Create a list of the scores after each answer
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
  //Create a list to store the question numbers
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
  //Create a list of all the questions
  List<String> questions = const [
    'How many hours of sleep per night have you averaged over the last week?',
    'In general what would best describe how interrupted your sleep has been over the last week?',
    'How many hours of sleep did you get last night?',
    'How often have you found yourself feeling tired in the first half of your day over the last week?',
    'How often have you completed your daily routine without needing an additional caffeine kick or nap over the last week?',
    'How often have you had problems concentrating and thinking clearly over the last week?',
    'You have been yawning frequently today.',
    'How often have you been starting your day earlier than normal over the last week?',
    'How often have you been falling asleep later than normal over the last week?',
    'How often have you been waking up feeling well rested and refreshed over the last week?',
  ];
  //Create a list of all the first answers for each supplied question
  List<String> firstAnswer = const [
    '0-2 hours',
    'Uninterrupted',
    '8+ hours',
    'Never (0%)',
    'Never (0%)',
    'Never (0%)',
    'Strongly Agree',
    'Never (0%)',
    'Never (0%)',
    'Never (0%)',
  ];
  //Create a corresponding list of all the scores given for the corresponding answer selected for a question
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
  //Create remaining lists and corresponding score lists for each of the 5 potential answers for each question
  //----------------------------------------------------------------------------------------------------------
  List<String> secondAnswer = const [
    '2-4 hours',
    'Only woke up briefly once or twice a night',
    '6-8 hours',
    'Sometimes (25%)',
    'Sometimes (25%)',
    'Sometimes (25%)',
    'Agree',
    'Sometimes (25%)',
    'Sometimes (25%)',
    'Sometimes (25%)',
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
    '4-6 hours',
    'I woke up each night for at least 5 minutes',
    '4-6 hours',
    'Often (50%)',
    'Often (50%)',
    'Often (50%)',
    'Neutral',
    'Often (50%)',
    'Often (50%)',
    'Often (50%)',
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

  List<String> fourthAnswer = const [
    '6-8 hours',
    'I woke up each night for at least 30 minutes',
    '2-4 hours',
    'Usually (75%)',
    'Usually (75%)',
    'Usually (75%)',
    'Disagree',
    'Usually (75%)',
    'Usually (75%)',
    'Usually (75%)',
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
    '8+ hours',
    'I probably spent more time awake than asleep',
    '0-2 hours',
    'Always (100%)',
    'Always (100%)',
    'Always (100%)',
    'Strongly Disagree',
    'Always (100%)',
    'Always (100%)',
    'Always (100%)',
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
  //-----------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //Create a check for when the quiz is over, also outline the results generated
    //Move to next page
    if (_flag == 1) {
      debugPrint("Quiz Over Score: $_score");
      DriveAssessment da = DriveAssessment(_score, 0, 0, widget.user);
      if (_score < 22) {
        debugPrint("You have healthy levels of fatigue!");
      } else if (_score >= 22 && _score <= 34) {
        debugPrint("You have mild to moderate levels of fatigue");
      } else {
        debugPrint("You have severe fatigue");
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReactionTimePage(
                  user: widget.user,
                  calibrate: true,
                  driveAssessment: da,
                ),
            settings: const RouteSettings(name: 'preDrive')));
      });
    }
    return GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          //Functionality to detect user swiping back
          //If swipe back is detected return to previous question updating scores, questions and answers accordingly
          if (details.primaryVelocity! > 0) {
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
            //If the user exits the questionnaire return them to the mainpage
            title: const Text('Fatigue Management App'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              title: 'Fatigue Management App',
                              user: widget.user,
                              index: 1,
                            )),
                    (route) => false);
              },
            ),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                    //Display the current question number
                    qNum[_counter],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height *
                            BODY_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                    //Display the current question
                    questions[_counter],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height *
                            BODY_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          //Update the current score and counter if they select the first answer
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
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * _ebWidth,
                            MediaQuery.of(context).size.height * _ebHeight),
                      ),
                      child: Text(
                        firstAnswer[_counter],
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height *
                                MENU_BUTTON_TEXT_SIZE),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            //Same as previous comment
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
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          secondAnswer[_counter],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            //Same as previous comment
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
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          thirdAnswer[_counter],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            //Same as previous comment
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
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          fourthAnswer[_counter],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * _ebPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            //Same as previous comment
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
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * _ebWidth,
                              MediaQuery.of(context).size.height * _ebHeight),
                        ),
                        child: Text(
                          fifthAnswer[_counter],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  MENU_BUTTON_TEXT_SIZE),
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
