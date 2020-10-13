import 'package:Ethos/home_page.dart';
import 'package:flutter/material.dart';
import 'add_mood_button.dart';
import 'mood_slider.dart';
import 'database_helpers.dart';
import 'menu.dart';
import 'home_page.dart';

void main() => runApp(Ethos());

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
  final _pageController = PageController(initialPage: 0);
  var currentPage = 0;
  final pageMatrix = [1, 0];
  DatabaseHelper helper = DatabaseHelper.instance;

  final moodList = {
    0.0 : 0,
    25.0 : 1,
    50.0 : 2,
    75.0 : 3,
    100.0 : 4,
  };

  Future<int> _getLastItemId() async{
    int temp = await helper.lastRowID();
    return temp;
  }
  /*
  _getData() async {
    int lastId = _getLastItemId();
    var data = new Map();
    for(var i = 1; i <= lastId; i++)
    {
      Mood mood = await helper.queryMood(i);
      if (mood != null)
      {
        data[mood.date] = mood.mood;
      }
    }
    return data;
  }*/

  _saveToDatabase(var value) async {
    Mood mood = Mood();
    DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.month, now.day, now.hour, now.minute); // TODO this is not doing what it's supposed to
    mood.date = now.toString();
    mood.mood = value;
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
    print(await _getLastItemId());
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Ethos')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {
              _pageController.animateToPage(pageMatrix[currentPage], duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
            },
          )
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        children: [
          HomePage(),
          Menu(),
        ],
        onPageChanged: (num) {
          currentPage = num;
        },
      ),
      floatingActionButton: AddMood(
        onPressed: _moodSlider,
      ));
  }
}


