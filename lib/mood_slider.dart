import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ShowMoodSlider extends StatefulWidget {
  final double initialSliderValue;
  const ShowMoodSlider({Key key, this.initialSliderValue}) : super(key: key);
  @override
  _ShowMoodSliderState createState() => _ShowMoodSliderState();
}

class _ShowMoodSliderState extends State<ShowMoodSlider> {
  double _sliderValue;
  @override
  void initState() {
    super.initState();
    _sliderValue = widget.initialSliderValue;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$_sliderValue'),
      content: Container(
        child: Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          divisions: 5,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            Navigator.pop(context, _sliderValue);
          },
          child: Text('DONE'),
        )
      ],
    );
  }
}
