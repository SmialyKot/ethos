import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../databaseFiles/database_helpers.dart';
import 'package:hive_flutter/hive_flutter.dart';



class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {

  Box stateBox = Hive.box(dataBoxName);
  final _moodList = {
    1.0 : Text('Fatalny nastrój'),
    2.0 : Text('Słaby nastrój'),
    3.0 : Text('Przeciętny nastrój'),
    4.0 : Text('Dobry nastrój'),
    5.0 : Text('Wyśmienity nastrój!'),
  };
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dane szczegółowe"),
      ),
      body: ValueListenableBuilder(
                valueListenable: stateBox.listenable(),
                builder: (context, box, _) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(
                          color: Colors.black45,
                          height: 10.0,

                        ),
                    itemCount: ((box.values).toList()).length,
                    itemBuilder: (context, listIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: ListTile(
                            title: Text(
                                "${(((box.values).toList())[listIndex].date).toString()}"),
                            subtitle: _moodList[((box.values).toList())[listIndex].mood],
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteAtIndex(listIndex);
                              },
                            )
                        ),
                      );
                    },
                  );
                }

              ),
    );
            }
          }

