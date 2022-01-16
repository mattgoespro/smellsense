// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scent_ratings.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScentRatingsAdapter extends TypeAdapter<ScentRatings> {
  @override
  final int typeId = 1;

  @override
  ScentRatings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScentRatings(
      (fields[0] as List)?.cast<ScentRating>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScentRatings obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.ratings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScentRatingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
