import 'package:flutter/material.dart';
import 'package:handleliste/backend/services.dart';
import 'package:handleliste/custom widgets/home_drawer.dart';
import 'package:handleliste/custom%20widgets/data_table.dart';
import 'package:handleliste/backend/items.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Item> _items;
  bool pressed = false;
  String _status = "No list";
  @override
  void initState() {
    super.initState();
    _items = [];
    super.initState();
    Services.createTable("Shop");
    Services.createTable("History");
    _getItems("Shop");
  }

  _getItems(tName) {
    Services.getItems(tName).then((items) {
      if (items.isNotEmpty) {
        _status = "";
      } else {
        _status = "No list";
      }
      setState(() {
        _items = items;
      });
    });
  }

  _completeItems(tName) {
    Services.getItems(tName).then((items) {
      if (items.isNotEmpty) {
        _status = "";
      } else {
        _status = "Complete";
      }
      setState(() {
        _items = items;
      });
    });
  }

  _deleteItem(Item item) async {
    await Services.deleteItem(item.id, "Shop");
    pressed = false;
    _completeItems("Shop");
  }

  _addItem(Item item, tName) {
    Services.addItem(item.amount, item.title, tName);
  }

  QDataTable _data() {
    return QDataTable(
      label1: Text(_status),
      list: _items
          .map(
            (item) => DataRow(cells: [
              DataCell(
                Row(
                  children: [
                    Text(
                      item.title.toUpperCase(),
                      textDirection: TextDirection.rtl,
                    ),
                    const Spacer(),
                    Text(
                      "                    " +
                          item.amount.toUpperCase() +
                          "stk",
                      style: const TextStyle(fontSize: 14),
                    ),
                    IconButton(
                        icon: const Icon(Icons.check_circle_outline_outlined,
                            color: Colors.green),
                        onPressed: () async {
                          if (pressed == false) {
                            pressed = true;
                            await _addItem(item, "History");
                            await _deleteItem(item);
                          }
                        }),
                  ],
                ),
              ),
            ]),
          )
          .toList(),
    );
  }

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
                children: <Widget>[
                  _data(),
                ],
              ),
            ),
            Center(
              child: IconButton(
                iconSize: 40,
                color: Colors.blue,
                icon: const Icon(Icons.shopping_cart_rounded),
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
