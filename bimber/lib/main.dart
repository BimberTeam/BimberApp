import 'package:bimber/app.dart';
import 'package:bimber/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(App());
}
