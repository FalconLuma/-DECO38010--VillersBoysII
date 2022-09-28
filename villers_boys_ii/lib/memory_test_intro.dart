
import 'package:flutter/material.dart';
import 'package:villers_boys_ii/user.dart';

import 'constants.dart';
import 'memory_test.dart';

class MemoryTestIntro extends StatefulWidget {
  const MemoryTestIntro({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<MemoryTestIntro> createState() => _MemoryTestIntroScreen();
}


class _MemoryTestIntroScreen extends State<MemoryTestIntro>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Memory Test Intro",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )

        ),
        body: Center(
          child:
              Column (
                children: [
                  Text (
                      "In this activity, we will test your memory. To test this we will show a sequence of highlighted squares then ask a sequence of questions about the order of the tiles.",
                      style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                      letterSpacing: 2.0)
                  ),

                  ElevatedButton(

                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MemoryTest(user: widget.user)));
                    },
                    child: const Icon(
                      Icons.start_sharp,
                      size: 50,
                    ),
                  ),
                ]
              )
          ,
        )
    );
  }
}