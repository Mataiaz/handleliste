import 'package:flutter/material.dart';
import 'package:handleliste/backend/services.dart';

class History extends StatefulWidget {
  const History({ Key? key }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

 @override
  void initState() {
    super.initState();
    Services.createTable("History");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
    );
  }
}