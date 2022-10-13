// ignore_for_file: prefer_interpolation_to_compose_strings

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
  final _ebSidePad = 0.2;
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
    debugPrint(fatigueLevel.toString());
    if (fatigueLevel == 0) {
      _driverTips = _fatigueLevelLow;
    } else if (fatigueLevel == 1) {
      _driverTips = _fatigueLevelMedium;
    } else {
      _driverTips = _fatigueLevelHigh;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: neutral,
      isScrollControlled: true,
      shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(BORDER_RADIUS_CONTAINER),
      topRight: Radius.circular(BORDER_RADIUS_CONTAINER))
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Driver Fatigue Tips',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                  )
                ),
              ),
              IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: ImageIcon(
                  AssetImage(crossIcon),
                  size: 70,
                  color: darkBlue,
                )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              padding: EdgeInsets.all(20),
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
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                minHeight: MediaQuery.of(context).size.height * 0.7
              ),
              child: SingleChildScrollView(
                child: Text(
                    _driverTips,
                    style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                  ),
                ),
              ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * _ebHeight),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                  )
              ),

              child: Text(
                "Close",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * MENU_BUTTON_TEXT_SIZE,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      )
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

    if (_elapsed >= widget.restInterval || !_timeSim) {
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
      // Before start-----------------------------------------------------------
      Padding(padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_fatigueDescs[widget.level],
                    textAlign: TextAlign.center,
                  ),
                ],
              )

            ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                      visible: widget.level != 2,
                      child: Text('Tap to begin your drive')
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
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
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _timeString(_elapsed + _totalDuration),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * SUBHEADING_TEXT_SIZE,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // Timer Running----------------------------------------------------------
      Padding(padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (){
                        _heartRateText = _heartRateDrop;
                        _startVibrate();
                      },
                      icon: ImageIcon(AssetImage(heart),
                        color: darkBlue,
                        size: MediaQuery.of(context).size.width * 0.1,
                      )
                  ),
                  IconButton(
                      onPressed: (){
                        _timeSim = true;
                      },
                      icon: ImageIcon(AssetImage(clock),
                        color: darkBlue,
                        size: MediaQuery.of(context).size.width * 0.1,
                      )
                  ),
                ],
              ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("You should take a break now",
                    style: TextStyle(
                      color: _reccStop? neutral : darkBlue
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
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
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _timeString(_elapsed + _totalDuration),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * SUBHEADING_TEXT_SIZE,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      //Paused Screen-----------------------------------------------------------
      Padding(padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            _timeString(_elapsed + _totalDuration),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * SUBHEADING_TEXT_SIZE,
                fontStyle: FontStyle.italic
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Your drive is currently paused. \n',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE
                          ),
                        ),
                        Text(widget.level != 2?
                        'Please take this opportunity to take a break from driving to reduce your liklihood of a fatigue related crash.'
                            :
                        'You must stop driving and rest as soon as possible to reduce your liklihood of a fatigue related crash.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: (){
                          _startTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
                              MediaQuery.of(context).size.height * _ebHeight),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON)
                            )
                            )
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Resume',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
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
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
                MediaQuery.of(context).size.height * _ebHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON)
                  )
                )
              ),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('End Drive',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  )
              )
          ),
        ],
      ),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _fatigueHeads[widget.level],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        )

      ),
      body: _getBody(context),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: _vibrate,
                    replacement: IconButton(
                        onPressed: () {
                          setState(() {
                            _vibrate = true;
                          });
                        },
                        icon: ImageIcon(
                          AssetImage(bellOutline),
                          size: 50,
                          color: deselectedColor,
                        )
                    ),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _vibrate = false;
                          });
                        },
                        icon: ImageIcon(
                          AssetImage(bellColour,),
                          size: 50,
                          color: darkBlue,
                        )
                    ),
                  ),
                  Text("Smart Seatbelt",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.normal
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        _showRecommendations(context, widget.level);
                      },
                      icon: ImageIcon(
                        AssetImage(infoIconOutline),
                        size: 50,
                        color: deselectedColor,
                      )
                  ),
                  Text("Fatigue Help",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _showHeartRate = prefs.getBool('connected') ?? false;
    });
  }
}
