import 'package:flutter/material.dart';

import 'package:villers_boys_ii/user.dart';

import 'package:villers_boys_ii/settings_page.dart';
import 'package:villers_boys_ii/home_page.dart';
import 'package:villers_boys_ii/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title, required this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User user;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  late final pages = [
    SettingsPage(user: widget.user),
    HomePage(user: widget.user),
    ProfilePage(user: widget.user),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: pages[_selectedIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 35),
        unselectedIconTheme: const IconThemeData(size: 35),
      ),
    );
  }
}