// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'makeplan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MakePlanModelAdapter extends TypeAdapter<MakePlanModel> {
  @override
  final int typeId = 1;

  @override
  MakePlanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MakePlanModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MakePlanModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.booked_from)
      ..writeByte(1)
      ..write(obj.resourceTitle)
      ..writeByte(2)
      ..write(obj.eventTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakePlanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
