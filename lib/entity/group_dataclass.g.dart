// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dataclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupDataClassAdapter extends TypeAdapter<GroupDataClass> {
  @override
  final int typeId = 0;

  @override
  GroupDataClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupDataClass(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupDataClass obj) {
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
      other is GroupDataClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
