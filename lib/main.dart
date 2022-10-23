import 'package:flutter/material.dart';
import 'package:handleliste/pages/home.dart';
import 'package:handleliste/pages/create_list.dart';
import 'package:handleliste/pages/history.dart';
import 'package:handleliste/pages/settings.dart';

//Here we set the navigation routes for each page
void main() => runApp(MaterialApp(
  home: const Home(),
  routes: {
    '/home': (context) => const Home(),
    '/create_list': (context) => const CreateList(),
    '/history': (context) => const History(),
    '/settings': (context) => const Settings(),
  },
));