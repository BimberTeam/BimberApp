import 'package:flutter/material.dart';

class ThemedPrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;

  ThemedPrimaryButton({@required this.onPressed, @required this.label});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      disabledColor: Colors.grey,
      onPressed: onPressed,
      child: Text(label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }
}
