import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzz/constants.dart';
import 'package:zzz/screens/card_icon.dart';
import 'selection_dialog.dart';
import 'package:zzz/game.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> communityCards = List<int>.filled(5, 52);
  List<int> p1hand = [52, 52];
  List<int> p2hand = [52, 52];
  double p1odds = 50, p2odds = 50, splits = 0;

  void updateOdds() {
    List<int> results =
        Game.headsUp([p1hand[0], p1hand[1], p2hand[0], p2hand[1]]);
    setState(() {
      p1odds = 100 * results[0] / results[3];
      p2odds = 100 * results[1] / results[3];
      splits = 100 * results[2] / results[3];
    });
  }

  void openDialogFor({Function setter}) {
    showDialog(
      context: context,
      builder: (context) => SelectionDialog(
        setter: (value) {
          setState(() {
            setter(value);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 0,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'COMMUNITY CARDS',
                style: kTitleTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CardIcon(
                  serial: communityCards[0],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      communityCards[0] = value;
                    });
                  },
                ),
                CardIcon(
                  serial: communityCards[1],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      communityCards[1] = value;
                    });
                  },
                ),
                CardIcon(
                  serial: communityCards[2],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      communityCards[2] = value;
                    });
                  },
                ),
                CardIcon(
                  serial: communityCards[3],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      communityCards[3] = value;
                    });
                  },
                ),
                CardIcon(
                  serial: communityCards[4],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      communityCards[4] = value;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'PLAYER 1',
                style: kTitleTextStyle,
              ),
            ),
            Row(
              children: <Widget>[
                CardIcon(
                  serial: p1hand[0],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      p1hand[0] = value;
                    });
                  },
                ),
                CardIcon(
                  serial: p1hand[1],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      p1hand[1] = value;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'PLAYER 2',
                style: kTitleTextStyle,
              ),
            ),
            Row(
              children: <Widget>[
                CardIcon(
                  serial: p2hand[0],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      p2hand[0] = value;
                    });
                  },
                ),
                CardIcon(
                  serial: p2hand[1],
                  onTap: () {
                    openDialogFor(setter: (value) {
                      p2hand[1] = value;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: Colors.orangeAccent,
                    width: 200,
                    height: kCardHeight,
                    child: Center(
                      child: Text(
                        'win: ${p2odds.toStringAsFixed(2)}%\n'
                        'split: ${splits.toStringAsFixed(2)}%',
                        style: kTitleTextStyle,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    updateOdds();
//                    communityCards = List<int>.filled(5, 52);
//                    p1hand = [52, 52];
//                    p2hand = [52, 52];
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 80,
                  width: 80,
                  color: Colors.orange.shade300,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
