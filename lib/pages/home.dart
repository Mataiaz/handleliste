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
      drawer: const MyDrawer(),
      appBar: AppBar(),
      body: SafeArea(
        // query list will be here
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[],
              ),
            ),
            Center(
              child: IconButton(
                iconSize: 40,
                color: Colors.blue,
                icon: Icon(Icons.shopping_cart_rounded),
                onPressed: () {
                  Navigator.pushNamed(context, "/create_list");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
