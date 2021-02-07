// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training-rating.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingRatingAdapter extends TypeAdapter<TrainingRating> {
  @override
  final int typeId = 2;

  @override
  TrainingRating read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingRating()
      ..dateRatings = (fields[0] as Map)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List)?.cast<ScentRatings>()));
  }

  @override
  void write(BinaryWriter writer, TrainingRating obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dateRatings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingRatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
