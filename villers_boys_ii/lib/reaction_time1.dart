import 'package:flutter/material.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/reaction_time_intro.dart';
import 'package:villers_boys_ii/user.dart';

import 'constants.dart';

class ReactionTimePage extends StatefulWidget {
  ReactionTimePage(
      {Key? key, required this.user, required this.calibrate, this.driveAssessment})
      : super(key: key);
  final User user;
  final bool calibrate;
  DriveAssessment? driveAssessment;

  @override
  State<ReactionTimePage> createState() => _ReactionTimeState();
}

class _ReactionTimeState extends State<ReactionTimePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reaction Time Test'),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: Column(children: [
            Text(
                'In this activity, we will ask you to perform an activity used to'
                ' measure your reaction time. Press the purple x on the screen as '
                'fast as you can!',
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
                        )));
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
