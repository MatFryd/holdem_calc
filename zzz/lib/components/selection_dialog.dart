import 'package:flutter/material.dart';
import 'playing_card.dart';
import 'package:zzz/constants.dart';

class SelectionDialog extends StatefulWidget {
  SelectionDialog({@required this.setter, @required this.serial});

  final Function setter;
  final int serial;

  @override
  _SelectionDialogState createState() => _SelectionDialogState(serial);
}

class _SelectionDialogState extends State<SelectionDialog> {
  int selectedSuit;

  _SelectionDialogState(int serial) {
    selectedSuit = (serial ~/ 13) % 4;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            color: kActiveSuitTabColor,
            width: double.infinity,
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 80,
                  color: kAccentColor,
                  child: Row(
                    // Suit Row
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 10),
                      SuitTab(
                        isSelected: selectedSuit == 0,
                        suit: 0,
                        onTap: () {
                          setState(() {
                            selectedSuit = 0;
                          });
                        },
                      ),
                      SuitTab(
                        isSelected: selectedSuit == 1,
                        suit: 1,
                        onTap: () {
                          setState(() {
                            selectedSuit = 1;
                          });
                        },
                      ),
                      SuitTab(
                        isSelected: selectedSuit == 2,
                        suit: 2,
                        onTap: () {
                          setState(() {
                            selectedSuit = 2;
                          });
                        },
                      ),
                      SuitTab(
                        isSelected: selectedSuit == 3,
                        suit: 3,
                        onTap: () {
                          setState(() {
                            selectedSuit = 3;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 12, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 11, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 10, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 9, setter: widget.setter),
                    SizedBox(height: kCardHeight, width: kCardWidth)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 8, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 7, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 6, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 5, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 4, setter: widget.setter),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 3, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 2, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit + 1, setter: widget.setter),
                    SetPlayingCard(
                        serial: 13 * selectedSuit, setter: widget.setter),
                    SetPlayingCard(serial: 52, setter: widget.setter),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class SuitTab extends StatefulWidget {
  @override
  _SuitTabState createState() => _SuitTabState();

  final int suit;
  final bool isSelected;
  final Function onTap;

  SuitTab({@required this.suit, this.isSelected = false, @required this.onTap});
}

class _SuitTabState extends State<SuitTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Container(
        height: 60,
        width: 70,
        color: widget.isSelected ? kActiveSuitTabColor : kInactiveSuitTabColor,
        child: kSuitIcons[widget.suit],
      ),
    );
  }
}
