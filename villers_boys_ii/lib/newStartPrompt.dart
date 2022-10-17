import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/main_page.dart';

import 'package:villers_boys_ii/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Prompt the user for their user details
class newStartPrompt extends StatefulWidget {
  const newStartPrompt({Key? key, required this.user, required this.flag})
      : super(key: key);

  final User user;
  final bool flag;

  @override
  State<newStartPrompt> createState() => _newStartPromptState();
}

class _newStartPromptState extends State<newStartPrompt> {
  //Declare needed variables
  late SharedPreferences prefs;
  final name2 = new TextEditingController();
  final age2 = new TextEditingController();
  String name = "";
  int age = 0;
  double memoryBase = 0.0;
  double reactionBase = 0.0;
  double paddingBetweenFields = 40;
  String message = "Please enter your username and age to finish your profile.";
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: paddingBetweenFields),
              child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      "User Name:"
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: paddingBetweenFields),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_INPUT)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    )]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS_INPUT)
                    ),
                    //labelText: "User Name:",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: widget.user.getUserName(),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                  ),
                  controller: name2,
                  onSubmitted: (userName) {
                    setState(() {
                      widget.user.setUserName(userName);
                    });
                  },
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: paddingBetweenFields),
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Age:"
                    )
                )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: paddingBetweenFields),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(BORDER_RADIUS_INPUT)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    )]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS_INPUT)
                    ),
                    //labelText: "Age",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: widget.user.getAge().toString(),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                        MediaQuery.of(context).size.height * BODY_TEXT_SIZE),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: age2,
                  onSubmitted: (userName) {
                    setState(() {
                      widget.user.setUserName(userName);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: paddingBetweenFields),
              child :Text(
                message,
                style: TextStyle(
                    fontSize:
                    MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    letterSpacing: 2.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: paddingBetweenFields),
              child: ElevatedButton(
                  onPressed: () {
                    if (name2.text
                        .toString()
                        .isEmpty ||
                        age2.text
                            .toString()
                            .isEmpty) {
                      message =
                      "Please ensure both boxes have been filled out to continue!";
                      setState(() {});
                    } else {
                      save();
                      if (widget.flag == true) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainPage(
                                      title: 'Fatigue Management App',
                                      user: User(
                                          name, age, reactionBase,
                                          memoryBase),
                                      index: 1,
                                    )),
                                (route) => false);
                        // Go to home page, and reset route stack
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainPage(
                                      title: 'Fatigue Management App',
                                      user: User(
                                          name, age, reactionBase,
                                          memoryBase),
                                      index: 2,
                                    )),
                                (route) => false
                          // Return to home page, and reset route stack
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                      )
                      )
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Save',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      )
                  )
              ),
            ),
          ],
        )
    );
  }
  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("username", name2.text.toString());
    prefs.setInt("age", int.parse(age2.text));
    retrieve();
  }

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString("username")!;
    age = prefs.getInt("age")!;
    reactionBase = prefs.getDouble('reaction') ?? 0.0;
    memoryBase = prefs.getDouble('memory') ?? 0.0;
    setState(() {});
  }

  delete() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("username");

    name = "";
    setState(() {});
  }
}
