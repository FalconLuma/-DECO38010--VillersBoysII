import 'package:flutter/material.dart';
import 'package:villers_boys_ii/user.dart';

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
    double WIDTH = (MediaQuery. of(context). size. width) / 2;
    double HEIGHT = (MediaQuery. of(context). size. height) / 6;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Test: $_tnum",
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
        )

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  height: HEIGHT,
                  width: WIDTH,
                  child:
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      onPressed: (){}, child: const Text("Top Left"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent,
                          fixedSize: Size(WIDTH, HEIGHT),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: HEIGHT,
                  width: WIDTH,
                  child:
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: (){}, child: const Text("Top Right"),
                      style: ElevatedButton.styleFrom(

                          fixedSize: Size(WIDTH, HEIGHT)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              SizedBox(
                  height: HEIGHT,
                  width: WIDTH,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(WIDTH, HEIGHT)
                        ),
                        onPressed: (){}, child: Text("Bottom Left",),
                      )
                  )
              ),
              SizedBox(
                height: HEIGHT,
                width: WIDTH,
                child:
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: (){}, child: const Text("Bottom Right"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        fixedSize: Size(WIDTH, HEIGHT)
                    ),
                  ),
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