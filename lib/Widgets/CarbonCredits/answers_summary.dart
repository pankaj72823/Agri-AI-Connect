import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AnswersSummary extends StatelessWidget {
  final List<Map<String, dynamic>> answers;
  final Map<String, double> carbonData;

  const AnswersSummary({
    super.key,
    required this.answers,
    required this.carbonData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...answers.map((answer) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question: ${answer['question']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Answer: ${answer['answer']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 16.0),
        Text(
          'Carbon Footprint Breakdown',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        PieChart(
          dataMap: carbonData,
          chartType: ChartType.disc,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 2.2,
          colorList: [
            Colors.blue,
            Colors.green,
            Colors.orange,
            Colors.red,
            Colors.purple,
          ],
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: false,
          ),
          legendOptions: LegendOptions(
            showLegends: true,
            legendPosition: LegendPosition.right,
            showLegendsInRow: false,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
