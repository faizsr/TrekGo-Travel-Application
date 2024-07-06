// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistAdapter extends TypeAdapter<Wishlist> {
  @override
  final int typeId = 0;

  @override
  Wishlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wishlist(
      hiveKey: fields[1] as String?,
      userId: fields[2] as String?,
      state: fields[3] as String?,
      name: fields[4] as String?,
      description: fields[5] as String?,
      location: fields[6] as String?,
      image: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Wishlist obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.hiveKey)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
