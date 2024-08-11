import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

import '../../Provider/result_provider.dart';

class PieChartWidget extends StatelessWidget {
  final ResultData result;

  const PieChartWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Crop Management": result.cropManagement,
      "Soil Management": result.soilManagement,
      "Water Usage": result.waterUsage,
      "Energy Use": result.energyUse,
      "Waste Management": result.wasteManagement,
    };

    return PieChart(
      dataMap: dataMap,
      chartType: ChartType.disc,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: math.min(MediaQuery.of(context).size.width / 2.2, 300),
      colorList: [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.red,
        Colors.purple,
      ],
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesInPercentage: true,
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
    );
  }
}
