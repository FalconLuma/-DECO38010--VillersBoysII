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
        appBar: AppBar(
          toolbarHeight: APPBAR_HEIGHT,
            title: const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text( "Memory Test Introduction",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: ImageIcon(
                  AssetImage(crossIcon),
                  size: 70,
                  color: darkBlue,
                ),
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
            ]),
        body: Center(
          child: Column(children: [
            Padding(padding: EdgeInsets.all(20),
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
                  child: Text(
                    message,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                        fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE
                    ),
                  ),
                )
            ),
            /*
            Text(message,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    letterSpacing: 2.0)),

             */
            Padding(padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
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
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                      )
                      )
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                      child: Text('Begin',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      )
                  )
              ),
            )
            /*
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

             */
          ]),
        ));
  }
}
