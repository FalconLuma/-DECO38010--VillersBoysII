import 'package:flutter/material.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/user.dart';

import 'main_page.dart';

class ReactionTimeTest extends StatefulWidget {
  const ReactionTimeTest({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ReactionTimeTest> createState() => _ReactionTestState();
}

class _ReactionTestState extends State<ReactionTimeTest> {
  int _tnum = 0; // Test number

  // Create a list of reaction times
  List<int> rTimes = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Test: $_tnum",
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
        )

      ),
      body: Center(
        child: Column(children: [
          Row(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child:ElevatedButton(
                    onPressed: (){}, child: const Text("Top Left")
                )
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: (){}, child: const Text("Top Right")
                ),
              )
            ],
          ),
          Row(
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child:ElevatedButton(
                      onPressed: (){}, child: const Text("Bottom Left")
                  )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: (){}, child: const Text("Bottom Right")
                ),
              )
            ],
          )
        ],

        )
      )
    );
  }
}