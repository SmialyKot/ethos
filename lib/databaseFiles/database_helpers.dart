import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'mood_report.dart';

const String dataBoxName = "chart_data";


void initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoodReportAdapter());
  await Hive.openBox(dataBoxName);

}

void addData(String date, int mood, List<int> reasons) {
  final chartData = Hive.box(dataBoxName);
  var data = MoodReport()
  ..date = date
  ..mood = mood
  ..reasons = reasons;
  chartData.add(data);
}

void deleteDatabase() async {
  final chartData = Hive.box(dataBoxName);
  await chartData.deleteAll(chartData.keys);
}

