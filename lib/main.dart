import 'package:flutter/material.dart';
import 'add_mood_button.dart';
import 'mood_slider.dart';
import 'database_helpers.dart';
import 'menu.dart';


void main() => runApp(Ethos());

void _openMenu(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Menu(), //TODO actual menu
    );
  }));
}

class Ethos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  double _sliderValue = 50.0;

  final moodList = {
    0.0 : 0,
    25.0 : 1,
    50.0 : 2,
    75.0 : 3,
    100.0 : 4,
  };

  _saveToDatabase(var value) async {
    Mood mood = Mood();
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.month, now.day, now.hour);
    mood.date = date.toString();
    mood.mood = value;
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.insert(mood);
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
      appBar: AppBar(
        title: Text('Ethos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _openMenu(context);
            },
            tooltip: 'Menu',
          )
        ],
      ),
      body: Container(
        color: Colors.white60,
      ),
      floatingActionButton: AddMood(
        onPressed: _moodSlider,
      ),
    );
  }
}


