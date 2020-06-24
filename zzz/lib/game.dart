import 'package:flutter/material.dart';

import 'card_utils.dart';
import 'scoring.dart';

class Game {
  static List<int> getDeckWithoutByNames(List<String> cardNames) =>
      getDeckWithout(CardUtils.toSerials(cardNames));

  static List<int> getDeckWithout(List<int> serials) {
    int i = 0, j = 0;
    List<int> deck = List<int>.filled(52 - serials.length, 0);
    bool clash;
    while (i < deck.length) {
      clash = false;
      for (int serial in serials) {
        if (j == serial) {
          j++;
          clash = true;
          break;
        }
      }
      if (!clash) deck[i++] = j++;
    }
    return deck;
  }

  static List<int> headsUpByNames(List<String> cardNames) =>
      headsUp(CardUtils.toSerials(cardNames));

  /*
	 * @param: cardNames - four card names representing the respective players' hands.
	 */
  static List<int> headsUp(List<int> serials) {
    int p1BestScore, p2BestScore, p1wins = 0, p2wins = 0, splits = 0;
    List<int> board, hand, deck = getDeckWithout(serials);
    int deckSize = 52 - serials.length, trials = 0;
    int i, j, k, m, n;

    board = new List<int>.filled(7, 0);

    for (i = 0; i < deckSize - 4; i++)
      for (j = i + 1; j < deckSize - 3; j++)
        for (k = j + 1; k < deckSize - 2; k++)
          for (m = k + 1; m < deckSize - 1; m++)
            for (n = m + 1; n < deckSize; n++) {
              trials++;
              board[0] = deck[i];
              board[1] = deck[j];
              board[2] = deck[k];
              board[3] = deck[m];
              board[4] = deck[n];

              board[5] = serials[0];
              board[6] = serials[1];

              hand = Scoring.bestHand(List<int>.from(board));
              p1BestScore = Scoring.score(hand);

              board[5] = serials[2];
              board[6] = serials[3];
              hand = Scoring.bestHand(board);
              p2BestScore = Scoring.score(hand);

              if (p1BestScore > p2BestScore)
                p1wins++;
              else if (p1BestScore == p2BestScore)
                splits++;
              else
                p2wins++;
            }

    print('\n\np1wins: ${(100 * p1wins / trials).toStringAsFixed(2)}\n'
        'p2wins: ${(100 * p2wins / trials).toStringAsFixed(2)}\n'
        'splits: ${(100 * splits / trials).toStringAsFixed(2)}');

    return [p1wins, p2wins, splits, trials];
  }

  static void shalosh(List<String> cardNames) {
    int p1BestScore, p2BestScore, p1wins = 0, p2wins = 0, splits = 0;
    int p1c1 = CardUtils.toSerial(cardNames[0]),
        p1c2 = CardUtils.toSerial(cardNames[1]),
        p1c3 = CardUtils.toSerial(cardNames[2]),
        p2c1 = CardUtils.toSerial(cardNames[3]),
        p2c2 = CardUtils.toSerial(cardNames[4]),
        p2c3 = CardUtils.toSerial(cardNames[5]);
    List<int> board, hand, deck;
    int deckSize = 52 - cardNames.length, trials = 0;

    deck = getDeckWithoutByNames(cardNames);
    board = List<int>.filled(8, 0);
    for (int i = 0; i < deckSize - 4; i++)
      for (int j = i + 1; j < deckSize - 3; j++)
        for (int k = j + 1; k < deckSize - 2; k++)
          for (int m = k + 1; m < deckSize - 1; m++)
            for (int n = m + 1; n < deckSize; n++) {
              trials++;
              board[0] = deck[i];
              board[1] = deck[j];
              board[2] = deck[k];
              board[3] = deck[m];
              board[4] = deck[n];

              board[5] = p1c1;
              board[6] = p1c2;
              board[7] = p1c3;
              hand = Scoring.bestHand(List<int>.from(board));
              p1BestScore = Scoring.score(hand);

              board[5] = p2c1;
              board[6] = p2c2;
              board[7] = p2c3;
              hand = Scoring.bestHand(board);
              p2BestScore = Scoring.score(hand);

              if (p1BestScore > p2BestScore)
                p1wins++;
              else if (p1BestScore == p2BestScore)
                splits++;
              else
                p2wins++;
            }
    print('\n\np1wins: ${(100 * p1wins / trials).toStringAsFixed(2)}\n'
        'p2wins: ${(100 * p2wins / trials).toStringAsFixed(2)}\n'
        'splits: ${(100 * splits / trials).toStringAsFixed(2)}');
  }
}
