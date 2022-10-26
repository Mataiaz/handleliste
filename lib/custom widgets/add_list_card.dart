import 'package:flutter/material.dart';

class AddListCard extends StatelessWidget {
  final TextField inputTitle;
  final VoidCallback functionAdd;
  final VoidCallback functionSubtract;
  final VoidCallback functionCancel;
  final VoidCallback functionRefresh;
  final VoidCallback functionFinish;
  final Text value;

  const AddListCard(
      {Key? key,
      required this.inputTitle,
      required this.functionAdd,
      required this.functionSubtract,
      required this.functionCancel,
      required this.functionRefresh,
      required this.functionFinish,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Center(child: inputTitle),
          Row(
            children: [
              IconButton(
                  onPressed: functionSubtract, icon: const Icon(Icons.remove)),
              value,
              IconButton(onPressed: functionAdd, icon: const Icon(Icons.add)),
              Spacer(),
              Row(
                children: [
                  IconButton(
                      onPressed: functionFinish,
                      icon: const Icon(Icons.cancel)),
                  IconButton(
                      onPressed: functionFinish,
                      icon: const Icon(Icons.refresh)),
                  IconButton(
                      onPressed: functionFinish, icon: const Icon(Icons.check)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
