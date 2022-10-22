import 'package:flutter/material.dart';
import 'drawer_nav.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 56),
        child: SizedBox(
          width: 60, //For drawer size
          child: Drawer(
            backgroundColor: Colors.transparent,
              elevation: 0.0, //Drop shadow (standard is 16.0)
              child: Column(
                children: const [
                  DrawerButtons(),
                ],
              )),
        ),
      ),
    );
  }
}