import 'package:flutter/material.dart';
import 'file:///C:/Users/MattFryd/000AndroidStudioProjects/zzz/lib/components/card_suit_icons.dart';

const double kCardWidth = 60.0;
const double kCardHeight = 85.0;
const double kSuitSize = 20.0;

final Color kHomeScreenBackgroundColor = Colors.blue;
final Color kRed = Colors.red.shade600;
final Color kActiveSuitTabColor = Colors.lightBlueAccent.shade100;
final Color kInactiveSuitTabColor = Colors.lightBlueAccent.shade400;
final Color kAccentColor = Colors.blue.shade100;
final Color kOddsTextColor = Colors.black;

const TextStyle kRankTextStyle =
    TextStyle(fontSize: 30, fontFamily: 'Spartan', fontWeight: FontWeight.w900);

const TextStyle kTitleTextStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900);

final List<Icon> kSuitIcons = [
  Icon(CardSuitIcons.club, color: Colors.black, size: kSuitSize),
  Icon(CardSuitIcons.diamond, color: kRed, size: kSuitSize),
  Icon(CardSuitIcons.spade, color: Colors.black, size: kSuitSize),
  Icon(CardSuitIcons.heart, color: kRed, size: kSuitSize)
];
