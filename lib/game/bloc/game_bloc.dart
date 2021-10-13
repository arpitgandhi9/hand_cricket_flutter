import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hand_cricket/game/game.dart';
import 'package:meta/meta.dart';

import '../../toss/toss.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  // Change this to play with more than 2 players
  final int TOTAL_WICKETS = 2;

  late GameInformation _information;

  bool _isPlayerBatting = false;

  GameBloc() : super(GameInitial()) {
    on<GameEvent>((event, emit) {
      if (event is GameTossResultEvent) {
        _information = GameInformation();

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
        _isPlayerBatting = _information.tossWon;

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

      // TODO: compute the CPU and player score
      if (event is GameNumberSelectionEvent) {
        print(event.selectedNumber);
      }
    });
  }
}
