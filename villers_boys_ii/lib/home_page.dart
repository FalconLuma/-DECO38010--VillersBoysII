import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_shadow/simple_shadow.dart';
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

  /// Initialising the page by loading in the user's saved data.
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    loadData();
  }

  /// Load the data of the user saved on the device into the respective
  /// instance variables.
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
      // Set user to the one that is saved to the device.
      widget.user.setUserName(name);
      widget.user.setAge(age);
      widget.user.setMemoryBaseline(memoryBase);
      widget.user.setReactionBaseline(reactionBase);
      save();
    }

    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuestionairePage(user: widget.user)));
              },
              child: SimpleShadow(
                offset: Offset(0,5),
                sigma: 4,
                child: Image(
                  image: AssetImage(tyredLogo),
                  width: MediaQuery.of(context).size.width * MAIN_BUTTON_SIZE,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Text(
                'Tap to determine your TYRED fatigue rating',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
    );
  }

  /// Save whether or not the user has completed calibration to the device.
  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("calibrate", true);
    calibrate = prefs.getBool("calibrate") ?? true;
  }
}
