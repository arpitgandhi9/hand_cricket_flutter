import 'package:flutter/material.dart';
import 'package:hand_cricket/game/game.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HighlightsScreen extends StatelessWidget {
  const HighlightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GameInformation> list =
        Hive.box<GameInformation>("history").values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Highlights"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          GameInformation gi = list[index];
          return Card(
            clipBehavior: Clip.hardEdge,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _userSide("You", gi.userPlayers),
                  const Text(
                    " vs ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _userSide("AI", gi.aiPlayers),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _userSide(String title, List<PlayerInformation> players) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            _playerScoreList(players),
          ],
        ),
      ),
    );
  }

  Widget _playerScoreList(List<PlayerInformation> players) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: players.length,
      itemBuilder: (context, index) {
        PlayerInformation p = players[index];
        return Text(
          "P${index + 1}: ${p.runs} runs in ${p.balls} Balls",
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
