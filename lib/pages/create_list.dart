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

  void initState() {
    super.initState();
    _items = [];
    _isUpdating = false;
    _titleProgress = title;
    _titleController = TextEditingController(text: null);
    _createListScaffoldKey = GlobalKey();
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
        showSnackBar(context, result);
        _showProgress(title);
        _clearValues();
      }
    });
  }

  _getItem() {
    //
  }
  _updateItem() {
    //
  }

  _deleteItem() {
    //
  }

  //Clear text
  _clearValues() {
    _titleController.text = "";
    amount = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _createListScaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _getItem();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AddListCard(
              value: Text(amount.toString()),
              inputTitle: TextField(
                controller: _titleController,
              ),
              functionAdd: () {
                setState(() {
                  if(amount < 99)
                  amount++;
                });
              },
              functionSubtract: () {
                setState(() {
                  if(amount > 1)
                  amount--;
                });
              },
              functionFinish: () {
                setState(() {
                  if(_titleController.text == "") {
                    //please write something
                  }
                  else {
                    _addItem();
                  }
                });
              },
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _updateItem();
                    },
                    icon: const Icon(Icons.update)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isUpdating = false;
                      });
                      _clearValues();
                    },
                    icon: const Icon(Icons.cancel)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
