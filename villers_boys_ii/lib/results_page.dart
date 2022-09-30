import 'package:flutter/material.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/drive_assessment.dart';
import 'package:villers_boys_ii/driving_page.dart';
import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/driving_page.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key? key, required this.user, required this.driveAssessment}) : super(key: key);
  final User user;
  final DriveAssessment driveAssessment;

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final fatiguelevels = [
    ['Low Fatigue', 'There is little indication that you suffering any fatigue '
        'that will impact you ability to drive'],
    ['Moderate Fatigue', 'You appear to be somewhat fatigued, consider using '
        'alterantive transport such as rideshare or public transport, if you do '
        'choose to drive be aware of any sign of tiredness'],
    ['Severe Fatigue', 'The tests indicate that you are heavily fatigued, avoid '
        'driving and seek alternative transport such as rideshare or public transport'
        ' for the safety of yourself and other road-users']
  ];

  //TODO Determine appropriate timers for each fatigue level
  final fatigueRestTimers = [
    Duration(hours: 2),
    Duration(hours: 1, minutes: 30),
    Duration(minutes: 30)
  ];

  late int fatigueLevel;

  @override
  void initState() {
    super.initState();
    fatigueLevel = widget.driveAssessment.getFatigue1();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.driveAssessment);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Results",
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      )),
      body: Center(
        child: Column(
          children: [
            Text(fatiguelevels[fatigueLevel][0],
              style: TextStyle(fontSize: MediaQuery.of(context).size.height * HEADING_TEXT_SIZE),
            ),
            Text(fatiguelevels[fatigueLevel][1],
              style: TextStyle(fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DrivingPage(restInterval: fatigueRestTimers[fatigueLevel])));
              },
              child: const Icon(
                Icons.start_sharp,
                size: 50,
              ),
            ),
            Text("Questionnaire:" + widget.driveAssessment.getQuestionnaireScore().toString()),
            Text("Baseline Reaction:" + widget.driveAssessment.user.getReactionBaseline().toString()),
            Text("Average Reaction:" + widget.driveAssessment.reactionTime.toString()),
            Text("Reaction Score:" + widget.driveAssessment.getReactionScore().toString()),
            Text("Baseline Memory:" + widget.driveAssessment.user.getMemoryBaseline().toString()),
            Text("Memory Test:" + widget.driveAssessment.getMemoryScore().toString() + "\n"),

            Text("Fatigue level Best of Three:" + widget.driveAssessment.getFatigue1().toString()),
            Text("Fatigue level Average:" + widget.driveAssessment.getFatigue2().toString()),
          ],
        )
      )
    );
  }
}
