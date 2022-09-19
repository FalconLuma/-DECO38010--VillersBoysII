import 'package:flutter/material.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/questionaire_test.dart';
import 'package:villers_boys_ii/user.dart';

class QuestionairePage extends StatefulWidget {
  const QuestionairePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<QuestionairePage> createState() => _QuestionaireState();
}

class _QuestionaireState extends State<QuestionairePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire Start'),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Text(
                'Before you begin driving you will need to complete some quick questionnaires and tests'
                ' to establish a level of fatigue. The following activity is a 10 questions questionnaire with 5 potential answers. '
                'Please answer each question honestly and to the best of your ability. If you answer a question incorrectly feel free to swipe'
                'back to the previous question',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height*BODY_TEXT_SIZE, letterSpacing: 2.0)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        QuestionaireTestPage(user: widget.user)));
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
