import 'package:flutter/material.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/user.dart';

import 'constants.dart';
import 'main_page.dart';
import 'memory_test.dart';

class MemoryTestIntro extends StatefulWidget {
  MemoryTestIntro({Key? key, required this.user, required this.calibrate, this.driveAssessment})
      : super(key: key);
  final User user;
  final bool calibrate;
  DriveAssessment? driveAssessment;

  @override
  State<MemoryTestIntro> createState() => _MemoryTestIntroScreen();
}

class _MemoryTestIntroScreen extends State<MemoryTestIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Memory Test Intro",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: (){
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
            },
          ),
        ),
        body: Center(
          child: Column(children: [
            Text(
                "In this activity, we will test your memory. To test this we will show a sequence of highlighted squares after a short delay. You should do your best to remember the sequence. Then a series of questions will be asked about the order of the tiles.",
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
                    )));
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
