import 'package:flutter/material.dart';

gettableView(details) {
  return DataTable(
    headingRowColor: MaterialStateProperty.all(Colors.white),
    columns: [
      DataColumn(label: Text("Course")),
      DataColumn(label: Text("Day")),
      // DataColumn(label: Text("d")),
    ],
    rows: [
      DataRow(
        cells: [
          DataCell(
            Text("ENG101".toUpperCase()),
          ),
          DataCell(
            Text('Monday'),
          ),
        ],
      ),
      //2
      DataRow(
        cells: [
          DataCell(
            Text("CS201 ".toUpperCase()),
          ),
          DataCell(
            Text('Thursday'),
          ),
        ],
      ),
      //3
      DataRow(
        cells: [
          DataCell(
            Text("MTH100 ".toUpperCase()),
          ),
          DataCell(
            Text('Friday'),
          ),
        ],
      ),

      //3
      DataRow(
        cells: [
          DataCell(
            Text("ISL001 ".toUpperCase()),
          ),
          DataCell(
            Text('Friday'),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text("STAT200 ".toUpperCase()),
          ),
          DataCell(
            Text('Tuesday'),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text("IT101 ".toUpperCase()),
          ),
          DataCell(
            Text('Thursday'),
          ),
        ],
      ),
    ],
  );
}
