import 'package:flutter/material.dart';
import 'animated_drawer.dart';

class DrawerButtons extends StatelessWidget {
  const DrawerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAnimatedDrawer(
          cTime: 6,
          child: SizedBox(
            child: IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/history');
              },
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ),
        MyAnimatedDrawer(
          cTime: 8,
          child: SizedBox(
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ),
      ],
    );
  }
}