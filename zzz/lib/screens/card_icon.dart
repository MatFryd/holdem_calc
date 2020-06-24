import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zzz/constants.dart';
import 'package:zzz/card_suit_icons_icons.dart';
import 'package:zzz/card_utils.dart';
import 'package:zzz/screens/selection_dialog.dart';
import 'selection_dialog.dart';

class CardIcon extends StatelessWidget {
  int serial;
  String suit;
  String rank;
  Function onTap;

  CardIcon(
      {this.serial = -1,
      this.suit = '',
      this.rank = '',
      @required this.onTap}) {
    if (this.serial == -1 && (this.suit == '' || this.rank == ''))
      print('Card Format Error');
    else if (this.serial != -1) {
      this.rank = CardUtils.rankNames[serial % 13 + 2];
      this.suit = CardUtils.suitNames[serial ~/ 13];
    } else
      this.serial = 13 * CardUtils.indexOf(CardUtils.suitNames, this.suit) +
          CardUtils.indexOf(CardUtils.rankNames, this.rank) -
          2;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
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
                      this.rank == 'T' ? '10' : this.rank,
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

class SelectCardIcon extends StatefulWidget {
  SelectCardIcon({@required this.serial, this.setter});

  final Function setter;
  final int serial;

  @override
  _SelectCardIconState createState() => _SelectCardIconState();
}

class _SelectCardIconState extends State<SelectCardIcon> {
  @override
  Widget build(BuildContext context) {
    return CardIcon(
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
