
import 'package:flutter/material.dart';
import 'package:villers_boys_ii/user.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}


class _ResultsPageState extends State<ResultsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Results",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )

        ),
        body: Center(
          child:
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
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