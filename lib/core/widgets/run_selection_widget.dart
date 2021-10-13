import 'package:flutter/material.dart';

class RunSelectionGrid extends StatefulWidget {
  final Function(int number) onSelection;

  const RunSelectionGrid({Key? key, required this.onSelection})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RunSelectionGrid();
  }
}

class _RunSelectionGrid extends State<RunSelectionGrid> {
  int selectedNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          int score = index + 1;
          return Card(
            color: selectedNumber == score ? Colors.green : Colors.blueAccent,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedNumber = score;
                  widget.onSelection(selectedNumber);
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                child: Text(
                  "$score",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
