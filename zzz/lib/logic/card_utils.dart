import 'dart:core';

class CardUtils {
  static final List<String> suitNames = ['c', 'd', 's', 'h', '?'];

  static final List<String> rankNames = [
    '-',
    '-',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'T',
    'J',
    'Q',
    'K',
    'A'
  ];

  static String toCardName(int card) {
    return '${rankNames[card % 13 + 2]}${suitNames[card ~/ 13]}';
  }

  static int toSerial(String cardName) {
    return 13 * suitNames.indexOf(cardName[1]) +
        suitNames.indexOf(cardName[0]) -
        2;
  }

  static List<String> toCardNames(List<int> serials) {
    List<String> cardNames = List<String>.filled(serials.length, '');
    for (int i = 0; i < serials.length; i++)
      cardNames[i] = toCardName(serials[i]);
    return cardNames;
  }

  static List<int> toSerials(List<String> cardNames) {
    List<int> serials = List<int>.filled(cardNames.length, 0);
    for (int i = 0; i < cardNames.length; i++)
      serials[i] = toSerial(cardNames[i]);
    return serials;
  }

  static void printNames(List<String> cardNames) {
    String s = '[ ';
    for (String cardName in cardNames) s += '$cardName,';
    print('${s.substring(0, s.length - 2)} ]');
  }

  static void printNamesBySerial(List<int> serials) {
    printNames(toCardNames(serials));
  }

  static void printScore(int score) {
    int s = score;
    String ret = '';
    for (int i = 0; i < 6; i++) {
      ret = '${s % 15}|$ret';
      s = s ~/ 15;
    }
    print(ret);
  }

  /// [return] - The input hand's ranks, order unchanged
  static List<int> getRanks(List<int> hand) {
    List<int> ranks = List<int>.filled(5, 0);
    for (int i = 0; i < 5; i++) ranks[i] = hand[i] % 13 + 2;
    return ranks;
  }
}
