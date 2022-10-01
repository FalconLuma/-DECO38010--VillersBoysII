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
  double memoryTemp = 0;
  double reactionTemp = 0;
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
      memoryTemp = prefs.getDouble('memoryTemp') ?? 4;
      reactionTemp = prefs.getDouble('reactionTemp') ?? 0.0;
      if (memoryTemp != 4 && reactionTemp != 0.0) {
        prefs.setDouble('memory', memoryTemp);
        prefs.setDouble('reaction', reactionTemp);
        prefs.remove("memoryTemp");
        prefs.remove("reactionTemp");
      }
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
        body: ListView(
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
              child: Image.asset(
                'images/driving-control.png',
                height:
                    MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE * 0.8,
                width:
                    MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE * 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Text(
                'Tap above to determine your driver fatigue',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
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
