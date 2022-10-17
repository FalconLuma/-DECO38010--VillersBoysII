import 'package:flutter/material.dart';
import 'package:villers_boys_ii/constants.dart';

/// A simple button that is in the style of the Tyred application
class SimpleButton extends StatefulWidget{
  const SimpleButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  @override
  State<SimpleButton> createState() => _newSimpleButtonState();
}
class _newSimpleButtonState extends State<SimpleButton> {
  //Declare needed variables
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_BUTTON))
              )
              )
          ),
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
              child: Text(widget.text,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * BODY_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              )
          )
      ),
    );
  }
}