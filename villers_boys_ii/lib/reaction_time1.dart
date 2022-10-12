import 'package:flutter/material.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/reaction_time_intro.dart';
import 'package:villers_boys_ii/simple_appbar.dart';
import 'package:villers_boys_ii/simple_button.dart';
import 'package:villers_boys_ii/simple_textbox.dart';
import 'package:villers_boys_ii/user.dart';

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
  String message = 'You are about to begin your baseline TYRED reaction test.\n'
      '\nA series of orange squares with X in the centre will randomly appear on your screen. To complete this test please tap the squares as soon as they appear. The time taken to select the squares after they appear is being tracked so react as quickly as possible.\n'
      '\nGood luck!';

  Widget build(BuildContext context) {
    if (widget.calibrate) {
      message = 'You are about to begin your TYRED rating reaction test.\n'
          '\nA series of orange squares with X in the centre will randomly appear on your screen. To complete this test please tap the squares as soon as they appear. The time taken to select the squares after they appear is being tracked so react as quickly as possible.\n'
          '\nGood luck!';
    }
    return Scaffold(
      appBar: SimpleAppBar(
        text: 'Reaction Time Test Introduction',
        showExitButton: ModalRoute.of(context)?.settings.name == 'preDrive' ||
            ModalRoute.of(context)?.settings.name == 'edit',
        user: widget.user,
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            SimpleTextBox(text: message),
            SimpleButton(
                text: 'Begin',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReactionTimeIntro(
                            user: widget.user,
                            calibrate: widget.calibrate,
                            driveAssessment: widget.driveAssessment,
                          ),
                      settings: RouteSettings(
                          name: ModalRoute.of(context)!.settings.name)));
                })
          ])),
    );
  }
}
