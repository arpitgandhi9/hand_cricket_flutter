part of 'toss_bloc.dart';

@immutable
abstract class TossEvent {}

class TossCoinSideSelectionEvent extends TossEvent {
  final CoinSide coinSide;

  TossCoinSideSelectionEvent(this.coinSide);
}

class TossNumberSelectionEvent extends TossEvent {
  final int number;

  TossNumberSelectionEvent(this.number);
}

class TossMakeDecisionEvent extends TossEvent {}
