// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedAdapter extends TypeAdapter<Saved> {
  @override
  final int typeId = 1;

  @override
  Saved read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Saved(
      name: fields[0] as String?,
      rating: fields[1] as double?,
      description: fields[2] as String?,
      location: fields[3] as String?,
      image: fields[4] as String?,
      isSaved: fields[5] as bool?,
      firebaseid: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Saved obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.rating)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.isSaved)
      ..writeByte(6)
      ..write(obj.firebaseid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
