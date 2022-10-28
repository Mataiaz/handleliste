import 'package:flutter/material.dart';

class QDataTable extends StatelessWidget {

  final Text label1;
  final List<DataRow> list;

  const QDataTable({Key? key, required this.label1, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: DataTable(columns: [
          DataColumn(label: label1),
        ],
        rows: list,
        )
      ),
    );
  }
}
