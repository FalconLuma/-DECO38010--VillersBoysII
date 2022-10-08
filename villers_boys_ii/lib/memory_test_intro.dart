import 'package:flutter/material.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/user.dart';

import 'StartCalibrate.dart';
import 'constants.dart';
import 'main_page.dart';
import 'memory_test.dart';

class MemoryTestIntro extends StatefulWidget {
  MemoryTestIntro(
      {Key? key,
      required this.user,
      required this.calibrate,
      this.driveAssessment})
      : super(key: key);
  final User user;
  final bool calibrate;
  DriveAssessment? driveAssessment;

  @override
  State<MemoryTestIntro> createState() => _MemoryTestIntroScreen();
}

class _MemoryTestIntroScreen extends State<MemoryTestIntro> {
  String message =
      'You are about to begin your baseline TYRED memory test calibration.\n'
      '\nA series of numbered and coloured squares will randomly appear in a grid. You are required to memorise its position and order to recall when required.\n'
      '\nGood luck!';

  @override
  Widget build(BuildContext context) {
    if (widget.calibrate) {
      message = 'You are about to begin your  TYRED rating memory test.\n'
          '\nA series of numbered and coloured squares will randomly appear in a grid. You are required to memorise its position and order to recall when required.\n'
          '\nGood luck!';
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Memory Test Intro",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name == 'preDrive') {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              title: 'Fatigue Management App',
                              user: User("kevin", 32, 32, 32),
                              index: 1,
                            )),
                    (route) => false);
              } else if (ModalRoute.of(context)?.settings.name == 'edit') {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              title: 'Fatigue Management App',
                              user: User("kevin", 32, 32, 32),
                              index: 2,
                            )),
                    (route) => false);
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => StartCalibratePage(
                            user: User("kevin", 32, 32, 32))),
                    (route) => false);
              }
            },
          ),
        ),
        body: Center(
          child: Column(children: [
            Text(message,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    letterSpacing: 2.0)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MemoryTest(
                          user: widget.user,
                          calibrate: widget.calibrate,
                          driveAssessment: widget.driveAssessment,
                        ),
                    settings: RouteSettings(
                        name: ModalRoute.of(context)!.settings.name)));
              },
              child: const Icon(
                Icons.start_sharp,
                size: 50,
              ),
            ),
          ]),
        ));
  }
}
