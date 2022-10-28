import 'package:flutter/material.dart';
import 'package:handleliste/backend/items.dart';
import 'package:handleliste/backend/services.dart';
import 'package:handleliste/custom%20widgets/add_list_card.dart';
import 'package:handleliste/custom widgets/data_table.dart';

class CreateList extends StatefulWidget {
  const CreateList({Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final String title = 'Flutter Data Table';
  late List<Item> _items;
  late TextEditingController _titleController;
  late Item _selectedItem;
  late bool _isUpdating;
  String _status = "So empty..";
  late GlobalKey<ScaffoldState> _createListScaffoldKey;
  String tName = "";
  int amount = 1;

  @override
  void initState() {
    super.initState();
    _items = [];
    _isUpdating = false;
    _titleController = TextEditingController(text: null);
    _createListScaffoldKey = GlobalKey();
    Services.createTable("Build");
    _getItems("Build");
  }

  _addItem(tName) {
    Services.addItem(amount.toString(), _titleController.text, tName)
        .then((result) {
      if ('success' == result) {
        _getItems(tName);
        _clearValues();
      }
    });
  }

  _getItems(tName) {
    Services.getItems(tName).then((items) {
      if (items.isNotEmpty) {
        _status = "";
      } else {
        _status = "So empty..";
      }
      setState(() {
        _items = items;
      });
      _clearValues();
    });
  }

  _updateItem(Item item, tName) {
    setState(() {
      _isUpdating = true;
    });
    Services.updateItem(
            item.id, amount.toString(), _titleController.text, tName)
        .then((result) {
      if ('success' == result) {
        _getItems(tName);
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteItem(Item item) {
    Services.deleteItem(item.id, "Build");
  }

  _replaceTable(tName) {
    Services.replaceTable(tName)
        .then((value) => {Navigator.pushReplacementNamed(context, "/home")});
  }

  //Clear text
  _clearValues() {
    _titleController.text = "";
    amount = 1;
  }

  //Clear text
  _showValues(Item item) {
    setState(() {
      _titleController.text = item.title;
      amount = int.parse(item.amount);
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
                      ),
                      const Spacer(),
                      Text(
                        "                    " +
                            item.amount.toUpperCase() +
                            "stk",
                        style: const TextStyle(fontSize: 14),
                      ),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteItem(item);
                            _getItems("Build");
                          }),
                    ],
                  ), onTap: () {
                _showValues(item);
                _selectedItem = item;
                setState(() {
                  _isUpdating = true;
                });
              }),
            ]),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      key: _createListScaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[100],
        title: const Center(
          child:
              Text("My shopping list", style: TextStyle(color: Colors.black)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                _data(),
              ],
            ),
          ),
          SizedBox(
              height: 105,
              child: ListView(
                children: [
                  AddListCard(
                    value: Text(amount.toString()),
                    child: Focus(
                      child: TextField(
                        controller: _titleController,
                      ),
                      onFocusChange: (hasFocus) {
                        if (_titleController.text.isEmpty) {
                          //print("Need item");
                        } else if (_titleController.text.isNotEmpty &&
                            _isUpdating == false) {
                          _addItem("Build");
                          _getItems("Build");
                        } else {
                          _updateItem(_selectedItem, "Build");
                          _getItems("Build");
                        }
                      },
                    ),
                    functionAdd: () {
                      setState(() {
                        if (amount < 99) amount++;
                      });
                    },
                    functionSubtract: () {
                      setState(() {
                        if (amount > 1) amount--;
                      });
                    },
                    functionFinish: () {
                      Services.getItems("Build").then((items) => {
                            if (items.isNotEmpty)
                              {
                                _replaceTable("Build"),
                              }
                            else
                              {
                                //print("Nothing inside table"),
                              }
                          });
                    },
                    functionRedo: () {
                      setState(() {
                        _clearValues();
                      });
                    },
                    functionCancel: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
