import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget{
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff022d39a),
  ];
  @override
  Widget build(BuildContext context) => LineChart(
    LineChartData(
      minX: 0, // min X axis
      maxX: 11, // max X axis
      minY: 0, // min Y axis
      maxY: 100, // max Y axis
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 25), // First point
          ],
        ),
      ],
    ),
  );
}