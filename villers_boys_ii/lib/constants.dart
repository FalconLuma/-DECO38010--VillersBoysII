// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// Global size multipliers
/// Usage: MediaQuery.of(context).size.<width/height> * CONSTANT

// Text Sizes - Relative to size.height
const double HEADING_TEXT_SIZE = 0.06;
const double SUBHEADING_TEXT_SIZE = 0.035;
const double BODY_TEXT_SIZE = 0.03;
const double MAIN_BUTTON_TEXT_SIZE = 0.18;
const double MENU_BUTTON_TEXT_SIZE = 0.035;

// Widget Sizes
const double MAIN_BUTTON_SIZE = 0.85; // Always relative to size.width
const double BORDER_RADIUS_CONTAINER = 30;
const double BORDER_RADIUS_BUTTON = 20;
const double BORDER_RADIUS_INPUT = 100;
const double APPBAR_HEIGHT = 80;



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


// Images
//https://www.flaticon.com/free-icon/tire_2258674?related_id=2258674&origin=search
//https://www.flaticon.com/free-icon/sleep_2309958?term=sleep&page=1&position=74&page=1&position=74&related_id=2309958&origin=style
String tyredLogo = 'images/Tyred_Logo.png';
//https://www.flaticon.com/free-icon/pause_151859?term=pause&page=1&position=6&page=1&position=6&related_id=151859&origin=style
String tyredPause = 'images/Tyred_Logo_Pause.png';
//https://www.flaticon.com/free-icon/cancel_659891
String crossIcon = 'images/Cancel.png';
//https://www.flaticon.com/free-icon/information-button_1176?term=information&page=1&position=3&page=1&position=3&related_id=1176&origin=search
String infoIconOutline = 'images/Information_grey.png';
String infoIconColour = 'images/Information_blue.png';
//https://www.flaticon.com/free-icon/avatar_266134?term=profile&page=1&position=35&page=1&position=35&related_id=266134&origin=style
String personOutline = 'images/Profile_Grey.png';
String personColour = 'images/Profile_Blue.png';
//https://www.flaticon.com/free-icon/safety-belt_818231?term=seat%20belt&page=1&position=30&page=1&position=30&related_id=818231&origin=search
String seatbeltOutline = 'images/Seatbelt_Grey.png';
String seatbeltColour = 'images/Seatbelt_Blue.png';
//https://www.flaticon.com/free-icon/car_1085961?term=car&related_id=1085961
String carOutline = 'images/Car_Grey.png';
String carColour = 'images/Car_Blue.png';
//https://www.flaticon.com/free-icon/notification_5206484
String bellOutline = 'images/Notif_Grey.png';
//https://www.flaticon.com/free-icon/notification_5206603
String bellColour = 'images/Notif_Blue.png';
//https://www.flaticon.com/free-icon/wall-clock_833602?term=clock&page=1&position=3&page=1&position=3&related_id=833602&origin=style
String clock = 'images/Clock_Blue.png';
//https://www.flaticon.com/free-icon/heart_1077086?term=heart&page=1&position=10&page=1&position=10&related_id=1077086&origin=style
String heart = 'images/Heart_Blue.png';
//https://www.brandsoftheworld.com/logo/queensland-government?original=1
String qldGov = 'images/QLD_gov.png';

