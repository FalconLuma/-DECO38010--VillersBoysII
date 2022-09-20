
import 'package:flutter/material.dart';
import 'package:villers_boys_ii/reaction_time_test1.dart';
import 'package:villers_boys_ii/user.dart';

class ReactionTimeIntro extends StatefulWidget {
  const ReactionTimeIntro({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ReactionTimeIntro> createState() => IntroScreen();
}


class IntroScreen extends State<ReactionTimeIntro>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Tap screen when you are ready to start",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )

        ),
        body: Center(
          child:
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ReactionTimeTest(user: widget.user)))
          ),
        )
    );
  }
}