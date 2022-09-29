import 'package:flutter/material.dart';
import 'package:villers_boys_ii/user.dart';

import 'memory_test.dart';

class MemoryTestIntro extends StatefulWidget {
  const MemoryTestIntro({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<MemoryTestIntro> createState() => _MemoryTestIntroScreen();
}

class _MemoryTestIntroScreen extends State<MemoryTestIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Memory Test Intro",
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        )),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              debugPrint("End 2");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MemoryTest(user: widget.user)));
            },
            child: const Icon(
              Icons.start_sharp,
              size: 50,
            ),
          ),
        ));
  }
}
