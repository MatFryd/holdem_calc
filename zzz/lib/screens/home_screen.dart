import 'package:flutter/material.dart';
import 'package:zzz/constants.dart';
import 'package:zzz/components/playing_card.dart';
import 'package:zzz/components/result_panel.dart';
import 'package:zzz/components/command_button.dart';
import 'package:zzz/logic/game.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> communityCards = List<int>.filled(5, 52);
  List<int> p1hand = [52, 52];
  List<int> p2hand = [52, 52];
  double p1odds = 47.97, p2odds = 47.97, splits = 4.07;

  void updateOdds() {
    List<int> results =
        Game.headsUp([p1hand[0], p1hand[1], p2hand[0], p2hand[1]]);
    setState(() {
      p1odds = 100 * results[0] / results[3];
      p2odds = 100 * results[1] / results[3];
      splits = 100 * results[2] / results[3];
    });
  }

  void clearTable() {
    setState(() {
      communityCards = List<int>.filled(5, 52);
      p1hand = [52, 52];
      p2hand = [52, 52];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeScreenBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 0, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('COMMUNITY CARDS', style: kTitleTextStyle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SelectPlayingCard(tableLocation: communityCards, index: 0),
                SelectPlayingCard(tableLocation: communityCards, index: 1),
                SelectPlayingCard(tableLocation: communityCards, index: 2),
                SelectPlayingCard(tableLocation: communityCards, index: 3),
                SelectPlayingCard(tableLocation: communityCards, index: 4),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('PLAYER 1', style: kTitleTextStyle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 7),
                SelectPlayingCard(tableLocation: p1hand, index: 0),
                SizedBox(width: 7),
                SelectPlayingCard(tableLocation: p1hand, index: 1),
                SizedBox(width: 30),
                Expanded(child: ResultPanel(winRate: p1odds, splitRate: splits))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('PLAYER 2', style: kTitleTextStyle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 7),
                SelectPlayingCard(tableLocation: p2hand, index: 0),
                SizedBox(width: 7),
                SelectPlayingCard(tableLocation: p2hand, index: 1),
                SizedBox(width: 30),
                Expanded(child: ResultPanel(winRate: p2odds, splitRate: splits))
              ],
            ),
            SizedBox(height: 30),
            Row(children: <Widget>[
              CommandButton(iconData: Icons.play_arrow, command: updateOdds),
              CommandButton(iconData: Icons.refresh, command: clearTable),
            ])
          ],
        ),
      ),
    );
  }
}
