part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameTossResultEvent extends GameEvent {
  final CoinSide coinSide;
  final int selectedNumber;

  GameTossResultEvent(this.coinSide, this.selectedNumber);
}
