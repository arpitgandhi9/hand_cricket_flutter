import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_cricket/game/game.dart';
import 'package:meta/meta.dart';

part 'toss_event.dart';
part 'toss_state.dart';

enum CoinSide { head, tail }

class TossBloc extends Bloc<TossEvent, TossState> {
  CoinSide selectedSide = CoinSide.head;
  int selectedNumber = 1;

  TossBloc() : super(TossInitial()) {
    on<TossEvent>(
      (event, emit) {
        if (event is TossCoinSideSelectionEvent) {
          selectedSide = event.coinSide;
        }

        if (event is TossNumberSelectionEvent) {
          selectedNumber = event.number;
        }

        if (event is TossMakeDecisionEvent) {
          BlocProvider.of<GameBloc>(event.context).add(
            GameTossResultEvent(
              event.context,
              coinSide: selectedSide,
              selectedNumber: selectedNumber,
            ),
          );
        }
      },
    );
  }
}
