import 'dart:convert';
import 'package:http/http.dart' as http;
import 'items.dart';

class Services {
  static const ROOT = 'http://10.0.2.2/handlelisteDB/db.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const _DELETE_ALL_EMP_ACTION = 'DELETE_ALL_EMP';
  static const _REPLACE_ALL_ITEMS_ACTION = 'REPLACE_ALL_ITEMS';

  // get items
  static Future<List<Item>> getItems(String tName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ACTION;
      map['tName'] = tName;
      final Uri url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        List<Item> list = parseResponse(response.body);
        return list;
      } else {
        throw <Item>[];
      }
    } catch (e) {
      return <Item>[];
    }
  }
  
static List<Item> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Item>((json) => Item.fromJson(json)).toList();
  }

// Method to create a table
  static Future<String> createTable(String tName) async{
    try {
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION;
      map['tName'] = tName;
      final Uri url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to replace table content with another's
  static Future<String> replaceTable(String tName) async{
    try {
      var map = <String, dynamic>{};
      map['action'] = _REPLACE_ALL_ITEMS_ACTION;
      map['tName'] = tName;
      final Uri url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Add values to the table
  static Future<String> addItem(String amount, String title, String tName) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_EMP_ACTION;
      map["amount"] = amount;
      map["title"] = title;
      map["tName"] = tName;
      final Uri url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  // Method to Update values inside table
  static Future<String> updateItem(String empId, String amount, String title, String tName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['amount'] = amount;
      map['title'] = title;
      map['tName'] = tName;
      final Uri url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);
        return response.body;
    } catch (e) {
      return "error";
    }
  }

  //Method to delete value inside table
  static Future<String> deleteItem(String empId, String tName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      map['tName'] = tName;
      final Uri url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      return response.body;
    } catch (e) {
      return "error";
    }
  }

  // Method to delete all values inside table
  static Future<String> deleteAllItems(String tName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_ALL_EMP_ACTION;
      map['tName'] = tName;
      final Uri url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);
      return response.body;
    } catch (e) {
      return "error";
    }
  }
}
