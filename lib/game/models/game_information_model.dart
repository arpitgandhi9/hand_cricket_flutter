import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class GameInformation extends HiveObject {
  @HiveField(0)
  late bool tossWon;
}
