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
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ScentRating obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.scentName)
      ..writeByte(1)
      ..write(obj.rating)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.severity)
      ..writeByte(4)
      ..write(obj.feeling);
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
