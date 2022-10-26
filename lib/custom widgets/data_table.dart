import 'package:flutter/material.dart';
import 'package:handleliste/backend/items.dart';

class QDataTable extends StatelessWidget {

  final Text label1;
  final Text label2;
  final List<DataRow> list;

  const QDataTable({Key? key, required this.label1, required this.label2, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: DataTable(columns: [
          DataColumn(label: label1),
          DataColumn(label: label2)
        ],
        rows: list,
        )
      ),
    );
  }
}
