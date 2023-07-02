// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 18;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      title: fields[0] as String?,
      content: fields[1] as String?,
      id: fields[2] as String,
      isFavorite: fields[3] as bool,
      date: fields[4] as String,
      isHistory: fields[5] as bool,
      isTextCenter: fields[6] as bool,
      backgroundColor: fields[7] as String,
      color: fields[8] as String,
      fontSize: fields[9] as double,
      fontFamily: fields[11] as String,
      timestamp: fields[10] as String,
      canvas: fields[12] as String,
      blendMode: fields[13] as String,
      fontHeight: fields[14] as double,
      opacity: fields[15] as double,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isFavorite)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.isHistory)
      ..writeByte(6)
      ..write(obj.isTextCenter)
      ..writeByte(7)
      ..write(obj.backgroundColor)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.fontSize)
      ..writeByte(10)
      ..write(obj.timestamp)
      ..writeByte(11)
      ..write(obj.fontFamily)
      ..writeByte(12)
      ..write(obj.canvas)
      ..writeByte(13)
      ..write(obj.blendMode)
      ..writeByte(14)
      ..write(obj.fontHeight)
      ..writeByte(15)
      ..write(obj.opacity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
