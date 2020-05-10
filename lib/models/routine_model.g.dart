// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineItemAdapter extends TypeAdapter<RoutineItem> {
  @override
  final typeId = 4;

  @override
  RoutineItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineItem(
      id: fields[0] as dynamic,
      routineText: fields[1] as String,
      routineTime: fields[2] as String,
      weekDay: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RoutineItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.routineText)
      ..writeByte(2)
      ..write(obj.routineTime)
      ..writeByte(3)
      ..write(obj.weekDay);
  }
}
