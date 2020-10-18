import 'package:hive/hive.dart';

part 'mood_report.g.dart';

@HiveType(typeId : 1)
class MoodReport extends HiveObject{
  @HiveField(0)
  String date;

  @HiveField(1)
  double mood;

  @HiveField(2)
  List<int> reasons;
}