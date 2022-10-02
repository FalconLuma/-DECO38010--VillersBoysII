import 'package:flutter/material.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/questionaire_test.dart';
import 'package:villers_boys_ii/user.dart';

import 'main_page.dart';

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
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Text(
                'Before you begin driving please complete the following questionnaire.'
                'The questionnaire will consist of 10 multiple-choice questions. If you answer a question incorrectly, swipe back to access the previous question.',
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
