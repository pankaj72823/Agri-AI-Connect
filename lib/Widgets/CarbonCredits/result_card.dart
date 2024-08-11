import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final double value;

  const ResultCard({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
