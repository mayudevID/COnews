// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_news_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllNewsDataAdapter extends TypeAdapter<AllNewsData> {
  @override
  final int typeId = 0;

  @override
  AllNewsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllNewsData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AllNewsData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.link)
      ..writeByte(2)
      ..write(obj.isoDate)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.mediaTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllNewsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
