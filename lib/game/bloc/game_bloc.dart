import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../landing/landing.dart';
import 'package:meta/meta.dart';

import '../../toss/toss.dart';
import '../game.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  // Change this to play with more than 2 players
  final int TOTAL_WICKETS = 2;

  late GameInformation _information;

  bool _isUserBatting = false;
  int _wicketsTaken = 0;

  GameBloc() : super(const GameInitial()) {
    on<GameEvent>(
      (event, emit) {
        if (event is GameTossResultEvent) {
          _information = GameInformation();

          Hive.registerAdapter(GameInformationAdapter());
          Hive.registerAdapter(PlayerInformationAdapter());

          // Computer number selection + 1 to start from 1
          int _aiSelection = Random().nextInt(6) + 1;
          print("AI: $_aiSelection");
          print("User: ${event.selectedNumber}");

          // Check if the sum is even or odd
          CoinSide _determinedSide =
              (event.selectedNumber + _aiSelection) % 2 == 0
                  ? CoinSide.tail
                  : CoinSide.head;
          _information.tossWon = _determinedSide == event.coinSide;
          _isUserBatting = _information.tossWon;

          showDialog(
            context: event.context,
            builder: (context) {
              return AlertDialog(
                title: Text(_information.tossWon ? "You Bat! 🎉" : "AI bats"),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.greenAccent,
                      ),
                    ),
                    child: const Text("Let's Play!"),
                  ),
                ],
              );
            },
          );
          emit(const GamePlayStartState());
        }

        if (event is GameNumberSelectionEvent) {
          int _aiSelection = Random().nextInt(6) + 1;

          print("AI: $_aiSelection");
          print("User: ${event.selectedNumber}");

          // Init list item
          if (_isUserBatting) {
            if (_information.userPlayers.isEmpty) {
              _information.userPlayers.add(PlayerInformation());
            }
          } else if (_information.aiPlayers.isEmpty) {
            _information.aiPlayers.add(PlayerInformation());
          }

          emit(
            _computeScores(
              event.context,
              aiSelection: _aiSelection,
              userSelection: event.selectedNumber,
            ),
          );
        }
      },
    );
  }

  GameState _computeScores(
    BuildContext context, {
    required int aiSelection,
    required int userSelection,
  }) {
    bool isOut = aiSelection == userSelection;

    if (isOut) {
      // Mark out
      if (_isUserBatting) {
        _information.userPlayers = _markOut(_information.userPlayers);
      } else {
        _information.aiPlayers = _markOut(_information.aiPlayers);
      }
    }

    int openingTeamScore = 0;
    int followTeamScore = 0;

    int openingTeamWickets = 0;
    int followTeamWickets = 0;

    String followTeamTitle = "";
    String openingTeamTitle = "";

    if (_information.tossWon) {
      openingTeamTitle = "User ";
      followTeamTitle = "AI ";
    } else {
      openingTeamTitle = "AI ";
      followTeamTitle = "User ";
    }

    _updateScore(bool isOpeningTeam, PlayerInformation e) {
      if (isOpeningTeam) {
        openingTeamScore += e.runs;
        if (!e.isPlaying) {
          openingTeamWickets += 1;
        }
      } else {
        followTeamScore += e.runs;
        if (!e.isPlaying) {
          followTeamWickets += 1;
        }
      }
    }

    for (var i = 0; i < _information.userPlayers.length; i++) {
      if (!isOut && _isUserBatting && _information.userPlayers[i].isPlaying) {
        _information.userPlayers[i].runs += userSelection;
      }
      _updateScore(_information.tossWon, _information.userPlayers[i]);
    }

    for (var i = 0; i < _information.aiPlayers.length; i++) {
      if (!isOut && !_isUserBatting && _information.aiPlayers[i].isPlaying) {
        _information.aiPlayers[i].runs += aiSelection;
      }
      _updateScore(!_information.tossWon, _information.aiPlayers[i]);
    }

    openingTeamTitle +=
        "Total Run: $openingTeamScore Wickets: $openingTeamWickets";
    followTeamTitle +=
        "Total Run: $followTeamScore Wickets: $followTeamWickets";

    // END Game
    if (_wicketsTaken == TOTAL_WICKETS * 2) {
      // Store match history for future
      Hive.openBox('history').then((value) {
        value.add(_information);
        _information.save();

        print("Saved");
      });

      int winDiff = (openingTeamScore - followTeamScore).abs();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: Text(
                  openingTeamScore > followTeamScore && _information.tossWon
                      ? "You win by $winDiff!! 🎉"
                      : "You lost randomly 😜 by $winDiff"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LandingScreen();
                        },
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                  ),
                  child: const Text('Play again!'),
                ),
              ],
            );
          });
      return const GameEndState();
    }

    return GamePlayUpdateState(
        aiSelection: aiSelection,
        followTeamTitle: followTeamTitle,
        openingTeamTitle: openingTeamTitle,
        popupMessage: isOut ? "Wicket" : "score");
  }

  List<PlayerInformation> _markOut(List<PlayerInformation> currentList) {
    _wicketsTaken += 1;
    currentList = currentList.map((e) => e..isPlaying = false).toList();

    // Match over
    if (_wicketsTaken == TOTAL_WICKETS * 2) {
      return currentList;
    }

    if (_wicketsTaken == TOTAL_WICKETS) {
      // New innings
      _isUserBatting = !_isUserBatting;
    } else {
      currentList.add(PlayerInformation());
    }
    return currentList;
  }
}
