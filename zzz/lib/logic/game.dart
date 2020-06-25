import 'scoring.dart';

class Game {
  /// Runs a round of poker between two players, each having two 'hole cards'.
  ///
  /// [param]:
  ///
  /// serials[[0..1]] = p1 hole cards,
  ///
  /// serials[[2..3]] = p2 hole cards,
  ///
  /// serials[[4..]] = discarded cards.
  ///
  /// [return] - [[player 1 wins, player 2 wins, splits, total board count]]
  ///
  /// Assumes distinct arguments.
  static List<int> headsUp(List<int> serials) {
    int p1BestScore, p2BestScore, p1wins = 0, p2wins = 0, splits = 0;
    List<int> board = List<int>.filled(7, 0), deck = getDeckWithout(serials);
    int deckSize = 52 - serials.length, trials = 0;
    int i, j, k, m, n;

    // Run through all possible 5-card boards
    for (i = 0; i < deckSize - 4; i++) {
      board[0] = deck[i];
      for (j = i + 1; j < deckSize - 3; j++) {
        board[1] = deck[j];
        for (k = j + 1; k < deckSize - 2; k++) {
          board[2] = deck[k];
          for (m = k + 1; m < deckSize - 1; m++) {
            board[3] = deck[m];
            for (n = m + 1; n < deckSize; n++) {
              board[4] = deck[n];

              trials++;

              // Player 1 hole cards
              board[5] = serials[0];
              board[6] = serials[1];
              p1BestScore = Scoring.bestScore(board);

              // Player 2 hole cards
              board[5] = serials[2];
              board[6] = serials[3];
              p2BestScore = Scoring.bestScore(board);

              if (p1BestScore > p2BestScore)
                p1wins++;
              else if (p1BestScore == p2BestScore)
                splits++;
              else
                p2wins++;
            }
          }
        }
      }
    }

    print('p1wins: ${(100 * p1wins / trials).toStringAsFixed(2)}\n'
        'p2wins: ${(100 * p2wins / trials).toStringAsFixed(2)}\n'
        'splits: ${(100 * splits / trials).toStringAsFixed(2)}');

    return [p1wins, p2wins, splits, trials];
  }

  /// Runs a round of poker between two players, each having three 'hole cards'.
  ///
  /// [param]:
  ///
  /// serials[[0..2]] = p1 hole cards,
  ///
  /// serials[[3..5]] = p2 hole cards,
  ///
  /// serials[[6..]] ... = discarded cards.
  ///
  /// [return] - [[player 1 wins, player 2 wins, splits, total board count]]
  ///
  /// Assumes distinct arguments.
  static List<int> shalosh(List<int> serials) {
    int p1BestScore, p2BestScore, p1wins = 0, p2wins = 0, splits = 0;
    List<int> board = List<int>.filled(8, 0), deck = getDeckWithout(serials);
    int deckSize = 52 - serials.length, trials = 0;

    // Run through all possible 5-card boards
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

              // Player 1 hole cards
              board[5] = serials[0];
              board[6] = serials[1];
              board[7] = serials[2];
              p1BestScore = Scoring.bestScore(List<int>.from(board));

              // Player 2 hole cards
              board[5] = serials[3];
              board[6] = serials[4];
              board[7] = serials[5];
              p2BestScore = Scoring.bestScore(board);

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

  /// [return] - an ordered List<int> of serials representing a
  /// deck of cards and excluding the serials given as arguments.
  ///
  /// Assumes distinct arguments.
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
}
