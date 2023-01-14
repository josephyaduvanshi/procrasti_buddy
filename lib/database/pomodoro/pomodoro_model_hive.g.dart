// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PomodoroHiveModelAdapter extends TypeAdapter<PomodoroHiveModel> {
  @override
  final int typeId = 1;

  @override
  PomodoroHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PomodoroHiveModel(
      sessionTime: fields[0] as int,
      shortBreakTime: fields[1] as int,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PomodoroHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sessionTime)
      ..writeByte(1)
      ..write(obj.shortBreakTime)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomodoroHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
