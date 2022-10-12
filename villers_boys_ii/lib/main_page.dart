// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:villers_boys_ii/user.dart';

import 'package:villers_boys_ii/settings_page.dart';
import 'package:villers_boys_ii/home_page.dart';
import 'package:villers_boys_ii/profile_page.dart';

import 'constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage(
      {Key? key, required this.title, required this.user, required this.index})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User user;
  final int index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// The pages that will appear in the bottom navigation bar.
  late final pages = [
    SettingsPage(user: widget.user),
    HomePage(user: widget.user),
    ProfilePage(user: widget.user),
  ];

  /// The index of the page currently being looked at.
  int _selectedIndex = 1;
  List<String> appBarText = ["Smart Seatbelt", 'Driving fatigued can kill', "User Profile"];
  String seatbeltInfo = "The Smart Seatbelt® device can connect to the TYRED app.\n"
  "\nVibration notifications are provided to you if dangerous levels of driver fatigue is detected by it's heart rate measuring technology.";
  //https://www.tmr.qld.gov.au/Safety/Driver-guide/Driving-safely/Driving-tired.aspx
  String mainInfo = "Fatigue isn't just about falling asleep while driving.\n\n"
  "Even brief lapses in concentration can have serious consequences.\n\n"
  "On average, between 2015 to 2019, approximately 12% of lives lost on Queensland roads were from fatigue-related crashes.\n\n"
  "However, this figure is likely to be higher, as it can be difficult to tell when fatigue is a contributing factor in crashes.\n\n"
  "It is important to recognise the warning signs of fatigue and take appropriate action.\n\n"
  "Being awake for more than 17 hours has a similar effect on performance as having a blood alcohol content of more than 0.05. So don't put yourself at risk.\n\n"
  "The risks of driving when tired apply even when you do not fall asleep at the wheel. Even short lapses in concentration caused by tiredness or drowsiness can have serious consequences on your driving.\n\n"
  "When you are experiencing fatigue, your brain can have short periods of sleep called 'microsleeps'. Microsleeps can last from a fraction of a second, up to 10 full seconds. You cannot control them.\n\n"
  ;


  void _openPopUp(BuildContext context){
    showModalBottomSheet(
      context: context,
      backgroundColor: neutral,
      isScrollControlled: true,
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(BORDER_RADIUS_CONTAINER),
              topRight: Radius.circular(BORDER_RADIUS_CONTAINER))
      ),
      builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: ImageIcon(
                      AssetImage(crossIcon),
                      size: 70,
                      color: darkBlue,
                    )
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_CONTAINER)),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      )]
                  ),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                    minHeight: MediaQuery.of(context).size.height * 0.7
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: _selectedIndex == 1,
                          child: Image(
                            image: AssetImage(qldGov),
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                        Text(
                          _selectedIndex == 1 ? mainInfo : seatbeltInfo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkBlue,
                              fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE
                          ),
                        ),
                      ],
                    )
                  )
                )
            ),
            Padding(padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
                onPressed: (){
                  if(widget.index == 1){
                    _launchUrl(Uri.parse("https://www.tmr.qld.gov.au/Safety/Driver-guide/Driving-safely/Driving-tired.aspx"));
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
                    )
                    )
                ),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Learn More',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    )
                )
              ),
            )
          ],
        ),
    );
  }

  /// Initialise the page to the specified index at construction.
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  /// Change the page being looked at when a bottom navigation bar item is
  /// tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Text(appBarText[_selectedIndex],
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * SUBHEADING_TEXT_SIZE
            ),
          ),
        ),
        actions: [
          Visibility (
            visible: (_selectedIndex == 2) ? false : true,
            child: IconButton(
              onPressed: (){
                _openPopUp(context);
              },
              icon: ImageIcon(
                AssetImage(infoIconColour),
                size: 50,
              )
            )
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(seatbeltOutline),
                color: deselectedColor,
              ),
              activeIcon: ImageIcon(
                AssetImage(seatbeltColour),
                color: darkBlue,
              ),
              label: 'Smart Seatbelt',
          ),

          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(carOutline),
                color: deselectedColor,
              ),
              activeIcon: ImageIcon(
                AssetImage(carColour),
                color: darkBlue,
              ),
              label: 'TYRED Drive',
          ),

          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(personOutline),
                color: deselectedColor,
              ),
              activeIcon: ImageIcon(
                AssetImage(personColour),
                color: darkBlue,
              ),
                label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(size: 35),
        unselectedIconTheme: const IconThemeData(size: 35),
      ),
    );
  }
}
