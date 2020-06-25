import 'package:flutter/material.dart';
import 'package:zzz/constants.dart';

class CommandButton extends StatelessWidget {
  CommandButton({this.iconData = Icons.refresh, @required this.command});

  final IconData iconData;
  final Function command;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: this.command,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
        height: 70,
        width: 70,
        child: Card(
          color: kAccentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 8,
          child: Icon(
            this.iconData,
            color: kOddsTextColor,
            size: 40,
          ),
        ),
      ),
    );
  }
}
