import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter/services.dart';

import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/user.dart';

class DrivingPage extends StatefulWidget {
  const DrivingPage({Key? key, required this.restInterval}) : super(key: key);

  final Duration restInterval;

  @override
  State<DrivingPage> createState() => _DrivingPageState();
}

class _DrivingPageState extends State<DrivingPage> {
  late Timer _t;
  Duration _totalDuration = const Duration(
      seconds:
          0); // The total amount of time the timer has run since the  last reset but before the last pause
  Duration _elapsed = const Duration(
      seconds: 0); // The amount of time elapsed since the last pause ended
  int _timerMode = 0; // 0 = not started, 1 = running, 2 = paused
  final stopwatch = Stopwatch();
  bool _reccStop = false;
  bool _vibrate = true;

  final _ebHeight = 0.07;
  final _ebSidePad = 0.02;
  final _ebTopPad = 0.02;

  var _heartRateText = ['67', '64', '65', '68', '63'];
  var _heartRateDrop = ['40', '40', '40', '40', '40'];
  final _buttonTexts = ['Start', 'Pause', 'Resume'];

  void _showTimerDialog(BuildContext context) {
    /// Opens a dialog box to choose between pausing or resetting the timer
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "What would you like to do?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize:
                    MediaQuery.of(context).size.height * SUBHEADING_TEXT_SIZE),
          ),
          backgroundColor: neutral,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * _ebSidePad,
                  right: MediaQuery.of(context).size.width * _ebSidePad,
                  top: MediaQuery.of(context).size.height * _ebTopPad),
              child: ElevatedButton(
                onPressed: () {
                  _pauseTimer();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * _ebHeight)),
                child: Text(
                  "Take a Break",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height *
                          MENU_BUTTON_TEXT_SIZE),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * _ebSidePad,
                  right: MediaQuery.of(context).size.width * _ebSidePad,
                  top: MediaQuery.of(context).size.height * _ebTopPad),
              child: ElevatedButton(
                onPressed: () {
                  _resetTimer();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                                title: 'Fatigue Management App',
                                user: User("kevin", 32, 32, 32),
                                index: 1,
                              )),
                      (route) =>
                          false); // Go to home page, and reset route stack
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * _ebHeight)),
                child: Text(
                  "End Journey",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height *
                          MENU_BUTTON_TEXT_SIZE),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * _ebSidePad,
                  right: MediaQuery.of(context).size.width * _ebSidePad,
                  top: MediaQuery.of(context).size.height * _ebTopPad),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * _ebHeight)),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height *
                          MENU_BUTTON_TEXT_SIZE),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _timerActions(BuildContext context) {
    /// Using the current timer state decide whether to start the timer or open the dialog to pause/reset the timer
    switch (_timerMode) {
      case 0:
        _startTimer();
        break;
      case 1:
        _showTimerDialog(context);
        break;
      case 2:
        _startTimer();
    }
  }

  void _startTimer() {
    setState(() {
      _timerMode = 1;
      _reccStop = false;
      _elapsed = const Duration(seconds: 0);
    });
    stopwatch.start();
  }

  void _pauseTimer() {
    setState(() {
      _timerMode = 2;
      _totalDuration += Duration(seconds: _elapsed.inSeconds);
    });
    stopwatch.stop();
    stopwatch.reset();
  }

  void _resetTimer() {
    setState(() {
      _timerMode = 0;
      _totalDuration = const Duration(seconds: 0);
    });
    stopwatch.stop();
    stopwatch.reset();
  }

  void _refresh() {
    /// Called once a second by the incremental timer
    /// Updates the elapsed time and checks if the recommended rest time has been reached
    setState(() {
      _elapsed = stopwatch.elapsed;
    });

    if (_elapsed >= widget.restInterval) {
      setState(() {
        _reccStop = true;
        _startVibrate();
      });
    } else {
      setState(() {
        _reccStop = false;
      });
    }
  }

  void _startVibrate(){
    /// Calls a single impact haptic
    if(_vibrate){
      HapticFeedback.mediumImpact();
    }
  }

  String _timeString(Duration d) {
    /// Returns a duration as a string in HH:MM:SS Format
    int hours = d.inHours;
    int mins = d.inMinutes - (hours * 60);
    int secs = d.inSeconds - (hours * 360) - (mins * 60);

    String s = '';

    if (hours < 10) {
      s = s + '0';
    }
    s = s + hours.toString() + ':';
    if (mins < 10) {
      s = s + '0';
    }
    s = s + mins.toString() + ':';
    if (secs < 10) {
      s = s + '0';
    }
    s = s + secs.toString();
    return s;
  }

  @override
  void initState() {
    /// Called during initializing the screen
    // Set up the timer to call refresh() every half second
    _t = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Driving Page'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                            title: 'Fatigue Management App',
                            user: User("kevin", 32, 32, 32),
                            index: 1,
                          )),
                  (route) => false);
            },
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(300, 15, 15, 0),
                  child: Text("Heart Rate"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(300, 0, 15, 15),
                  child: Text(_heartRateText[(_elapsed.inSeconds) % 5]),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_vibrate) {
                        _vibrate = false;
                      } else {
                        _vibrate = true;
                      }
                    },
                    child: Visibility(
                      visible: _vibrate,
                      replacement: Row(
                        children: const [
                          Icon(Icons.volume_off),
                          Text("Vibration off")
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.volume_up),
                          Text("Vibration on")
                        ],
                      ),
                    )),
                ElevatedButton(
                  onPressed: () {
                    _timerActions(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                        MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE,
                        MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE),
                    shape: const CircleBorder(),
                  ),
                  child: Text(
                    _buttonTexts[_timerMode] +
                        '\n' +
                        _timeString(_elapsed + _totalDuration),
                    style: TextStyle(
                        fontSize: min(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height) *
                            MAIN_BUTTON_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                Visibility(
                  visible: _reccStop,
                  replacement: Text('No Recommendations',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height *
                              SUBHEADING_TEXT_SIZE),
                      textAlign: TextAlign.center),
                  child: Text(
                    'Rest Recommended',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height *
                            SUBHEADING_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      _heartRateText = _heartRateDrop;
                      _startVibrate();
                    },
                    child: Text('Heart Rate Drop Demo'))
              ],
            ),
          ],
        ));
  }
}
