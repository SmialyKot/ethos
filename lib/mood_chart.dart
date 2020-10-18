import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'databaseFiles/database_helpers.dart';
import 'databaseFiles/mood_report.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  Box chartDataBox;
  bool dataSpan = false;
  DateFormat parser = DateFormat('yyyy-MM-dd hh:mm');
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final weekDays = {
    0 : "Pn",
    1 : "Wt",
    2 : "Śr",
    3 : "Czw",
    4 : "Pt",
    5 : "Sb",
    6 : "Nd",
  };

  @override
  void initState(){
    super.initState();
    Hive.openBox(dataBoxName);
    chartDataBox = Hive.box(dataBoxName);
  }

  /*
  List<FlSpot>_chartPoints(List<dynamic> data, {int days = 7}) {
    List<FlSpot> _points = [];
    var i = 0;
    print(data);
    if(data.length == 0) {
      _points.add(FlSpot(0.0, 0.0));
    }
    else
      {
    for(var temp in data){
      print(DateFormat('yyyy-MM-dd H:m').parse(temp.date));
      _points.add(FlSpot(i.toDouble(), (temp.mood).toDouble()));
      if(i == 6) break;
      i++;
    }}

    return _points;
  }*/
  List _chartPoints(List<dynamic> data, {int days=7}) {

    int daysDiff(var date) {
      return parser.parse(date).difference(DateTime.now()).inDays;
    }

    int _max = 0;


    for(var i = data.length-1; i > 0; i--) {
      var temp = data[i];
      var difference = daysDiff(temp.date);
      _max = max(difference, _max);
      if( difference > days)
        {
          data.removeRange(0, i);
          break;
        }
    }
    int numberOfPoints = data.length;
    if(numberOfPoints <= 1){
      return[{3 : "Za mało danych!"}, [FlSpot(0.0, 0.0),]];
    }


    var OX = {};
    List<FlSpot> moodValues = [];
    // TODO proper date adjustment system
    moodValues.add(FlSpot(0.0, (data[0]).mood));
    OX[0] = weekDays[(parser.parse((data[0].date))).weekday - 1];
    OX[6] = weekDays[(parser.parse((data[data.length-1].date))).weekday - 1];

    double placementPivot = 6/data.length;
    for(var i = 1; i < data.length - 1; i++){
      var temp = data[i];
      moodValues.add(FlSpot(i * placementPivot, temp.mood));
    }
    moodValues.add(FlSpot(6.0, (data[data.length-1]).mood));

    return [OX, moodValues];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: chartDataBox.listenable(),
        builder: (context, box, widget) {
          var chartData = box.values;
          //List<FlSpot> chartPoints; //_chartPoints(chartData.toList());// TODO get all data
          chartData = _chartPoints(chartData.toList());
          var OX = chartData[0];
          List<FlSpot> chartPoints = chartData[1];
          return Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.zero,
                      ),
                      color: Color(0xff232d37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 0.0, top: 24, bottom: 12),
                    child: LineChart(mainData(chartPoints, OX)),
                  ),
                ),
              ),
            ],
          );
        });
  }

  LineChartData mainData(List<FlSpot> chartPoints, Map days) {
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
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return days[value.toInt()]; // <----------------------------  DAYS
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
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
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      // AXIS MAX/MIN
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,

      lineBarsData: [
        LineChartBarData(
          // TODO Get data from database
          spots: chartPoints,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
