import 'package:flutter/material.dart';
import 'package:handleliste/backend/items.dart';
import 'package:handleliste/backend/services.dart';
import 'package:handleliste/custom%20widgets/add_list_card.dart';

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
  late String _titleProgress;
  late GlobalKey<ScaffoldState> _createListScaffoldKey;
  String tName = "";
  int amount = 1;

  @override
  void initState() {
    super.initState();
    _items = [];
    _isUpdating = false;
    _titleProgress = title;
    _titleController = TextEditingController(text: null);
    _createListScaffoldKey = GlobalKey();
    _createTable("Build");
    _getItems("Build");
  }

  // Show update progress
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  showSnackBar(context, message) {
    _createListScaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

 

  _createTable(tName) {
    _showProgress('Creating..');
    Services.createTable(tName).then((result) {
      if ('success' == result) {
        showSnackBar(context, result);
        _showProgress(title);
      } else {
        showSnackBar(context, result);
      }
    });
  }

  _addItem(tName) {
    Services.addItem(amount.toString(), _titleController.text, tName).then((result) {
      if ('success' == result) {
        _getItems(tName);
        showSnackBar(context, result);
        _showProgress(title);
        _clearValues();
      }
    });
  }

  _getItems(tName) {
    _showProgress("loading");
    Services.getItems(tName).then((items) {
      setState(() {
        _items = items;
      });
    });
  }

  _updateItem(Item item) {
    setState(() {
      _isUpdating = true;
    });
    Services.updateItem(item.id, amount.toString(), _titleController.text, tName)
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
    _showProgress('deleting');
    Services.deleteItem(item.id, amount.toString(), _titleController.text, tName)
        .then((result) {
      if ('success' == result) {
        _getItems(tName);
      }
    });
  }

  //Clear text
  _clearValues() {
    _titleController.text = "";
    amount = 1;
  }

  SingleChildScrollView _data() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text('Items'),
            ),
            DataColumn(
              label: Text('Amount'),
            ),
          ],
          rows: _items
              .map(
                (item) => DataRow(cells: [
                  DataCell(Text(item.title.toUpperCase())),
                  DataCell(Center(child: Text(item.amount.toUpperCase())))
                ]),
              )
              .toList(),
        ),
      ),
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
          child: Text("My shopping list",
          style: TextStyle(color: Colors.black)),
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
                    inputTitle: TextFormField(
                      controller: _titleController,
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
                      setState(() {
                        if (_titleController.text == "") {
                          //please write something
                        } else {
                          _addItem("Build");
                        }
                      });
                    },
                    functionRedo: () {
                      setState(() {
                        _isUpdating = false;
                      });
                      _clearValues();
                    },
                    functionCancel: () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, "/home");
                      });
                      _clearValues();
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
