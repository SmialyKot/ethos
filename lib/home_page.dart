import 'package:flutter/material.dart';
import 'mood_chart.dart';
import 'add_mood_button.dart';
import 'databaseFiles/database_helpers.dart';
import 'package:intl/intl.dart';
import 'mood_slider.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _moodSlider() async {
    double _sliderValue = 2;
    List _reasons;
    DateFormat _parser = DateFormat('yyyy-MM-dd HH:mm:ss');
    _saveToDatabase(double value) {
      final DateTime now = DateTime.now().toLocal();
      final DateTime currDate = _parser.parse(now.toString());
      addData(currDate, value, _reasons);
    }

    final selectedMood = await showDialog<List>(
      context: context,
      builder: (context) => ShowMoodSlider(),
    );

    if (selectedMood[0] != null) {
      setState(() {
        _sliderValue = selectedMood[0];
        _reasons = selectedMood[1].cast<int>();
      });
      var boxSize = Hive.box(dataBoxName).length;
      if (boxSize == 0) {
        _saveToDatabase(_sliderValue + 1); // slider<0, 4> +1 => <1, 5>
        return;
      }
      Duration difference = (DateTime.now().toLocal()).difference(
          ((Hive.box(dataBoxName).values).toList())[boxSize - 1].date);
      if (difference.inHours < 3) {
        return Alert(
            context: context,
            type: AlertType.info,
            title: 'Hola hola!',
            desc:
                'Odczekaj przynajmniej 3 godziny przed dodaniem kolejnych danych!',
            buttons: [
              DialogButton(
                  child: Text("Rozumiem"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]).show();
      } else
        _saveToDatabase(_sliderValue + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: MoodChart(),
      floatingActionButton: AddMood(
        onPressed: _moodSlider,
      ),
    );
  }
}
