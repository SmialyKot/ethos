import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowMoodSlider extends StatefulWidget {
  @override
  _ShowMoodSliderState createState() => _ShowMoodSliderState();
}

class _ShowMoodSliderState extends State<ShowMoodSlider> {

  double _sliderValue = 2.0;

  final separator = const Divider(
  color: Colors.white,
  height: 5,
  thickness: 2,
  indent: 5,
  endIndent: 0,
  );

  final _moodList = {
    0.0 : Text('Fatalny'),
    1.0 : Text('Słaby'),
    2.0 : Text('Przeciętny'),
    3.0 : Text('Dobry'),
    4.0 : Text('Wyśmienity!'),
  };
  // TODO implement reasons
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 285.0, horizontal: 50.0),
      title: Text('Jaki masz dzisiaj nastrój?'),
      content: Container(
        child: Center(
          child: Column(
            children: [
              separator,
              _moodList[_sliderValue],
              separator,
              Slider(
                value: _sliderValue,
                min: 0,
                max: 4,
                divisions: 4,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context, _sliderValue);
          },
          child: Text('GOTOWE'),
        )
      ],
    );
  }
}
