// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodReportAdapter extends TypeAdapter<MoodReport> {
  @override
  final int typeId = 1;

  @override
  MoodReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodReport()
      ..date = fields[0] as DateTime
      ..mood = fields[1] as double
      ..reasons = (fields[2] as List)?.cast<int>();
  }

  @override
  void write(BinaryWriter writer, MoodReport obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.mood)
      ..writeByte(2)
      ..write(obj.reasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
