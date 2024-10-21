import 'dart:async';
import 'package:flutter/material.dart';

class MyMatchingGame extends StatefulWidget {
  @override
  _MyMatchingGameState createState() => _MyMatchingGameState();
}

class _MyMatchingGameState extends State<MyMatchingGame> {
  List<String> cards = [
    'assets/images/chape1.png',
    'assets/images/chape1.png',
    'assets/images/chape2.png',
    'assets/images/chape2.png',
    'assets/images/shap3.png',
    'assets/images/shap3.png',
    'assets/images/shape4.jpg',
    'assets/images/shape4.jpg',
    'assets/images/shape5.png',
    'assets/images/shape5.png',
    'assets/images/shape6.png',
    'assets/images/shape6.png',
  ];
  List<int> flippedIndexes = [];
  List<int> matchedIndexes = [];
  bool isComparing = false;

  @override
  void initState() {
    super.initState();
    cards.shuffle();
  }

  void _onCardTap(int index) {
    if (isComparing ||
        flippedIndexes.contains(index) ||
        matchedIndexes.contains(index)) return;

    setState(() {
      flippedIndexes.add(index);
    });
    if (flippedIndexes.length == 2) {
      isComparing = true;
      Timer(Duration(seconds: 1), () {
        _compareCards();
      });
    }
  }

  void _compareCards() {
    int index1 = flippedIndexes[0];
    int index2 = flippedIndexes[1];
    if (cards[index1] != cards[index2]) {
      // Cards don't match, flip them back
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          flippedIndexes.removeLast();
          flippedIndexes.removeLast();
        });
        isComparing = false;
      });
    } else {
      setState(() {
        matchedIndexes.addAll(flippedIndexes); // Add matched indexes
        flippedIndexes.clear(); // Clear the flipped indexes
      });
      isComparing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Game'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _onCardTap(index),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        flippedIndexes.contains(index) || matchedIndexes.contains(index)
                            ? cards[index]
                            : 'assets/images/black.png',
                      ),
                      fit: BoxFit.cover,
                    ),
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


