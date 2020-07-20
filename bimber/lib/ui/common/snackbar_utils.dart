import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context,
    {String message, Duration duration = const Duration(seconds: 2)}) {
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(message,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
            Icon(Icons.error)
          ],
        ),
        backgroundColor: Colors.red,
        duration: duration,
      ),
    );
}

final indicator = SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(lemonMeringue),
        strokeWidth: 2.0));

void showLoadingSnackbar(BuildContext context,
    {String message, Duration duration = const Duration(seconds: 2)}) {
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
        content: Row(
          children: [
            Text(message,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
            SizedBox(width: 15),
            indicator,
          ],
        ),
        backgroundColor: Colors.black.withOpacity(0.2),
        duration: duration));
}