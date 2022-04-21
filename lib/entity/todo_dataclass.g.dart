// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dataclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoDataClassAdapter extends TypeAdapter<TodoDataClass> {
  @override
  final int typeId = 0;

  @override
  TodoDataClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoDataClass(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TodoDataClass obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDataClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
