import 'package:flutter/material.dart';

import 'package:villers_boys_ii/user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          'Settings',
          style: TextStyle(fontSize: 50),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
