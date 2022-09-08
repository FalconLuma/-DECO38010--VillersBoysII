import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home:Home(),
));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction Time Test'),
        centerTitle: true,
      ),
      body: Container (
          margin: EdgeInsets.all(10),
          child: Column(
              children: [
                Text('In this activity, we will ask you to perform an activity used to'
                    ' measure your reaction time!',
                    style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0
                    )),
                ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/home_page');},
                  child:Icon(
                    Icons.start_sharp,
                    size: 50,
                  ),
                )
              ])),
    );
  }
}
