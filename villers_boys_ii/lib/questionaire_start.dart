import 'package:flutter/material.dart';
import 'package:villers_boys_ii/questionaire_test.dart';
import 'package:villers_boys_ii/simple_appbar.dart';
import 'package:villers_boys_ii/simple_button.dart';
import 'package:villers_boys_ii/simple_textbox.dart';
import 'package:villers_boys_ii/user.dart';

/// This page is designed to prepare the user for the questionnaire test
/// The user is given the option to cancel out of the activity and return to the main page
/// Or start the questionnaire test

class QuestionairePage extends StatefulWidget {
  const QuestionairePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<QuestionairePage> createState() => _QuestionaireState();
}

class _QuestionaireState extends State<QuestionairePage> {
  String message = 'You are about to begin your TYRED rating questionnaire.\n'
      '\nPlease answer the following multiple choice questions accurately and honestly to receive an accurate TYRED fatigue rating.\n'
      '\nIf you answer a question incorrectly, swipe back to have another go.\n'
      '\nGood Luck!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Create an appbar describing the page purpose and give an option to exit
      appBar: SimpleAppBar(text: "Questionaire Introduction", questionaire: true),
      //The main page content, contains the information text about the questionnaire and a button to move to the actual test
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              SimpleTextBox(text:message),
              SimpleButton(
                text: 'Begin',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          QuestionaireTestPage(user: widget.user)));
                }
              )
            ]
          )
      ),
    );
  }
}
