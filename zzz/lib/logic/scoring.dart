import 'card_utils.dart';

class Scoring {
  /// All possible distinct 5 indices out of 7
  static const List<List<int>> sevenIndices = [
    [0, 1, 2, 3, 4],
    [0, 1, 2, 3, 5],
    [0, 1, 2, 3, 6],
    [0, 1, 2, 4, 5],
    [0, 1, 2, 4, 6],
    [0, 1, 2, 5, 6],
    [0, 1, 3, 4, 5],
    [0, 1, 3, 4, 6],
    [0, 1, 3, 5, 6],
    [0, 1, 4, 5, 6],
    [0, 2, 3, 4, 5],
    [0, 2, 3, 4, 6],
    [0, 2, 3, 5, 6],
    [0, 2, 4, 5, 6],
    [0, 3, 4, 5, 6],
    [1, 2, 3, 4, 5],
    [1, 2, 3, 4, 6],
    [1, 2, 3, 5, 6],
    [1, 2, 4, 5, 6],
    [1, 3, 4, 5, 6],
    [2, 3, 4, 5, 6]
  ];

  /// All possible distinct 5 indices out of 8
  static const List<List<int>> eightIndices = [
    [0, 1, 2, 3, 4],
    [0, 1, 2, 3, 5],
    [0, 1, 2, 3, 6],
    [0, 1, 2, 3, 7],
    [0, 1, 2, 4, 5],
    [0, 1, 2, 4, 6],
    [0, 1, 2, 4, 7],
    [0, 1, 2, 5, 6],
    [0, 1, 2, 5, 7],
    [0, 1, 2, 6, 7],
    [0, 1, 3, 4, 5],
    [0, 1, 3, 4, 6],
    [0, 1, 3, 4, 7],
    [0, 1, 3, 5, 6],
    [0, 1, 3, 5, 7],
    [0, 1, 3, 6, 7],
    [0, 1, 4, 5, 6],
    [0, 1, 4, 5, 7],
    [0, 1, 4, 6, 7],
    [0, 1, 5, 6, 7],
    [0, 2, 3, 4, 5],
    [0, 2, 3, 4, 6],
    [0, 2, 3, 4, 7],
    [0, 2, 3, 5, 6],
    [0, 2, 3, 5, 7],
    [0, 2, 3, 6, 7],
    [0, 2, 4, 5, 6],
    [0, 2, 4, 5, 7],
    [0, 2, 4, 6, 7],
    [0, 2, 5, 6, 7],
    [0, 3, 4, 5, 6],
    [0, 3, 4, 5, 7],
    [0, 3, 4, 6, 7],
    [0, 3, 5, 6, 7],
    [0, 4, 5, 6, 7],
    [1, 2, 3, 4, 5],
    [1, 2, 3, 4, 6],
    [1, 2, 3, 4, 7],
    [1, 2, 3, 5, 6],
    [1, 2, 3, 5, 7],
    [1, 2, 3, 6, 7],
    [1, 2, 4, 5, 6],
    [1, 2, 4, 5, 7],
    [1, 2, 4, 6, 7],
    [1, 2, 5, 6, 7],
    [1, 3, 4, 5, 6],
    [1, 3, 4, 5, 7],
    [1, 3, 4, 6, 7],
    [1, 3, 5, 6, 7],
    [1, 4, 5, 6, 7],
    [2, 3, 4, 5, 6],
    [2, 3, 4, 5, 7],
    [2, 3, 4, 6, 7],
    [2, 3, 5, 6, 7],
    [2, 4, 5, 6, 7],
    [3, 4, 5, 6, 7]
  ];

  /// Helps format scores
  static const List<int> bases = [
    15 * 15 * 15 * 15 * 15,
    15 * 15 * 15 * 15,
    15 * 15 * 15,
    15 * 15,
    15,
    1
  ];

  /// [return] - The score of the best 5-card hand among the 7/8 given cards.
  ///
  /// [params]:
  ///
  /// [cards] - A list of 7 or 8 distinct serials.
  ///
  /// Sorts the list by rank.
  static int bestScore(List<int> cards) {
    int maxScore = 0, currScore = 0;
    List<int> currHand = List<int>.filled(5, 0);
    List<List<int>> indexSets = cards.length == 8 ? eightIndices : sevenIndices;

    cards.sort((a, b) => a % 13 - b % 13); // Sort by rank
    for (List<int> indices in indexSets) {
      for (int i = 0; i < 5; i++) currHand[i] = cards[indices[i]];
      if ((currScore = score(currHand)) > maxScore) maxScore = currScore;
    }
    return maxScore;
  }

