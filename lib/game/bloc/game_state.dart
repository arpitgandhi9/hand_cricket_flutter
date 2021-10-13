part of 'game_bloc.dart';

@immutable
abstract class GameState {
  final String openingTeamTitle;
  final String followTeamTitle;
  final String popupMessage;
  final int aiSelection;

  const GameState({
    required this.openingTeamTitle,
    required this.followTeamTitle,
    required this.popupMessage,
    required this.aiSelection,
  });
}

class GameInitial extends GameState {
  const GameInitial()
      : super(
          aiSelection: 0,
          followTeamTitle: "",
          openingTeamTitle: "",
          popupMessage: "",
        );
}

class GamePlayStartState extends GameState {
  const GamePlayStartState()
      : super(
          aiSelection: 0,
          followTeamTitle: "",
          openingTeamTitle: "",
          popupMessage: "",
        );
}

class GamePlayUpdateState extends GameState {
  const GamePlayUpdateState({
    required String openingTeamTitle,
    required String followTeamTitle,
    required String popupMessage,
    required int aiSelection,
  }) : super(
          aiSelection: aiSelection,
          followTeamTitle: followTeamTitle,
          openingTeamTitle: openingTeamTitle,
          popupMessage: popupMessage,
        );
}

class GameEndState extends GameState {
  const GameEndState()
      : super(
          aiSelection: 0,
          followTeamTitle: "",
          openingTeamTitle: "",
          popupMessage: "",
        );
}
