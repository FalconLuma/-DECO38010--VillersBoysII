import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villers_boys_ii/constants.dart';

import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/questionaire_start.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  String name = "";
  int age = 0;
  double memoryBase = 0;
  double reactionBase = 0;
  bool calibrate = true;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username') ?? "";
      age = prefs.getInt('age') ?? 0;
      memoryBase = prefs.getDouble('memory') ?? 4;
      reactionBase = prefs.getDouble('reaction') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (name.isEmpty || age == 0 || memoryBase == 0.0 || reactionBase == 0.0) {
      name = widget.user.getUserName();
      age = widget.user.getAge();
      memoryBase = widget.user.getMemoryBaseline();
      reactionBase = widget.user.getReactionBaseline();
    } else {
      widget.user.setUserName(name);
      widget.user.setAge(age);
      widget.user.setMemoryBaseline(memoryBase);
      widget.user.setReactionBaseline(reactionBase);
      save();
    }
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.02),
              child: Text(
                'Welcome ${widget.user.getUserName()}',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * HEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuestionairePage(user: widget.user)));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE,
                    MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE),
                shape: const CircleBorder(),
              ),
              child: Text(
                'Start Driving',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        MAIN_BUTTON_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ));
  }

  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("calibrate", true);
    calibrate = prefs.getBool("calibrate") ?? true;
  }
}
