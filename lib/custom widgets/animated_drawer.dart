import 'package:flutter/material.dart';

class MyAnimatedDrawer extends StatelessWidget {

  final SizedBox child;
  final int cTime;

  const MyAnimatedDrawer({Key? key, required this.child, required this.cTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              width: 100,
              color: Theme.of(context).primaryColor,
              child: child,
            ),
        ),
      ),
        tween: Tween<double>(begin: 0, end: 1),
        curve: Curves.bounceOut,
        duration: Duration(seconds: cTime),
        builder: (BuildContext context, double _val, Widget? child) {
          return SizedBox(
              width: _val * 2000,//what direction and distance
                child: child,
          );
        });
  }
}