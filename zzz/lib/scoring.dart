import 'card_utils.dart';

class Scoring {
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

  static const List<int> bases = [
    15 * 15 * 15 * 15 * 15,
    15 * 15 * 15 * 15,
    15 * 15 * 15,
    15 * 15,
    15,
    1
  ];

  static List<int> bestHand(List<int> cards) {
    int maxScore = 0, currScore = 0;
    List<int> maxHand = List<int>.filled(5, 0);
    List<int> currHand = List<int>.filled(5, 0);
    List<List<int>> indexSets = cards.length == 7 ? sevenIndices : eightIndices;

    cards.sort((a, b) => a % 13 - b % 13); // sort by rank
    for (List<int> indices in indexSets) {
      for (int i = 0; i < 5; i++) currHand[i] = cards[indices[i]];
      currScore = score(currHand);
      if (currScore > maxScore) {
        maxScore = currScore;
        maxHand = List<int>.from(currHand);
      }
    }
    return List<int>.from(maxHand);
  }

  /*
	 * 0 - high card
	 * 1 - pair
	 * 2 - two pair
	 * 3 - trips
	 * 4 - straight
	 * 5 - flush
	 * 6 - full house
	 * 7 - quads
	 * 8 - straight flush
   *
	 * assumes sorted hand
	 */
  static int score(List<int> hand) {
    List<int> ranks = CardUtils.getRanks(hand);
    int pairIndex;

    if ((pairIndex = isPair(ranks)) == -1) {
      // no pair
      if (isStraight(ranks) != -1) {
        if (isFlush(hand))
          return toScore([8, ranks[isStraight(ranks)]]);
        else
          return toScore([4, ranks[isStraight(ranks)]]);
      } else if (isFlush(hand))
        return toScore([5, ranks[4], ranks[3], ranks[2], ranks[1], ranks[0]]);
      else
        return toScore([0, ranks[4], ranks[3], ranks[2], ranks[1], ranks[0]]);
    } else { // isPair >= 0
      if (isQuads(ranks) != -1)
        return toScore([7, ranks[2], ranks[isQuads(ranks)]]);
      if (isFullHouse(ranks) != -1)
        return toScore([6, ranks[2], ranks[isFullHouse(ranks)]]);
      if (isTrips(ranks) != -1)
        return toScore([3, ranks[2], ranks[4], ranks[3], ranks[1], ranks[0]]);
      if (isTwoPair(ranks) != -1)
        return toScore([2, ranks[3], ranks[1], ranks[isTwoPair(ranks)]]);
      List<int> kickers = List<int>.filled(3, 0);
      for (int i = 0; i < 3; i++)
        kickers[i] = 4 - i > pairIndex + 1 ? 4 - i : 2 - i;
      return toScore([
        1,
        ranks[pairIndex],
        ranks[kickers[0]],
        ranks[kickers[1]],
        ranks[kickers[2]]
      ]);
    }
  }

  static int toScore(List<int> scoreValues) {
    if (scoreValues.length == 0) return 0;
    int ret = 0;
    for (int i = 0; i < scoreValues.length; i++)
      ret += scoreValues[i] * bases[i];

    return ret;
  }

  // return - kicker index
  static int isQuads(List<int> ranks) {
    if (ranks[0] == ranks[3]) return 4;
    if (ranks[1] == ranks[4]) return 0;
    return -1;
  }

  // return - pair index
  static int isFullHouse(List<int> ranks) {
    if (ranks[0] == ranks[2] && ranks[3] == ranks[4]) return 4;
    if (ranks[0] == ranks[1] && ranks[2] == ranks[4]) return 0;
    return -1;
  }

  // return - first trip index
  static int isTrips(List<int> ranks) {
    if (ranks[0] == ranks[2]) return 0;
    if (ranks[1] == ranks[3]) return 1;
    if (ranks[2] == ranks[4]) return 2;
    return -1;
  }

  // return - kicker index
  static int isTwoPair(List<int> ranks) {
    if (ranks[0] == ranks[1] && ranks[2] == ranks[3]) return 4;
    if (ranks[0] == ranks[1] && ranks[3] == ranks[4]) return 2;
    if (ranks[1] == ranks[2] && ranks[3] == ranks[4]) return 0;
    return -1;
  }

  // return - first pair index
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
