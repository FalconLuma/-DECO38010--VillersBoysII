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
                'Before you begin driving please complete the following questionnaire.'
                'The questionnaire will consist of 10 multi-choice questions. Please answer all questions honestly '
                'and if you believe you have made a mistake feel free to swipe back to the previous question and answer again.'
                ' After completing the questionaire you will be directed to a reaction test automatically. Select the following button to begin the questionnaire:',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    letterSpacing: 2.0)),
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
