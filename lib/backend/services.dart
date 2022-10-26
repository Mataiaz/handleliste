import 'dart:convert';
import 'package:http/http.dart' as http;
import 'items.dart';

class Services {
  static const ROOT = 'http://10.0.2.2/handlelisteDB/db.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  // Method to create table list
  static Future<String> createTable() async{
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
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

  // get items
  static Future<List<Item>> getItems() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('create table response : ${response.body}');
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
  // Add item to the list
  static Future<String> addItem(int antall, String tittel) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['antall'] = antall;
      map['tittel'] = tittel;
      final response = await http.post(Uri.parse(ROOT), body: map);
     print('create table response : ${response.body}');
      if (response.statusCode == 200) {
        List<Item> list = parseResponse(response.body);
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateItem(int empId, int antall, String tittel) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['antall'] = antall;
      map['tittel'] = tittel;
      final response = await http.post(Uri.parse(ROOT), body: map);
     print('update table response : ${response.body}');
      if (response.statusCode == 200) {
        List<Item> list = parseResponse(response.body);
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> deleteItem(int empId, int antall, String tittel) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      map['antall'] = antall;
      map['tittel'] = tittel;
      final response = await http.post(Uri.parse(ROOT), body: map);
     print('delete table response : ${response.body}');
      if (response.statusCode == 200) {
        List<Item> list = parseResponse(response.body);
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
