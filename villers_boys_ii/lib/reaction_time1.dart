import 'package:flutter/material.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/reaction_time_intro.dart';
import 'package:villers_boys_ii/user.dart';

import 'StartCalibrate.dart';
import 'constants.dart';
import 'main_page.dart';

class ReactionTimePage extends StatefulWidget {
  ReactionTimePage(
      {Key? key,
      required this.user,
      required this.calibrate,
      this.driveAssessment})
      : super(key: key);
  final User user;
  final bool calibrate;
  DriveAssessment? driveAssessment;

  @override
  State<ReactionTimePage> createState() => _ReactionTimeState();
}

class _ReactionTimeState extends State<ReactionTimePage> {
  String message =
      'You are about to begin your baseline TYRED reaction test calibration.\n'
      '\nA series of squares with X in the centre will randomly appear on your screen. To complete this test please tap the squares as soon as they appear. The time taken to select the squares after they appear is being tracked so react as quickly as possible.\n'
      '\nGood luck!';

  Widget build(BuildContext context) {
    if (widget.calibrate) {
      message = 'You are about to begin your TYRED rating reaction test.\n'
          '\nA series of squares with X in the centre will randomly appear on your screen. To complete this test please tap the squares as soon as they appear. The time taken to select the squares after they appear is being tracked so react as quickly as possible.\n'
          '\nGood luck!';
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reaction Time Test'),
        centerTitle: true,
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
                      builder: (context) =>
                          StartCalibratePage(user: User("kevin", 32, 32, 32))),
                  (route) => false);
            }
          },
        ),
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Text(message,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    letterSpacing: 2.0)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReactionTimeIntro(
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
            )
          ])),
    );
  }
}
