import 'package:flutter/material.dart';
import 'package:hand_cricket/toss/toss.dart';

class CoinSideSelectionToggle extends StatefulWidget {
  final Function(CoinSide side) onSelection;

  const CoinSideSelectionToggle({Key? key, required this.onSelection})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CoinSideSelectionToggle();
  }
}

class _CoinSideSelectionToggle extends State<CoinSideSelectionToggle> {
  CoinSide selectedSide = CoinSide.head;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: GridView.builder(
        itemCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
        ),
        itemBuilder: (context, index) {
          bool isSelected = index == 0 && selectedSide == CoinSide.head ||
              index == 1 && selectedSide == CoinSide.tail;
          return Card(
            color: isSelected ? Colors.green : Colors.blueAccent,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedSide = CoinSide.tail;
                  if (index == 0) {
                    selectedSide = CoinSide.head;
                  }
                  widget.onSelection(selectedSide);
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                child: Text(
                  index == 0 ? "Head (Odd)" : "Tail (Even)",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
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
