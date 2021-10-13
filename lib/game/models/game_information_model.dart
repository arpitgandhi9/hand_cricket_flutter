import '../game.dart';
import 'package:hive/hive.dart';

part 'game_information_model.g.dart';

@HiveType(typeId: 0)
class GameInformation extends HiveObject {
  @HiveField(0)
  late bool tossWon;

  @HiveField(1)
  List<PlayerInformation> userPlayers = [];

  @HiveField(2)
  List<PlayerInformation> aiPlayers = [];
}
