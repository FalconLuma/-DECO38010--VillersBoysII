import 'package:flutter/material.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/simple_appbar.dart';
import 'package:villers_boys_ii/simple_button.dart';
import 'package:villers_boys_ii/simple_textbox.dart';
import 'package:villers_boys_ii/user.dart';

import 'memory_test.dart';

class MemoryTestIntro extends StatefulWidget{
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
      '\nA sequence of numbered squares will randomly appear on a grid. The aim is to memorise their position and order. Then you will be shown numbered squares again and asked if they are in the correct position.\n'
      '\nGood luck!';

  @override
  Widget build(BuildContext context) {
    if (widget.calibrate) {
      message = 'You are about to begin your TYRED rating memory test.\n'
          '\nA sequence of numbered squares will randomly appear on a grid. The aim is to memorise their position and order. Then you will be shown numbered squares again and asked if they are in the correct position.\n'
          '\nGood luck!';
    }
    return Scaffold(
      //backgroundColor: neutral,
        appBar: SimpleAppBar(
          text:"Memory Test Introduction",
          showExitButton: ModalRoute.of(context)?.settings.name == 'preDrive' ||
              ModalRoute.of(context)?.settings.name == 'edit',
          user: widget.user,
        ),
        body: Center(
          child:
            Column(children: [
              SimpleTextBox(text: message),
              SimpleButton(
                text: 'Begin',
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MemoryTest(
                        user: widget.user,
                        calibrate: widget.calibrate,
                        driveAssessment: widget.driveAssessment,
                      ),
                      settings: RouteSettings(
                          name: ModalRoute.of(context)!.settings.name)));
                },
              )
        ]),
      )
    );
  }
}
