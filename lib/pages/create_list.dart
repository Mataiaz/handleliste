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
  int amount = 1;

  @override
  void initState() {
    super.initState();
    _items = [];
    _isUpdating = false;
    _titleProgress = title;
    _titleController = TextEditingController(text: null);
    _createListScaffoldKey = GlobalKey();
    _getItems();
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

  _createTable() {
    _showProgress('Creating..');
    Services.createTable().then((result) {
      if ('success' == result) {
        showSnackBar(context, result);
        _showProgress(title);
      } else {
        showSnackBar(context, result);
      }
    });
  }

  _addItem() {
    Services.addItem(amount.toString(), _titleController.text).then((result) {
      if ('success' == result) {
        _getItems();
        showSnackBar(context, result);
        _showProgress(title);
        _clearValues();
      }
    });
  }

  _getItems() {
    _showProgress("loading");
    Services.getItems().then((items) {
      setState(() {
        _items = items;
      });
    });
  }

  _updateItem(Item item) {
    setState(() {
      _isUpdating = true;
    });
    Services.updateItem(item.id, amount.toString(), _titleController.text)
        .then((result) {
      if ('success' == result) {
        _getItems();
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteItem(Item item) {
    _showProgress('deleting');
    Services.deleteItem(item.id, amount.toString(), _titleController.text)
        .then((result) {
      if ('success' == result) {
        _getItems();
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
      key: _createListScaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
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
              height: 140,
              child: ListView(
                children: [
                  AddListCard(
                    value: Text(amount.toString()),
                    inputTitle: TextField(
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
                          _addItem();
                        }
                      });
                    },
                    functionRefresh: () {
                      setState(() {
                        //_updateItem();
                      });
                    },
                    functionCancel: () {
                      setState(() {
                        _isUpdating = false;
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
