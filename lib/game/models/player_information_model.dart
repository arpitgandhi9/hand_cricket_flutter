import 'package:hive/hive.dart';

part 'player_information_model.g.dart';

@HiveType(typeId: 1)
class PlayerInformation extends HiveObject {
  @HiveField(0)
  int runs = 0;

  @HiveField(1)
  int balls = 0;

  @HiveField(3)
  bool isPlaying = true;
}
