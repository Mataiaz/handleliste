import 'package:flutter/material.dart';
import 'package:handleliste/backend/services.dart';
import 'package:handleliste/custom widgets/home_drawer.dart';
import 'package:handleliste/custom%20widgets/data_table.dart';
import 'package:handleliste/pages/create_list.dart';
import 'package:handleliste/backend/items.dart';


class History extends StatefulWidget {
  const History({ Key? key }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late List<Item> _items;
  late Item _selectedItem;
  String _status = "No list";
  @override
  void initState() {
    super.initState();
    _items = [];
    super.initState();
    Services.createTable("Shop");
    Services.createTable("History");
    _getItems("History");
  }

  _getItems(tName) {
    Services.getItems(tName).then((items) {
      if (items.isNotEmpty) {
        _status = "";
      } else {
        _status = "So empty...";
      }
      setState(() {
        _items = items;
      });
    });
  }

  _deleteItem(Item item) {
    Services.deleteItem(item.id, "History").then((result) {
    });
  }

  _addItem(Item item, tName) {
    Services.addItem(item.amount, item.title, tName)
        .then((result) {
      _deleteItem(item);
      if ('success' == result) {
        _getItems("History");
      }
    });
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
                      style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.red),
                    ),
                    Spacer(),
                    Text(
                      "                    " +
                          item.amount.toUpperCase() +
                          "stk",
                      style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.red),
                    ),
                    MaterialButton(onPressed: () {
                      _addItem(item, "Shop");
                    }, child: Text("Restore")),
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
      appBar: AppBar(
        leading: 
          IconButton(onPressed: () {
          Navigator.pushReplacementNamed(context, "/home");
        }, icon: Icon(Icons.arrow_back)),
      ),
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
          ],
        ),
      ),
    );
  }
}