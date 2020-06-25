import 'package:flutter/material.dart';
import 'package:zzz/constants.dart';

class ResultPanel extends StatelessWidget {
  ResultPanel({@required this.winRate, @required this.splitRate});

  final double winRate, splitRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      height: kCardHeight,
      child: Card(
        color: kAccentColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 8,
        child: Center(
          child: Text(
            'win: ${winRate.toStringAsFixed(2)}%\n'
            'split: ${splitRate.toStringAsFixed(2)}%',
            style:
                kTitleTextStyle.copyWith(color: kOddsTextColor, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
