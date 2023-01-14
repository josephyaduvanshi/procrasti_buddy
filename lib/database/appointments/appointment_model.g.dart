// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentModelAdapter extends TypeAdapter<AppointmentModel> {
  @override
  final int typeId = 4;

  @override
  AppointmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentModel(
      id: fields[0] as String?,
      isCompleted: fields[5] as bool?,
      appointmentName: fields[1] as String,
      appointmentDescription: fields[2] as String,
      appointmentDueDate: fields[3] as DateTime,
      appointmentPriority: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.appointmentName)
      ..writeByte(2)
      ..write(obj.appointmentDescription)
      ..writeByte(3)
      ..write(obj.appointmentDueDate)
      ..writeByte(4)
      ..write(obj.appointmentPriority)
      ..writeByte(5)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
