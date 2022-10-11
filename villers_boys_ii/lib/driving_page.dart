// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:async';

import 'package:vibration/vibration.dart';

import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DrivingPage extends StatefulWidget {
  const DrivingPage({Key? key, required this.restInterval, required this.level})
      : super(key: key);

  final Duration restInterval;
  final int level;

  @override
  State<DrivingPage> createState() => _DrivingPageState();
}

class _DrivingPageState extends State<DrivingPage> {
  late SharedPreferences prefs;
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
  bool _recommendations = false;
  bool _vibrated = false;
  bool _showHeartRate = false;
  bool _timeSim = false;
  final _ebHeight = 0.07;
  final _ebSidePad = 0.02;
  final _ebTopPad = 0.02;

  var _heartRateText = ['67', '64', '65', '68', '63'];
  final _heartRateDrop = ['40', '40', '40', '40', '40'];
  final _buttonTexts = ['Start', 'Pause', 'Resume'];

  final _fatigueHeads = ['YOU ARE NOT FATIGUED', 'YOU ARE FATIGUED', 'YOU SHOULD NOT DRIVE'];
  final _fatigueDescs = ['You are not at an increased risk of a fatigue related crash',
    'You are at an increased risk of a fatigue related crash',
    'You are severely fatigued and should not drive'
  ];

  final String _fatigueLevelLow =
      "You are not showing symptoms of driver fatigue.\n\nYou should still stop driving for at least 15 minutes every 2 hours.\n\nNever drive for more than 10 hours in a single day.";
  final String _fatigueLevelMedium =
      "You are begining to show symptoms of driver fatigue.\n You should stop driving for at least 15 minutes every 2 hours. Utilise rest areas, tourist spots and driver reviver stops.\n\nIf you really need to keep driving, try some of the following:\n\n •Lower the cars interior temparature (putting the aircon on high)\n"
      "• Try adjusting and focusing on your seating posture\n"
      "• Try increasing or turning on some music\n"
      "• Try a caffinated drink, it can help temporarily boost energy levels\n";
  final String _fatigueLevelHigh =
      "You are showing symptoms of severe driver fatigue.\n You must stop driving and rest as soon as possible. Utilise rest areas, tourist spots and driver reviver stops.\n\nIf you really need to keep driving, try some of the following:\n\n •Lower the cars interior temparature (putting the aircon on high)\n"
      "• Try adjusting and focusing on your seating posture\n"
      "• Try increasing or turning on some music\n"
      "• Try a caffinated drink, it can help temporarily boost energy levels\n";
  String _driverTips = "";

  void _showRecommendations(BuildContext context, int fatigueLevel) {
    /// Opens a dialog box to choose between pausing or resetting the timer
    debugPrint(fatigueLevel.toString());
    if (fatigueLevel == 1) {
      _driverTips = _fatigueLevelLow;
    } else if (fatigueLevel == 2) {
      _driverTips = _fatigueLevelMedium;
    } else {
      _driverTips = _fatigueLevelHigh;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "Feeling fatigued?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height *
                    SUBHEADING_TEXT_SIZE /
                    1.2),
          ),
          backgroundColor: neutral,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * _ebSidePad,
                  right: MediaQuery.of(context).size.width * _ebSidePad,
                  top: MediaQuery.of(context).size.height * _ebTopPad),
              child: Text(
                _driverTips,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
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
                  "Close",
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

  void _startTimer() {
    setState(() {
      _timerMode = 1;
      _reccStop = false;
      _vibrated = false;
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
    if(_timeSim){
      _totalDuration += Duration(hours: 2);
    }
    _timeSim = false;
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

    if (_elapsed >= widget.restInterval && !_timeSim) {
      setState(() {
        _reccStop = true;
        if (!_vibrated) {
          _startVibrate();
          _vibrated = true;
        }
      });
    } else {
      setState(() {
        _reccStop = false;
      });
    }
  }

  _startVibrate() async {
    /// Calls a single impact haptic
    if (_vibrate) {
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 1000);
      }
      // Vibrate for 1 second
      debugPrint("Vibration");
      //HapticFeedback.mediumImpact();
    }
  }

  String _timeString(Duration d) {
    /// Returns a duration as a string in HH:MM:SS Format
    if(_timeSim){
      d += Duration(hours: 2, minutes: 0, seconds: 0);
    }
    int hours = d.inHours;
    int mins = d.inMinutes - (hours * 60);
    int secs = d.inSeconds - (hours * 3600) - (mins * 60);
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

  Widget _getBody(BuildContext context){
    var _bodys  = [
      // Before start
      Column(
        children: [
          Text(_fatigueDescs[widget.level]),
          GestureDetector(
            onTap: (){
              _startTimer();
            },
            child: SimpleShadow(
                offset: Offset(0,5),
                sigma: 4,
                child: Image(
                  image: AssetImage(tyredLogo),
                  width: MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE,
                )
            ),
          ),
          Text('Tap to begin your drive'),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_CONTAINER)),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                )]
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  _timeString(_elapsed + _totalDuration)
              ),
            ),
          )
        ],
      ),
      // Timer Running
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){
                    _heartRateText = _heartRateDrop;
                    _startVibrate();
                  },
                  icon: ImageIcon(AssetImage(heart))),
              IconButton(
                  onPressed: (){
                    _timeSim = true;
                  },
                  icon: ImageIcon(AssetImage(clock))),
            ],
          ),
          GestureDetector(
            onTap: (){
              _pauseTimer();
            },
            child: SimpleShadow(
                offset: Offset(0,5),
                sigma: 4,
                child: Image(
                  image: AssetImage(tyredPause),
                  width: MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE,
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_CONTAINER)),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                )]
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  _timeString(_elapsed + _totalDuration)
              ),
            ),
          )
        ],
      ),
      //Paused Screen
      Column(
        children: [
          Text(
              _timeString(_elapsed + _totalDuration)
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_CONTAINER)),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                )]
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Your drive is currently paused. \n\n'
                        'Please take this opportunity to take a break from driving to reduce your liklihood of a fatigue related crash.'
                  ),
                  ElevatedButton(
                      onPressed: (){
                        _startTimer();
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                          )
                          )
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Resume',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                      )
                  ),
                ],
              )
            ),
          ),
          ElevatedButton(
              onPressed: (){
                _resetTimer();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                          title: 'Fatigue Management App',
                          user: User("kevin", 32, 32, 32),
                          index: 1,
                        )),
                        (route) => false);
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                  )
                  )
              ),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('End Drive',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  )
              )
          ),
        ],
      ),
    ];

    return _bodys[_timerMode];
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
    loadData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_fatigueHeads[widget.level]),
      ),
      body: _getBody(context),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: [
          IconButton(
              onPressed: () {
                if (_vibrate) {
                  _vibrate = false;
                } else {
                  _vibrate = true;
                }
              },
              icon: ImageIcon(
                AssetImage(bellOutline),
                size: 50,
              )),
          IconButton(
              onPressed: () {
                _showRecommendations(context, widget.level);
              },
              icon: ImageIcon(
                AssetImage(infoIconColour),
                size: 50,
              ))
        ],
      )),
    );
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _showHeartRate = prefs.getBool('connected') ?? false;
    });
  }
}