  /// [return] - The value of the input hand. Stronger poker hands have higher values.
  ///
  /// [param] - A sorted 5-card poker hand.
  ///
  ///	 * 0 - High Card
  ///  * 1 - Pair
  ///  * 2 - Two Pair
  ///	 * 3 - Trips
  ///	 * 4 - Straight
  ///	 * 5 - Flush
  ///	 * 6 - Full House
  ///	 * 7 - Quads
  ///	 * 8 - Straight Flush
  static int score(List<int> hand) {
    List<int> ranks = CardUtils.getRanks(hand);
    int pairIndex, temp;

    if ((pairIndex = isPair(ranks)) == -1) {
      // no pair

      if ((temp = isStraight(ranks)) != -1) {
        if (isFlush(hand)) // Straight Flush
          return toScore([8, ranks[temp]]);
        else // Straight
          return toScore([4, ranks[temp]]);
      } else if (isFlush(hand)) // Flush
        return toScore([5, ranks[4], ranks[3], ranks[2], ranks[1], ranks[0]]);
      else // High Card
        return toScore([0, ranks[4], ranks[3], ranks[2], ranks[1], ranks[0]]);
    } else {
      // isPair >= 0

      if ((temp = isQuads(ranks)) != -1)
        return toScore([7, ranks[2], ranks[temp]]);

      if ((temp = isFullHouse(ranks)) != -1)
        return toScore([6, ranks[2], ranks[temp]]);

      if (isTrips(ranks))
        return toScore([3, ranks[2], ranks[4], ranks[3], ranks[1], ranks[0]]);

      if ((temp = isTwoPair(ranks)) != -1)
        return toScore([2, ranks[3], ranks[1], ranks[temp]]);

      // Pair
      return toScore([
        1,
        ranks[pairIndex],
        ranks[pairIndex == 3 ? 2 : 4],
        ranks[pairIndex > 1 ? 1 : 3],
        ranks[pairIndex != 0 ? 0 : 2]
      ]);
    }
  }

  /// [return] - A score based on the lexicographic
  /// value of the input list, MSD first.
  static int toScore(List<int> scoreValues) {
    if (scoreValues.length == 0) return 0;
    int ret = 0;
    for (int i = 0; i < scoreValues.length; i++)
      ret += scoreValues[i] * bases[i];

    return ret;
  }

  /// [return] - -1 if no quads, kicker index otherwise.
  static int isQuads(List<int> ranks) {
    if (ranks[0] == ranks[3]) return 4;
    if (ranks[1] == ranks[4]) return 0;
    return -1;
  }

  /// [return] - -1 if no full house, a pair index otherwise.
  static int isFullHouse(List<int> ranks) {
    if (ranks[0] == ranks[2] && ranks[3] == ranks[4]) return 4;
    if (ranks[0] == ranks[1] && ranks[2] == ranks[4]) return 0;
    return -1;
  }

  static bool isTrips(List<int> ranks) {
    return (ranks[0] == ranks[2]) ||
        (ranks[1] == ranks[3]) ||
        (ranks[2] == ranks[4]);
  }

  /// [return] - -1 if no two pair, kicker index otherwise.
  static int isTwoPair(List<int> ranks) {
    if (ranks[0] == ranks[1] && ranks[2] == ranks[3]) return 4;
    if (ranks[0] == ranks[1] && ranks[3] == ranks[4]) return 2;
    if (ranks[1] == ranks[2] && ranks[3] == ranks[4]) return 0;
    return -1;
  }

  /// [return] - -1 if no pair, first pair index otherwise.
  static int isPair(List<int> ranks) {
    for (int i = 0; i < 4; i++) if (ranks[i] == ranks[i + 1]) return i;
    return -1;
  }

  /*
	 * assumes distinct ranks.
	 * return - straight top index
	 */
  static int isStraight(List<int> ranks) {
    if (ranks[4] - ranks[0] == 4) return 4;
    if (ranks[4] == 14 && ranks[3] == 5) return 3; // Wheel
    return -1;
  }

  static bool isFlush(List<int> hand) {
    for (int i = 1; i < 5; i++)
      if (hand[0] ~/ 13 != hand[i] ~/ 13) return false;
    return true;
  }
}
