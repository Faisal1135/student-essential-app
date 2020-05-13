// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteTagAdapter extends TypeAdapter<NoteTag> {
  final typeId = 6;
  @override
  NoteTag read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteTag.Home;
      case 1:
        return NoteTag.Work;
      case 2:
        return NoteTag.Notes;
      case 3:
        return NoteTag.Complete;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, NoteTag obj) {
    switch (obj) {
      case NoteTag.Home:
        writer.writeByte(0);
        break;
      case NoteTag.Work:
        writer.writeByte(1);
        break;
      case NoteTag.Notes:
        writer.writeByte(2);
        break;
      case NoteTag.Complete:
        writer.writeByte(3);
        break;
    }
  }
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  final typeId = 5;
  @override
  NoteModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      title: fields[0] as String,
      content: fields[2] as String,
      datetime: fields[3] as DateTime,
      noteTag: fields[4] as NoteTag,
      isImportent: fields[5] as bool,
      id: fields[6] as String,
    );
    // ..id = fields[6] as String
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.datetime)
      ..writeByte(4)
      ..write(obj.noteTag)
      ..writeByte(5)
      ..write(obj.isImportent)
      ..writeByte(6)
      ..write(obj.id);
  }
}
