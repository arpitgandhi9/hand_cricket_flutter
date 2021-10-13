// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameInformationAdapter extends TypeAdapter<GameInformation> {
  @override
  final int typeId = 0;

  @override
  GameInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameInformation()
      ..tossWon = fields[0] as bool
      ..userPlayers = (fields[1] as List).cast<PlayerInformation>()
      ..aiPlayers = (fields[2] as List).cast<PlayerInformation>();
  }

  @override
  void write(BinaryWriter writer, GameInformation obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tossWon)
      ..writeByte(1)
      ..write(obj.userPlayers)
      ..writeByte(2)
      ..write(obj.aiPlayers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
