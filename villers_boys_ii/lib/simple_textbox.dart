import 'package:flutter/material.dart';
import 'package:villers_boys_ii/constants.dart';

/// A simple text box that fits the style off the Tyred application
class SimpleTextBox extends StatefulWidget{
  const SimpleTextBox({Key? key, required this.text})
      : super(key: key);

  final String text;

  @override
  State<SimpleTextBox> createState() => _newSimpleTextBoxState();
}
class _newSimpleTextBoxState extends State<SimpleTextBox> {
  //Declare needed variables
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20),
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
          child: Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBlue,
                fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE
            ),
          ),
        )
    );
  }
}