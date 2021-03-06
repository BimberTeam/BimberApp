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

  void showInfoDialog(IconData icon, Color color, String header, String text,
      BuildContext context) {
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
                content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: color,
                        size: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        header,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Baloo'),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Baloo'),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _button(
                        "OK",
                        () => hideDialog(context),
                        color,
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ])));
      },
    );
  }

  _button(String text, Function onPressed, Color buttonColor, Color textColor) {
    return RaisedButton(
      onPressed: onPressed,
      color: buttonColor,
      elevation: 5,
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor,
              fontFamily: 'Baloo',
              fontSize: 15.0,
              fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }

  void showActionDialog(
      {String text,
      BuildContext context,
      String confirmText,
      String cancelText,
      Color confirmButtonColor,
      Color cancelButtonColor,
      Function onConfirmed,
      Function onCanceled}) {
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
                              _button(confirmText, onConfirmed,
                                  confirmButtonColor, Colors.white),
                              SizedBox(
                                width: 10,
                              ),
                              _button(cancelText, onCanceled, cancelButtonColor,
                                  Colors.white)
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
