// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// Global size multipliers
/// Usage: MediaQuery.of(context).size.<width/height> * CONSTANT

// Text Sizes - Relative to size.height
const double HEADING_TEXT_SIZE = 0.06;
const double SUBHEADING_TEXT_SIZE = 0.045;
const double BODY_TEXT_SIZE = 0.03;
const double MAIN_BUTTON_TEXT_SIZE = 0.18;
const double MENU_BUTTON_TEXT_SIZE = 0.04;

// Widget Sizes
const double MAIN_BUTTON_SIZE = 0.85; // Always relative to size.width

// Colours
const Color darkBlue = Color(0xFF1D4659);

const Map<int, Color> darkBlueMap = {
  50: Color.fromRGBO(29, 70, 89, .1),
  100: Color.fromRGBO(29, 70, 89, .2),
  200: Color.fromRGBO(29, 70, 89, .3),
  300: Color.fromRGBO(29, 70, 89, .4),
  400: Color.fromRGBO(29, 70, 89, .5),
  500: Color.fromRGBO(29, 70, 89, .6),
  600: Color.fromRGBO(29, 70, 89, .7),
  700: Color.fromRGBO(29, 70, 89, .8),
  800: Color.fromRGBO(29, 70, 89, .9),
  900: Color.fromRGBO(29, 70, 89, 1),
};

MaterialColor primary = const MaterialColor(0xFF1D4659, darkBlueMap);
const MaterialColor secondary = Colors.orange;
Color? deselectedColor = Colors.grey[800];
Color? neutral = Colors.grey[100];
const MaterialColor grey = Colors.grey;
const MaterialColor start = Colors.green;


// Images links
String tyredLogo = 'images/Tyred_Logo.png';
String crossIcon = 'images/Cancel.png';
String infoIconOutline = 'images/Information_grey.png';
String infoIconColour = 'images/Information_blue.png';
String personOutline = 'images/Profile_Grey.png';
String personColour = 'images/Profile_Blue.png';
String seatbeltOutline = 'images/Seatbelt_Grey.png';
String seatbeltColour = 'images/Seatbelt_Blue.png';
String carOutline = 'images/Car_Grey.png';
String carColour = 'images/Car_Blue.png';
String bellOutline = 'images/Notif_Grey.png';
String bellColour = 'images/Notif_Blue.png';

