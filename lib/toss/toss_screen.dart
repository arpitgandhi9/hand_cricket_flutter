import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/core.dart';
import 'toss.dart';

class TossScreen extends StatefulWidget {
  const TossScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TossScreen();
  }
}

class _TossScreen extends State<TossScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CoinSideSelectionToggle(
          onSelection: (side) {
            BlocProvider.of<TossBloc>(context).add(
              TossCoinSideSelectionEvent(side),
            );
          },
        ),
        const SizedBox(height: 40),
        RunSelectionGrid(
          onSelection: (number) {
            BlocProvider.of<TossBloc>(context).add(
              TossNumberSelectionEvent(number),
            );
          },
        ),
        Expanded(
          child: Container(),
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<TossBloc>(context).add(
              TossMakeDecisionEvent(context),
            );
          },
          child: const Text("Next"),
        ),
      ],
    );
  }
}
