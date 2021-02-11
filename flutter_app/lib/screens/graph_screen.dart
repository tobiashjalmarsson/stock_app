import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/line_chart_widget.dart';
class GraphScreen extends StatefulWidget {
  final String companyName;
  GraphScreen({Key key, @required this.companyName}) : super(key: key);
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    String company = widget.companyName;
    List<Color> gradientColors = [Color(0xff23b6e6), Color(0xff022d39a)];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          company,
        )
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 0, right: 30, top: 100, bottom: 100),
          height: double.infinity,
          width: double.infinity,
          child: LineChart(
            LineChartData(
              minX: 0, // min X axis
              maxX: 11, // max X axis
              minY: 0, // min Y axis
              maxY: 60, // max Y axis
              gridData: FlGridData(
                show: false,
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 8),
                    FlSpot(1, 10),
                    FlSpot(2, 30),
                    FlSpot(3, 32.5),
                    FlSpot(4, 20),
                    FlSpot(5, 22),
                    FlSpot(6, 37),
                    FlSpot(7, 40),
                    FlSpot(8, 33),
                    FlSpot(9, 44),
                    FlSpot(10, 50),
                    FlSpot(11, 47),
                    // First point
                  ],
                  isCurved: true,
                  colors: gradientColors,
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.5))
                        .toList()
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
