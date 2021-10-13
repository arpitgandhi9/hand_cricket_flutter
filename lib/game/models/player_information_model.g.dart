// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerInformationAdapter extends TypeAdapter<PlayerInformation> {
  @override
  final int typeId = 1;

  @override
  PlayerInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerInformation()
      ..runs = fields[0] as int
      ..balls = fields[1] as int
      ..isPlaying = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, PlayerInformation obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.runs)
      ..writeByte(1)
      ..write(obj.balls)
      ..writeByte(3)
      ..write(obj.isPlaying);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
