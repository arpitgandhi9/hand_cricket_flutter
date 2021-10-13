import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/core.dart';
import '../landing/landing.dart';
import '../toss/toss.dart';
import 'game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GameScreen();
  }
}

class _GameScreen extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("You will lose the progress"),
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
                            Colors.redAccent,
                          ),
                        ),
                        child: const Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                });
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state is GameInitial) {
                return BlocProvider(
                  create: (context) => TossBloc(),
                  child: const TossScreen(),
                );
              }
              return _gamePlay(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _gamePlay(BuildContext context, GameState state) {
    return Column(
      children: [
        Text(
          state.openingTeamTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        Text(
          state.followTeamTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        Text(
          "AI selected ${state.aiSelection}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 40),
        RunSelectionGrid(onSelection: (number) {
          BlocProvider.of<GameBloc>(context).add(
            GameNumberSelectionEvent(context, selectedNumber: number),
          );
        }),
      ],
    );
  }
}
