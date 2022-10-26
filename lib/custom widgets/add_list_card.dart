import 'package:flutter/material.dart';

class AddListCard extends StatelessWidget {
  final VoidCallback functionAdd;
  final VoidCallback functionSubtract;
  final VoidCallback functionRedo;
  final VoidCallback functionFinish;
  final VoidCallback functionCancel;
  final Widget? child;
  final Text value;

  const AddListCard(
      {Key? key,
      required this.child,
      required this.functionAdd,
      required this.functionSubtract,
      required this.functionRedo,
      required this.functionFinish,
      required this.functionCancel,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      child: Column(
        children: [
          Center(child: child),
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: functionCancel,
                      iconSize: 30,
                      color: Colors.red,
                      icon: const Icon(Icons.cancel_outlined)),
                  IconButton(
                      onPressed: functionRedo,
                      iconSize: 30,
                      color: Colors.orange,
                      icon: const Icon(Icons.redo)),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: functionFinish,
                  iconSize: 30,
                  color: Colors.green,
                  icon: const Icon(Icons.check)),
              Spacer(),
              IconButton(
                  onPressed: functionSubtract, icon: const Icon(Icons.remove)),
              value,
              IconButton(onPressed: functionAdd, icon: const Icon(Icons.add)),
            ],
          )
        ],
      ),
    );
  }
}
