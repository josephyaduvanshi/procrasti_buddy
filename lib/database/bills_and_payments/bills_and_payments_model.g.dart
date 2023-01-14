// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_and_payments_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillPaymentModelAdapter extends TypeAdapter<BillPaymentModel> {
  @override
  final int typeId = 3;

  @override
  BillPaymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillPaymentModel(
      id: fields[0] as String?,
      isCompleted: fields[5] as bool?,
      billPaymentTitle: fields[1] as String,
      billPaymentDesc: fields[2] as String,
      billPaymentDueDate: fields[3] as DateTime,
      billPaymentPriority: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BillPaymentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.billPaymentTitle)
      ..writeByte(2)
      ..write(obj.billPaymentDesc)
      ..writeByte(3)
      ..write(obj.billPaymentDueDate)
      ..writeByte(4)
      ..write(obj.billPaymentPriority)
      ..writeByte(5)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillPaymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
