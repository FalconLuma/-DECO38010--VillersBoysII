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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02,
                bottom: MediaQuery.of(context).size.height*0.02),
                child: Text(
                  'Welcome ${widget.user.getUserName()}',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.11),
                  textAlign: TextAlign.center,

                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuestionairePage(user: widget.user)));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.85, MediaQuery.of(context).size.width * 0.85),
                  shape: const CircleBorder(),
                ),
                child: Text(
                  'Start Driving',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.2),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
