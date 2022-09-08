import 'package:flutter/material.dart';
import 'dart:async';

class DrivingPage extends StatefulWidget {
  const DrivingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DrivingPage> createState() => _DrivingPageState();
}

class _DrivingPageState extends State<DrivingPage> {
  late Timer _t;
  late Duration _elapsed;
  int _timerMode = 0; // 0 = not started, 1 = driving, 2 = paused
  final stopwatch = Stopwatch();
  bool _reccStop = false;

  late final _buttonStates = [
    ElevatedButton(
      onPressed: () {
        _startTimer();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(350, 350),
        shape: const CircleBorder(),
      ),
      child: const Text(
        'Start Timer',
        style: TextStyle(fontSize: 75),
        textAlign: TextAlign.center,
      ),
    ),

    ElevatedButton(
      onPressed: () {
        _pauseTimer();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(350, 350),
        shape: const CircleBorder(),
      ),
      child: const Text(
        'Pause Timer',
        style: TextStyle(fontSize: 75),
        textAlign: TextAlign.center,
      ),
    ),

    ElevatedButton(
      onPressed: () {
        _startTimer();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(350, 350),
        shape: const CircleBorder(),
      ),
      child: const Text(
        'Resume',
        style: TextStyle(fontSize: 75),
        textAlign: TextAlign.center,
      ),
    ),
  ];

  void _startTimer(){
    setState(() {
      _timerMode = 1;
      //_reccStop = false;
    });
    stopwatch.start();
  }

  void _pauseTimer(){
    setState(() {
      _timerMode = 2;
    });
    stopwatch.stop();
  }

  void _resetTimer(){
    setState(() {
      _timerMode = 0;
    });
    stopwatch.stop();
    stopwatch.reset();
  }

  void _refresh(){
    // Called once a second by the incremental timer
    // Updates the elapsed time and checks if the recommended rest time has
    // been reached
    setState(() {
      _elapsed = stopwatch.elapsed;
    });

    if (_elapsed.inSeconds >= 5) {
      setState(() {
        _reccStop = true;
      });
    }
    else {
      setState(() {
        _reccStop = false;
      });
    }
  }

  String _timeString(Duration d){
    // Returns a duration in HH:MM:SS Format
    int hours = d.inHours;
    int mins = d.inMinutes;
    int secs = d.inSeconds;

    String s = '';

    if (hours < 10){
      s = s + '0';
    }
    s = s + hours.toString() + ':';
    if (mins < 10){
      s = s + '0';
    }
    s = s + mins.toString() + ':';
    if (secs < 10){
      s = s + '0';
    }
    s = s + secs.toString();
    return s;
  }
  
  @override
  void initState() {
    _t = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _refresh();
    });

    _elapsed = const Duration(seconds:0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buttonStates[_timerMode],
              Text(_timeString(_elapsed),
                style: TextStyle(fontSize: 75),
                textAlign: TextAlign.center,),
              Visibility(visible: _reccStop,
                replacement: const Text('No Recommendations',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
                child: const Text('Rest Recommended',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(onPressed: (){
                _resetTimer();
              }, child: const Text('Reset')),
            ],
          ),
        ],
      )

    );
  }
}