part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GamePlayStartState extends GameState {}
