import 'package:flutter/material.dart';
import 'package:handleliste/backend/items.dart';
import 'package:handleliste/backend/services.dart';
import 'package:flutter/foundation.dart';


class CreateList extends StatefulWidget {
  const CreateList({Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final String title = 'Flutter Data Table';
  late List<Item> _items;
  late TextEditingController _titleController;
  late TextEditingController _numberController;
  late Item _selectedItem;
  late bool _isUpdating;
  late String _titleProgress;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  
  void initState() {
    super.initState();
    _items = [];
    _isUpdating = false;
    _titleProgress = title;
    _titleController = TextEditingController(text: null);
    _numberController = TextEditingController(text: null);
    _scaffoldKey = GlobalKey();
  }

  // Show update progress
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  _createTable() {
    _showProgress('Creating..');
    Services.createTable().then((result) {
      if('success' == result) {
        showSnackBar(context, result);
        _showProgress(title);
      }
      else {
        showSnackBar(context, result);
      }
    });
  }

  _addItem() {
    //
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
    _numberController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration.collapsed(
                    hintText: 'write what to buy. e.g milk, bread, paper'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _numberController,
                decoration: const InputDecoration.collapsed(hintText: 'what amount'),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _updateItem();
                    },
                    icon: const Icon(Icons.update)),
                IconButton(onPressed: () {
                  setState(() {
                    _isUpdating = false;
                  });
                  _clearValues();
                }, icon: const Icon(Icons.cancel)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
