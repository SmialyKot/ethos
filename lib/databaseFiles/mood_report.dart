import 'package:hive/hive.dart';

part 'mood_report.g.dart';


// Własny typ danych do bazy
@HiveType(typeId : 1)
class MoodReport extends HiveObject{
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double mood;

  @HiveField(2)
  List<int> reasons;
}