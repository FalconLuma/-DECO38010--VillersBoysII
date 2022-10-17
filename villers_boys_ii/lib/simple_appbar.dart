import 'package:flutter/material.dart';

import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/main_page.dart';
import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/StartCalibrate.dart';

/// A simple appbar that sometimes will display a cross and fits the desired
/// style for the Tyred application
class SimpleAppBar extends StatefulWidget implements PreferredSizeWidget{

  const SimpleAppBar({Key? key, required this.text, this.questionaire = false, this.showExitButton = true, required this.user})
      : super(key: key);
  final showExitButton;
  final String text;
  final bool questionaire;
  final User user;

  @override
  State<SimpleAppBar> createState() => _newSimpleAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(APPBAR_HEIGHT);
}
class _newSimpleAppBarState extends State<SimpleAppBar> {
  //Declare needed variables
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: APPBAR_HEIGHT,
        //backgroundColor: neutral,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Text( widget.text,
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
                fontSize: 30 // TODO MediaQuery.of(context).size.height * HEADING_TEXT_SIZE,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Visibility(
            visible: widget.showExitButton,
            child:
            IconButton(
              icon: ImageIcon(
                AssetImage(crossIcon),
                size: 70,
                color: darkBlue,
              ),
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name == 'preDrive' || widget.questionaire) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                            title: 'Fatigue Management App',
                            user: widget.user,
                            index: 1,
                          )),
                          (route) => false);
                } else if (ModalRoute.of(context)?.settings.name == 'edit') {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                            title: 'Fatigue Management App',
                            user: widget.user,
                            index: 2,
                          )),
                          (route) => false);
                } else {
                  // Calibration
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => StartCalibratePage(
                              user: widget.user)),
                          (route) => false);
                }
              },
            ),
          )
        ]);
  }
}