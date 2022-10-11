import 'package:flutter/material.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/driving_page.dart';
import 'package:villers_boys_ii/user.dart';

import 'main_page.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key? key, required this.user, required this.driveAssessment})
      : super(key: key);
  final User user;
  final DriveAssessment driveAssessment;

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final fatiguelevels = [
  "You are not showing symptoms of driver fatigue.\n\nYou should still stop driving for at least 15 minutes every 2 hours.\n\nNever drive for more than 10 hours in a single day.",

  "You are begining to show symptoms of driver fatigue.\n\n You should stop driving for at least 15 minutes every 2 hours. Utilise rest areas, tourist spots and driver reviver stops.\n\nIf you really need to keep driving, try some of the following:\n\n •Lower the cars interior temparature (putting the aircon on high)\n"
  "• Try adjusting and focusing on your seating posture\n"
  "• Try increasing or turning on some music\n"
  "• Try a caffinated drink, it can help temporarily boost energy levels\n",

  "You are showing symptoms of severe driver fatigue.\n\n You must stop driving and rest as soon as possible. Utilise rest areas, tourist spots and driver reviver stops.\n\nIf you really need to keep driving, try some of the following:\n\n •Lower the cars interior temparature (putting the aircon on high)\n"
      "• Try adjusting and focusing on your seating posture\n"
      "• Try increasing or turning on some music\n"
      "• Try a caffinated drink, it can help temporarily boost energy levels\n"
  ];

  final fatigueRestTimers = [
    const Duration(hours: 2),
    const Duration(hours: 1, minutes: 30),
    const Duration(minutes: 30)
  ];

  late int fatigueLevel;

  @override
  void initState() {
    super.initState();
    fatigueLevel = widget.driveAssessment.getFatigue1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Driver Fatigue Tips",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                            title: 'Fatigue Management App',
                            user: User("kevin", 32, 32, 32),
                            index: 1,
                          )),
                  (route) => false);
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
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
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.75,
                      minHeight: MediaQuery.of(context).size.height * 0.75
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      fatiguelevels[fatigueLevel],
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DrivingPage(
                            restInterval: fatigueRestTimers[fatigueLevel],
                            level: fatigueLevel,
                          )));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                    ))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                  child: Text('Finish',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  )
                )
              ),
            ],
        )));
  }
}
