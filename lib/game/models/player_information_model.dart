import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class PlayerInformation extends HiveObject {
  @HiveField(0)
  late int runs;

  @HiveField(1)
  late int balls;

  @HiveField(3)
  bool isPlaying = true;
}
