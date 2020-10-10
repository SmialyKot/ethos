import 'package:flutter/material.dart';
import 'add_mood_button.dart';
import 'mood_slider.dart';

void main() => runApp(Ethos());

void _openMenu(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Text('Nothing yet'), //TODO actual menu
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


