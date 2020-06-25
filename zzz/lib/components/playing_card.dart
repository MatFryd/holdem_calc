import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zzz/constants.dart';
import 'file:///C:/Users/MattFryd/000AndroidStudioProjects/zzz/lib/logic/card_utils.dart';
import 'selection_dialog.dart';

class PlayingCard extends StatelessWidget {
  final int serial;
  final Function onTap;

  PlayingCard({@required this.serial, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6),
      elevation: 8.0,
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: this.onTap,
        child: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          width: kCardWidth,
          height: kCardHeight,
          child: this.serial == 52
              ? Center(child: Icon(FontAwesomeIcons.question))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      CardUtils.rankNames[(serial % 13 + 2)] == 'T'
                          ? '10'
                          : CardUtils.rankNames[(serial % 13 + 2)],
                      style: kRankTextStyle.copyWith(
                        color:
                            (this.serial ~/ 13) % 2 == 0 ? Colors.black : kRed,
                      ),
                    ),
                    kSuitIcons[this.serial ~/ 13]
                  ],
                ),
        ),
      ),
    );
  }
}

/// A CardIcon whose purpose is to pick a card for the the tapped location.
class SelectPlayingCard extends StatefulWidget {
  SelectPlayingCard({@required this.tableLocation, @required this.index});

  final List<int> tableLocation;
  final int index;

  @override
  _SelectPlayingCardState createState() => _SelectPlayingCardState();
}

class _SelectPlayingCardState extends State<SelectPlayingCard> {
  @override
  Widget build(BuildContext context) {
    return PlayingCard(
        serial: widget.tableLocation[widget.index],
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => SelectionDialog(
                  serial: widget.tableLocation[widget.index],
                  setter: (value) {
                    setState(() {
                      widget.tableLocation[widget.index] = value;
                    });
                  }));
        });
  }
}

/// A CardIcon whose purpose is to set the
/// tapped card as a value of some variable.
class SetPlayingCard extends StatefulWidget {
  SetPlayingCard({@required this.serial, this.setter});

  final Function setter;
  final int serial;

  @override
  _SetPlayingCardState createState() => _SetPlayingCardState();
}

class _SetPlayingCardState extends State<SetPlayingCard> {
  @override
  Widget build(BuildContext context) {
    return PlayingCard(
      serial: widget.serial,
      onTap: () {
        setState(() {
          widget.setter(widget.serial);
          Navigator.pop(context);
        });
      },
    );
  }
}
