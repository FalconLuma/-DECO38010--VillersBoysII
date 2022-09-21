
import 'package:flutter/material.dart';
import 'package:villers_boys_ii/results_page.dart';
import 'package:villers_boys_ii/user.dart';

class MemoryTest extends StatefulWidget {
  const MemoryTest({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<MemoryTest> createState() => _MemoryTest();
}


class _MemoryTest extends State<MemoryTest>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Memory Test",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )

        ),
        body: Center(
          child:
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ResultsPage(user: widget.user)));
            },
            child: const Icon(
              Icons.start_sharp,
              size: 50,
            ),
          ),
        )
    );
  }
}