import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hand_cricket/game/game.dart';
import 'package:meta/meta.dart';

import '../../toss/toss.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late GameInformation _information;

  GameBloc() : super(GameInitial()) {
    on<GameEvent>((event, emit) {
      if (event is GameTossResultEvent) {
        _information = GameInformation();

        // Computer number selection
        int _aiSelection = Random().nextInt(6);

        // Check if the sum is even or odd
        CoinSide _determinedSide =
            (event.selectedNumber + _aiSelection) % 2 == 0
                ? CoinSide.tail
                : CoinSide.head;
        _information.tossWon = _determinedSide == event.coinSide;
      }
    });
  }
}
