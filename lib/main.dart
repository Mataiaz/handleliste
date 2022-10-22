import 'package:flutter/material.dart';
import 'package:handleliste/pages/home.dart';
import 'package:handleliste/pages/create_list.dart';
import 'package:handleliste/pages/history.dart';
import 'package:handleliste/pages/settings.dart';

//Here we set the navigation routes for each page
void main() => runApp(MaterialApp(
  home: Home(),
  routes: {
    '/home': (context) => Home(),
    '/create_list': (context) => CreateList(),
    '/history': (context) => History(),
    '/settings': (context) => Settings(),
  },
));