import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';


void showLoadingIndicator(String text, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              content: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            child: Container(
                                child:
                                    CircularProgressIndicator(strokeWidth: 3),
                                width: 32,
                                height: 32),
                            padding: EdgeInsets.only(bottom: 16)),
                        Text(
                          text,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryVariant,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Baloo'),
                          textAlign: TextAlign.center,
                        )
                      ]))));
    },
  );
}

void showIconDialog(IconData icon, Color color, String text, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              content: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            child: Container(
                                child: Icon(
                              icon,
                              color: color,
                              size: 50,
                            )),
                            padding: EdgeInsets.only(bottom: 16)),
                        Text(
                          text,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryVariant,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Baloo'),
                          textAlign: TextAlign.center,
                        )
                      ]))));
    },
  );
}

void hideDialog(BuildContext context) {
  context.pop();
}
