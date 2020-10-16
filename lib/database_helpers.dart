import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String dataBoxName = "chart_data";


void initHive() async {
  await Hive.initFlutter();
  await Hive.openBox(dataBoxName);
}

void addData(List data) {
  final chartData = Hive.box(dataBoxName);
  chartData.add(data);
}

void deleteDatabase() async {
  final chartData = Hive.box(dataBoxName);
  await chartData.deleteFromDisk();
  initHive();
}