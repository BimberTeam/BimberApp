import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class DialogUtils {
  bool _isDialogOpen = false;

  void showLoadingIndicatorDialog(BuildContext context, String text) {
    _isDialogOpen = true;
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

  void showIconDialog(
      IconData icon, Color color, String text, BuildContext context) {
    _isDialogOpen = true;
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

  _button(String text, Function onPressed, Color color) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      elevation: 5,
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Baloo',
              fontSize: 15.0,
              fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }

  void showActionDialog(
      {String text,
      BuildContext context,
      String buttonText1,
      String buttonText2,
      Color color1,
      Color color2,
      Function onPressed1,
      Function onPressed2}) {
    _isDialogOpen = true;
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _button(buttonText1, onPressed1, color1),
                              SizedBox(
                                width: 10,
                              ),
                              _button(buttonText2, onPressed2, color2)
                            ],
                          )
                        ]))));
      },
    );
  }

  void hideDialog(BuildContext context) {
    if (_isDialogOpen) {
      context.pop();
      _isDialogOpen = false;
    }
  }
}
