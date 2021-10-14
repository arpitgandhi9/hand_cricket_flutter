import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_cricket/highlights/highlights.dart';

import '../game/game.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Image(
                fit: BoxFit.fitWidth,
                image: AssetImage("images/cricket.png"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => GameBloc(),
                        child: const GameScreen(),
                      );
                    },
                  ),
                );
              },
              child: const Text("Start Game"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HighlightsScreen();
                    },
                  ),
                );
              },
              child: const Text("Highlights"),
            ),
          ],
        ),
      ),
    );
  }
}
