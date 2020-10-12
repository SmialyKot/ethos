import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'database_helpers.dart';

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  // Extract ID of the last row in database
  _getLastItemNumber() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int temp = await helper.getCount();
    print(temp);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.zero,),
            color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 0.0, top: 24, bottom: 12),
              child: LineChart(mainData()),
            ),

          ),
        ),
      ],
    );
  }


  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            // TODO get dates from database
            const days = {
              0 : "Pon",
              1 : "Wt",
              2 : "Śr",
              3 : "Czw",
              4 : "Pt",
              5 : "Sob",
              6 : "Ndz"
            };
            return days[value.toInt()];
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      // AXIS MAX/MIN
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,

      lineBarsData: [
        LineChartBarData(
          // TODO Get data from database
          spots: [
            FlSpot(0, 4),
            FlSpot(1, 2),
            FlSpot(2, 2),
            FlSpot(3, 3),
            FlSpot(4, 2),
            FlSpot(5, 5),
            FlSpot(6, 3),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }
}
