import 'package:flutter/material.dart';
import 'package:villers_boys_ii/constants.dart';
import 'package:villers_boys_ii/main_page.dart';

import 'package:villers_boys_ii/user.dart';
import 'StartCalibrate.dart';

class SimpleAppBar extends StatefulWidget implements PreferredSizeWidget{


  const SimpleAppBar({Key? key, required this.text, this.questionaire = false, this.showExitButton = true})
      : super(key: key);
  final showExitButton;
  final String text;
  final bool questionaire;

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
                            user: User("kevin", 32, 32, 32),
                            index: 1,
                          )),
                          (route) => false);
                } else if (ModalRoute.of(context)?.settings.name == 'edit') {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                            title: 'Fatigue Management App',
                            user: User("kevin", 32, 32, 32),
                            index: 2,
                          )),
                          (route) => false);
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => StartCalibratePage(
                              user: User("kevin", 32, 32, 32))),
                          (route) => false);
                }
              },
            ),
          )
        ]);
  }
}