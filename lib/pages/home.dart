import 'package:flutter/material.dart';
import 'package:handleliste/custom widgets/home_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(),
      body: SafeArea(
        // query list will be here
        child: Container(),
      ),
    );
  }
}
