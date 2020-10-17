import 'package:flutter/material.dart';
import 'mood_chart.dart';
import 'add_mood_button.dart';
import 'databaseFiles/database_helpers.dart';
import 'package:intl/intl.dart';
import 'mood_slider.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _sliderValue = 50.0;

  final moodList = {
    0.0 : 1,
    25.0 : 2,
    50.0 : 3,
    75.0 : 4,
    100.0 : 5,
  };


  _saveToDatabase(int value){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd-Hm');
    final String currDate = formatter.format(now);
    addData(currDate, value, []);
  }

  
  void _moodSlider() async {
    final selectedMood = await showDialog<double>(
      context: context,
      builder: (context) => ShowMoodSlider(initialSliderValue: _sliderValue),
    );
    if (selectedMood != null)
    {
      setState(() {
        _sliderValue = selectedMood;
      });
      _saveToDatabase(moodList[_sliderValue]);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Hive.openBox(dataBoxName),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return Container();
            }
            return Container(
              child: MoodChart(),
            );
          }
          else
            return Container();
        },
      ),
      floatingActionButton: AddMood(
        onPressed: _moodSlider,
      ),
      );
  }
}
