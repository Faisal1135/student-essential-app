// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultModelAdapter extends TypeAdapter<ResultModel> {
  final typeId = 0;
  @override
  ResultModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultModel(
      id: fields[0] as String,
      courseName: fields[1] as String,
      credit: fields[2] as double,
      grade: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ResultModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.courseName)
      ..writeByte(2)
      ..write(obj.credit)
      ..writeByte(3)
      ..write(obj.grade);
  }
}

class ResultsAdapter extends TypeAdapter<Results> {
  final typeId = 1;
  @override
  Results read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Results(
      id: fields[0] as String,
      results: (fields[2] as List)?.cast<ResultModel>(),
      username: fields[1] as String,
      cgpa: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Results obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.results)
      ..writeByte(3)
      ..write(obj.cgpa);
  }
}
