import 'package:flutter/material.dart';

import 'package:villers_boys_ii/StartCalibrate.dart';
import 'package:villers_boys_ii/newStartPrompt.dart';
import 'package:villers_boys_ii/simple_button.dart';
import 'package:villers_boys_ii/user.dart';
import 'package:villers_boys_ii/constants.dart';

///This is the profile page
///Allows the user to view their supplied name and age along with
///the results from their calibration tests
///Gives the user the ability to change these values/re-calibrate
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Profile',
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height * HEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'User Details',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height *
                        SUBHEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(BORDER_RADIUS_CONTAINER)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
                  child: Text(
                    "User Name: ${widget.user.getUserName()}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height *
                            BODY_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 15, right: 16, bottom: 15),
                  child: Text(
                    "Age: ${widget.user.getAge()}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height *
                            BODY_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                SimpleButton(
                  text: 'Edit User',
                  onPressed: () {
                    _openPopUp(context, widget.user, false);
                  },
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Text(
                'Calibrated Performance',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height *
                        SUBHEADING_TEXT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(BORDER_RADIUS_CONTAINER)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 15, right: 16),
                      child: Text(
                        'Reaction: ${widget.user.getReactionBaseline().toStringAsFixed(1)}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height *
                                BODY_TEXT_SIZE),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 15, right: 16, bottom: 15),
                      child: Text(
                        'Memory: ${widget.user.getMemoryBaseline().toStringAsFixed(1)}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height *
                                BODY_TEXT_SIZE),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SimpleButton(
                      text: 'Recalibrate',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                StartCalibratePage(user: widget.user),
                            settings: const RouteSettings(name: 'edit')));
                      },
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  void _openPopUp(BuildContext context, User user, bool f) {
    showModalBottomSheet(
        context: context,
        backgroundColor: neutral,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(BORDER_RADIUS_CONTAINER),
                topRight: Radius.circular(BORDER_RADIUS_CONTAINER))),
        builder: (context) => Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: ImageIcon(
                        AssetImage(crossIcon),
                        size: 70,
                        color: darkBlue,
                      )),
                ],
              ),
              newStartPrompt(user: user, flag: false)
            ]
        )
    );
  }
}
