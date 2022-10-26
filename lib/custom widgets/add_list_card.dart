import 'package:flutter/material.dart';

class AddListCard extends StatelessWidget {

  final TextField inputTitle;
  final VoidCallback functionAdd;
  final VoidCallback functionSubtract;
  final VoidCallback functionFinish;
  final Text value;

  const AddListCard({ Key? key, required this.inputTitle, required this.functionAdd, required this.functionSubtract, required this.functionFinish, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Center(child: inputTitle),
        Row(children: [
          IconButton(onPressed: functionSubtract, icon: const Icon(Icons.remove)),
          value,
          IconButton(onPressed: functionAdd, icon: const Icon(Icons.add)),
          IconButton(onPressed: functionFinish, icon: const Icon(Icons.check))
        ],)
      ],),
    );
  }
}