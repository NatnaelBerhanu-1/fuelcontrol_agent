import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartItem extends StatelessWidget {
  final gradientColor = [
    Color(0xFFF22613),
    Color(0xFFF29513),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildChartItem(context);
  }


  Widget _buildChartItem(BuildContext context){
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: false,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value){
            return FlLine(
              color: Colors.white,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value){
            return FlLine(
              color: Colors.white,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: false,
            reservedSize: 22,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            getTitles: (value){
              return '$value';
            },
            margin: 8,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
            getTitles: (value){
              return '$value';
            },
            margin: 10,
          ),
        ),
        borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.white, width: 1),
        ),minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 3.1),
              FlSpot(8, 4),
              FlSpot(9.5, 3),
              FlSpot(11, 4),
            ],
            isCurved: false,
            colors: gradientColor,
            barWidth: 2,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColor.map((color) => color.withOpacity(0.3)).toList(),
            )
          )
        ]
      ),
    );
  }

}

class TimeSeriesSimple {
  final DateTime time;
  final double sales;

  TimeSeriesSimple({this.time, this.sales});
}

