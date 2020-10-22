import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'databaseFiles/database_helpers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  Box chartDataBox;
  bool dataSpan = false;
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState(){
    super.initState();
    Hive.openBox(dataBoxName);
    chartDataBox = Hive.box(dataBoxName);
  }


  List _chartPoints(List<dynamic> data, {int days=7}) { // TODO room for improvements

    final _weekDays = {
      0 : "Pn",
      1 : "Wt",
      2 : "Śr",
      3 : "Czw",
      4 : "Pt",
      5 : "Sb",
      6 : "Nd",
    };

    // Returns difference in days between dates
    int daysDiff(var date) {
      return date.difference(DateTime.now()).inDays;
    }
    // Returns day of the week
    int weekDay(var date){
      return date.weekday - 1;
    }
    // Returns dynamic X axis
    List xAxis (int pivot) {
      var keepIndex = {};
      var result = {};
      for(var i = pivot; i <= 6; i++)
      {
        result[i - pivot] = _weekDays[i];
        keepIndex[i] = (i - pivot).toDouble();
      }
      for(var i = 0; i < pivot; i++)
      {
        result[7 - pivot + i] = _weekDays[i];
        keepIndex[i] = (7 - pivot + i).toDouble();
      }
      return [result, keepIndex];
    }


    for(var i = data.length-1; i > 0; i--) {
      var temp = data[i];
      var difference = daysDiff(temp.date);
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



    var lastDay = weekDay(data[0].date);
    var response = xAxis(lastDay);
    var OX = response[0];
    var indexes = response[1];
    double getPosition(var date){
      var temp = date;
      double result = (temp.hour * 60 * 60 + temp.minute * 60 + temp.second).toDouble();
      return result;
    }
    // TODO chart beginning with a point?
    List<FlSpot> moodValues = [];
    const double secondsInDay = 86400;

    for(var i = 0; i < data.length; i++){
      var temp = data[i];
      double placementPivot = indexes[weekDay(temp.date)] + (getPosition(temp.date)/(secondsInDay));
      moodValues.add(FlSpot(placementPivot, temp.mood));
    }
    return [OX, moodValues];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: chartDataBox.listenable(),
        builder: (context, box, widget) {
          var chartData = box.values;
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
                    // <--------------------------- color
                  ),
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
            color: Colors.indigo,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.indigo,
            strokeWidth: 2,
          );
        },
      ),
      // <------------------------------ BOTTOM
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return days[value.toInt()]; // <----------------------------  DAYS
          },
          margin: 8,
        ),
        // <---------------------------------- LEFT
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.indigo,
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
        // <---------------------------- TOP
        topTitles: SideTitles(
          showTitles: true,
    getTextStyles: (value) => const TextStyle(
    color: Colors.indigo,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
          getTitles: (value) {
            if(value.toInt() == 3)
              { return "Ostatnie 7 dni";}
            return '';
          }

      ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.indigo, width: 1)),
      // AXIS MAX/MIN
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,

      lineBarsData: [
        LineChartBarData(
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
