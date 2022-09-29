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
const MaterialColor primary = Colors.purple;
const MaterialColor secondary = Colors.orange;
Color? neutral = Colors.purple[100];
const MaterialColor grey = Colors.grey;
const MaterialColor start = Colors.green;