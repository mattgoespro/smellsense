// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scent-rating.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScentRatingAdapter extends TypeAdapter<ScentRating> {
  @override
  final int typeId = 0;

  @override
  ScentRating read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScentRating(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ScentRating obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.scentName)
      ..writeByte(1)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScentRatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
