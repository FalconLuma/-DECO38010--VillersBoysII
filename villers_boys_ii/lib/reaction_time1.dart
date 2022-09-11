import 'package:flutter/material.dart';
import 'package:villers_boys_ii/home_page.dart';
import 'package:villers_boys_ii/user.dart';

import 'main_page.dart';

class ReactionTimePage extends StatefulWidget {
  const ReactionTimePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ReactionTimePage> createState() => _ReactionTimeState();
}

class _ReactionTimeState extends State<ReactionTimePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction Time Test'),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: Column(children: [
            Text(
                'In this activity, we will ask you to perform an activity used to'
                ' measure your reaction time!',
                style: TextStyle(fontSize: 20.0, letterSpacing: 2.0)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(user: widget.user)));
              },
              child: Icon(
                Icons.start_sharp,
                size: 50,
              ),
            )
          ])),
    );
  }
}
