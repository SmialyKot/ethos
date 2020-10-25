import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class ShowMoodSlider extends StatefulWidget {
  @override
  _ShowMoodSliderState createState() => _ShowMoodSliderState();
}

class _ShowMoodSliderState extends State<ShowMoodSlider> {

  double _sliderValue = 2.0;
  List _reasons;

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
      insetPadding: EdgeInsets.symmetric(vertical: 200.0, horizontal: 50.0),
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
              separator,
              MultiSelectFormField(
                autovalidate: false,
                chipBackGroundColor: Colors.indigo,
                chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.indigo,
                checkBoxCheckColor: Colors.white54,
                dialogShapeBorder: RoundedRectangleBorder(),
                title: Text('Wybierz przyczynę'),
                dataSource: [
                  {
                    "display": "Praca",
                    "value": 0,
                  },
                  {
                    "display": "Zdrowie",
                    "value": 1,
                  },
                  {
                    "display": "Szkoła",
                    "value": 2,
                  },
                  {
                    "display": "Rodzina/Znajomi",
                    "value": 3,
                  },
                  {
                    "display": "Wypadek losowy",
                    "value": 4,
                  },
                ],
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'ANULUJ',
                hintWidget: Text("...jeśli chcesz"),
                initialValue: _reasons,
                onSaved: (value){
                  if(value == null) return;
                  setState(() {
                    _reasons = value;
                  });
                },

              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context, [_sliderValue, _reasons]);
          },
          child: Text('GOTOWE'),
        )
      ],
    );
  }
}