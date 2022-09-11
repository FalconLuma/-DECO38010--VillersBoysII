import 'package:flutter/material.dart';

import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/questionaire_start.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Welcome ${widget.user.getUserName()}',
              style: const TextStyle(fontSize: 50),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuestionairePage(user: widget.user)));
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(350, 350),
              shape: const CircleBorder(),
            ),
            child: const Text(
              'Start Driving',
              style: TextStyle(fontSize: 75),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
