part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameTossResultEvent extends GameEvent {
  final BuildContext context;
  final CoinSide coinSide;
  final int selectedNumber;

  GameTossResultEvent(
    this.context, {
    required this.coinSide,
    required this.selectedNumber,
  });
}

class GameNumberSelectionEvent extends GameEvent {
  final BuildContext context;
  final int selectedNumber;

  GameNumberSelectionEvent(
    this.context, {
    required this.selectedNumber,
  });
}
